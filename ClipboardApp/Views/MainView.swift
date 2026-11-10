//
//  MainView.swift
//  ClipboardApp
//

import SwiftUI

/// الواجهة الرئيسية للتطبيق المحتوية على التبويبات الأربعة
struct MainView: View {
    @ObservedObject var store = ClipboardStore.shared
    @State private var selectedTab: Int = 0
    @State private var searchText: String = ""
    @State private var selectedCategory: ClipCategory = .all
    @State private var filterMode: FilterMode = .all
    @State private var showAddSheet: Bool = false
    @State private var clipToEdit: ClipItem? = nil
    
    enum FilterMode: String, CaseIterable {
        case all = "الكل"
        case pinned = "المثبتة"
        case recent = "الأخيرة"
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // التبويب الأول: الحافظة
            clipboardTab
                .tabItem {
                    Label("الحافظة", systemImage: "doc.on.clipboard.fill")
                }
                .tag(0)
            
            // التبويب الثاني: تجربة الكيبورد
            NavigationStack {
                TestKeyboardAreaView()
            }
            .tabItem {
                Label("تجربة الكيبورد", systemImage: "keyboard")
            }
            .tag(1)
            
            // التبويب الثالث: طريقة التفعيل
            NavigationStack {
                SetupGuideView()
            }
            .tabItem {
                Label("طريقة التفعيل", systemImage: "questionmark.circle")
            }
            .tag(2)
            
            // التبويب الرابع: الإعدادات
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("الإعدادات", systemImage: "gearshape")
            }
            .tag(3)
        }
        .sheet(isPresented: $showAddSheet) {
            AddEditClipSheet()
        }
        .sheet(item: $clipToEdit) { clip in
            AddEditClipSheet(existingClip: clip)
        }
    }
    
    // MARK: - Clipboard Tab
    
    private var clipboardTab: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // شريط تصفية النمط (الكل / المثبتة / الأخيرة)
                Picker("النوع", selection: $filterMode) {
                    ForEach(FilterMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // شريط الفئات السريعة
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(ClipCategory.allCases, id: \.self) { cat in
                            Button(action: {
                                selectedCategory = cat
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: cat.iconName)
                                    Text(cat.rawValue)
                                }
                                .font(.system(size: 13, weight: selectedCategory == cat ? .bold : .regular))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(selectedCategory == cat ? Color.blue : Color(UIColor.secondarySystemFill))
                                .foregroundColor(selectedCategory == cat ? .white : .primary)
                                .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 6)
                
                // قائمة العناصر
                let clips = displayedClips
                
                if clips.isEmpty {
                    emptyState
                } else {
                    List {
                        ForEach(clips) { clip in
                            ClipRowView(
                                clip: clip,
                                onTogglePin: {
                                    store.togglePin(id: clip.id)
                                },
                                onCopy: {
                                    UIPasteboard.general.string = clip.text
                                },
                                onEdit: {
                                    clipToEdit = clip
                                },
                                onDelete: {
                                    store.deleteClip(id: clip.id)
                                }
                            )
                        }
                    }
                    .listStyle(.insetGrouped)
                    .refreshable {
                        store.checkAndCaptureSystemPasteboard()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "بحث في نصوص الحافظة...")
            .navigationTitle("الحافظة 📋")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddSheet = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 20))
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if store.checkAndCaptureSystemPasteboard() != nil {
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success)
                        }
                    }) {
                        Label("التقاط الحافظة", systemImage: "arrow.down.doc")
                    }
                }
            }
        }
    }
    
    private var displayedClips: [ClipItem] {
        let onlyPinned = (filterMode == .pinned)
        var items = store.filteredClips(searchText: searchText, category: selectedCategory, onlyPinned: onlyPinned)
        if filterMode == .recent {
            items = items.filter { !$0.isPinned }
        }
        return items
    }
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "doc.on.clipboard")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("لا توجد عناصر لعرضها")
                .font(.headline)
            Text("يمكنك نسخ أي نص في أي تطبيق وسيحفظ تلقائياً، أو اضغط زر + لإضافة نص أو رد سريع يدوياً.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Button(action: {
                showAddSheet = true
            }) {
                Label("إضافة نص جديد", systemImage: "plus")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 8)
            
            Spacer()
        }
    }
}
