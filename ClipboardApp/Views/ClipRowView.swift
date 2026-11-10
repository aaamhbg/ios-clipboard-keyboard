//
//  ClipRowView.swift
//  ClipboardApp
//

import SwiftUI

/// صف عرض العنصر داخل التطبيق الرئيسي
struct ClipRowView: View {
    let clip: ClipItem
    let onTogglePin: () -> Void
    let onCopy: () -> Void
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    @State private var showCopiedAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                // أيقونة التصنيف
                Image(systemName: clip.category.iconName)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.blue)
                
                Text(clip.category.rawValue)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // التاريخ
                Text(clip.relativeDateString)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                
                // مؤشر التثبيت
                if clip.isPinned {
                    Image(systemName: "pin.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.orange)
                }
            }
            
            // النص
            Text(clip.text)
                .font(.system(size: 15))
                .foregroundColor(.primary)
                .lineLimit(4)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // شريط الحروف والإجراءات السريعة
            HStack {
                Text("\(clip.characterCount) حرف")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary.opacity(0.8))
                
                Spacer()
                
                Button(action: {
                    onCopy()
                    showCopiedAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        showCopiedAlert = false
                    }
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: showCopiedAlert ? "checkmark" : "doc.on.doc")
                            .font(.system(size: 12))
                        Text(showCopiedAlert ? "تم النسخ!" : "نسخ")
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundColor(showCopiedAlert ? .green : .blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(showCopiedAlert ? Color.green.opacity(0.12) : Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle())
        .onTapGesture {
            onEdit()
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                onTogglePin()
            } label: {
                Label(clip.isPinned ? "إلغاء التثبيت" : "تثبيت", systemImage: clip.isPinned ? "pin.slash" : "pin.fill")
            }
            .tint(.orange)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("حذف", systemImage: "trash")
            }
        }
    }
}
