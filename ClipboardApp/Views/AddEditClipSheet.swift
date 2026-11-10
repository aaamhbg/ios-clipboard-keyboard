//
//  AddEditClipSheet.swift
//  ClipboardApp
//

import SwiftUI

/// نافذة إضافة أو تعديل نص في الحافظة
struct AddEditClipSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store = ClipboardStore.shared
    
    var existingClip: ClipItem?
    
    @State private var text: String = ""
    @State private var isPinned: Bool = false
    @State private var category: ClipCategory = .text
    
    var isEditing: Bool {
        existingClip != nil
    }
    
    init(existingClip: ClipItem? = nil) {
        self.existingClip = existingClip
        _text = State(initialValue: existingClip?.text ?? "")
        _isPinned = State(initialValue: existingClip?.isPinned ?? false)
        _category = State(initialValue: existingClip?.category ?? .text)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("محتوى النص")) {
                    TextEditor(text: $text)
                        .frame(minHeight: 120)
                }
                
                Section(header: Text("الخيارات")) {
                    Toggle("تثبيت في الأعلى (Pin)", isOn: $isPinned)
                        .tint(.orange)
                    
                    Picker("التصنيف", selection: $category) {
                        ForEach(ClipCategory.allCases.filter { $0 != .all }, id: \.self) { cat in
                            Label(cat.rawValue, systemImage: cat.iconName).tag(cat)
                        }
                    }
                }
            }
            .navigationTitle(isEditing ? "تعديل النص" : "إضافة نص جديد")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("إلغاء") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("حفظ") {
                        saveAction()
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func saveAction() {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        if let existing = existingClip {
            store.updateClip(id: existing.id, newText: trimmed)
            if existing.isPinned != isPinned {
                store.togglePin(id: existing.id)
            }
        } else {
            store.addClip(text: trimmed, isPinned: isPinned, category: category)
        }
        
        dismiss()
    }
}
