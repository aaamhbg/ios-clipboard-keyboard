//
//  ClipboardStore.swift
//  ClipboardApp & ClipboardKeyboard
//

import Foundation
import UIKit
import Combine

/// مدير التخزين والحافظة المشترك بين التطبيق ولوحة المفاتيح
public final class ClipboardStore: ObservableObject {
    public static let shared = ClipboardStore()
    
    @Published public private(set) var clips: [ClipItem] = []
    @Published public var isAppGroupAvailable: Bool = false
    
    private let fileQueue = DispatchQueue(label: "com.clipboard.store.queue", qos: .userInitiated)
    
    private init() {
        checkAppGroupStatus()
        loadClips()
        setupDarwinObserver()
        populateSampleDataIfEmpty()
    }
    
    deinit {
        CFNotificationCenterRemoveEveryObserver(
            CFNotificationCenterGetDarwinNotifyCenter(),
            Unmanaged.passUnretained(self).toOpaque()
        )
    }
    
    // MARK: - App Group & File URL
    
    private func checkAppGroupStatus() {
        if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppConfig.appGroupID) {
            self.isAppGroupAvailable = FileManager.default.isWritableFile(atPath: containerURL.path)
        } else {
            self.isAppGroupAvailable = false
        }
    }
    
    /// الحصول على مسار ملف الحفظ (سواء المشترك أو المحلي كبديل آمن)
    private var storageFileURL: URL {
        if let sharedContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AppConfig.appGroupID) {
            return sharedContainer.appendingPathComponent(AppConfig.storageFileName)
        }
        // بديل محلي في حال تشغيل المشروع بدون إعداد App Group
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(AppConfig.storageFileName)
    }
    
    // MARK: - Operations
    
    /// إضافة نص جديد إلى الحافظة
    @discardableResult
    public func addClip(text: String, isPinned: Bool = false, category: ClipCategory = .text) -> ClipItem? {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        
        // إذا كان النص موجوداً مسبقاً، نقوم بتحديث توقيته ونقله إلى الأعلى
        if let existingIndex = clips.firstIndex(where: { $0.text == trimmed }) {
            var updatedClip = clips[existingIndex]
            updatedClip.createdAt = Date()
            if isPinned {
                updatedClip.isPinned = true
            }
            clips.remove(at: existingIndex)
            clips.insert(updatedClip, at: 0)
            saveClips()
            notifyDataChanged()
            return updatedClip
        }
        
        let newClip = ClipItem(
            text: trimmed,
            createdAt: Date(),
            isPinned: isPinned,
            category: category
        )
        
        clips.insert(newClip, at: 0)
        
        // الحفاظ على الحد الأقصى لسجل النصوص
        trimHistory()
        
        saveClips()
        notifyDataChanged()
        return newClip
    }
    
    /// حذف عنصر محدد
    public func deleteClip(id: UUID) {
        clips.removeAll(where: { $0.id == id })
        saveClips()
        notifyDataChanged()
    }
    
    /// تبديل حالة التثبيت (Pin / Unpin) مثل أندرويد تماماً
    public func togglePin(id: UUID) {
        if let index = clips.firstIndex(where: { $0.id == id }) {
            clips[index].isPinned.toggle()
            saveClips()
            notifyDataChanged()
        }
    }
    
    /// تحديث نص عنصر موجود
    public func updateClip(id: UUID, newText: String) {
        guard let index = clips.firstIndex(where: { $0.id == id }) else { return }
        let trimmed = newText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        clips[index].text = trimmed
        clips[index].category = ClipItem.detectCategory(for: trimmed)
        saveClips()
        notifyDataChanged()
    }
    
    /// مسح كل النصوص غير المثبتة (تبقى النصوص المثبتة كما في أندرويد)
    public func clearUnpinned() {
        clips.removeAll(where: { !$0.isPinned })
        saveClips()
        notifyDataChanged()
    }
    
    /// مسح كافة العناصر
    public func clearAll() {
        clips.removeAll()
        saveClips()
        notifyDataChanged()
    }
    
    /// فحص حافظة النظام وقراءة أي نص جديد
    @discardableResult
    public func checkAndCaptureSystemPasteboard() -> ClipItem? {
        guard UIPasteboard.general.hasStrings,
              let pasteboardString = UIPasteboard.general.string,
              !pasteboardString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        
        let trimmed = pasteboardString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // تجنب تكرار النص إذا كان هو نفسه أحدث عنصر
        if let firstClip = clips.first, firstClip.text == trimmed {
            return nil
        }
        
        return addClip(text: trimmed, isPinned: false)
    }
    
    // MARK: - Filtering Helpers
    
    public var pinnedClips: [ClipItem] {
        clips.filter { $0.isPinned }
    }
    
    public var unpinnedClips: [ClipItem] {
        clips.filter { !$0.isPinned }
    }
    
    public func filteredClips(searchText: String, category: ClipCategory = .all, onlyPinned: Bool = false) -> [ClipItem] {
        return clips.filter { clip in
            let matchesCategory = (category == .all) || (clip.category == category)
            let matchesPinned = !onlyPinned || clip.isPinned
            let matchesSearch = searchText.isEmpty || clip.text.localizedCaseInsensitiveContains(searchText)
            return matchesCategory && matchesPinned && matchesSearch
        }
    }
    
    // MARK: - Storage & Sync
    
    public func reload() {
        loadClips()
    }
    
    private func trimHistory() {
        let maxCount = AppConfig.defaultMaxClips
        let pinned = clips.filter { $0.isPinned }
        var unpinned = clips.filter { !$0.isPinned }
        
        let allowedUnpinned = max(0, maxCount - pinned.count)
        if unpinned.count > allowedUnpinned {
            unpinned = Array(unpinned.prefix(allowedUnpinned))
            self.clips = (pinned + unpinned).sorted(by: { $0.createdAt > $1.createdAt })
        }
    }
    
    private func saveClips() {
        let itemsToSave = self.clips
        fileQueue.async {
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .iso8601
                encoder.outputFormatting = .prettyPrinted
                let data = try encoder.encode(itemsToSave)
                try data.write(to: self.storageFileURL, options: .atomic)
            } catch {
                print("ClipboardStore: Error saving clips: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadClips() {
        fileQueue.async {
            let url = self.storageFileURL
            guard FileManager.default.fileExists(atPath: url.path) else { return }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let loaded = try decoder.decode([ClipItem].self, from: data)
                DispatchQueue.main.async {
                    self.clips = loaded
                }
            } catch {
                print("ClipboardStore: Error loading clips: \(error.localizedDescription)")
            }
        }
    }
    
    // إشعار فوري بين المعالجات (Cross-process Darwin notification)
    private func notifyDataChanged() {
        let center = CFNotificationCenterGetDarwinNotifyCenter()
        CFNotificationCenterPostNotification(center, CFNotificationName(AppConfig.darwinNotificationName), nil, nil, true)
    }
    
    private func setupDarwinObserver() {
        let center = CFNotificationCenterGetDarwinNotifyCenter()
        let observer = Unmanaged.passUnretained(self).toOpaque()
        
        CFNotificationCenterAddObserver(
            center,
            observer,
            { (_, observer, _, _, _) in
                guard let observer = observer else { return }
                let store = Unmanaged<ClipboardStore>.fromOpaque(observer).takeUnretainedValue()
                DispatchQueue.main.async {
                    store.loadClips()
                }
            },
            AppConfig.darwinNotificationName,
            nil,
            .deliverImmediately
        )
    }
    
    private func populateSampleDataIfEmpty() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self, self.clips.isEmpty else { return }
            
            let samples: [(text: String, isPinned: Bool, cat: ClipCategory)] = [
                ("مرحباً بك في حافظة الكيبورد الذكية! 📋 اضغط على أي نص للصقه مباشرة في أي تطبيق.", true, .snippets),
                ("SA0000000000000000000000", true, .snippets),
                ("https://apple.com", false, .link),
                ("info@example.com", true, .email),
                ("+966500000000", false, .phone),
                ("شكراً لتواصلك معنا، سيسعدنا خدمتك والرد على استفسارك بأسرع وقت.", true, .snippets)
            ]
            
            for item in samples {
                self.addClip(text: item.text, isPinned: item.isPinned, category: item.cat)
            }
        }
    }
}
