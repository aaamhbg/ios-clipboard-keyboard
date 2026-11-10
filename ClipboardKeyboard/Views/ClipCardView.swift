//
//  ClipCardView.swift
//  ClipboardKeyboard
//

import SwiftUI

/// بطاقة عرض النص داخل الكيبورد بتصميم مستوحى من كيبورد أندرويد (Gboard)
struct ClipCardView: View {
    let clip: ClipItem
    let onSelect: () -> Void
    let onTogglePin: () -> Void
    let onDelete: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isPressed = false
    
    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 6) {
                // شريط المعلومات العلوي للبطاقة
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: clip.category.iconName)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.secondary)
                    
                    Text(clip.relativeDateString)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    // زر التثبيت السريع
                    Button(action: onTogglePin) {
                        Image(systemName: clip.isPinned ? "pin.fill" : "pin")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(clip.isPinned ? .orange : .secondary.opacity(0.6))
                            .padding(4)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                // محتوى النص المنسوخ
                Text(clip.text)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
            .background(cardBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(clip.isPinned ? Color.orange.opacity(0.4) : Color.gray.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.2 : 0.04), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(ScaleEffectButtonStyle())
        .contextMenu {
            Button {
                onSelect()
            } label: {
                Label("لصق في النص", systemImage: "arrow.right.doc.on.clipboard")
            }
            
            Button {
                onTogglePin()
            } label: {
                Label(clip.isPinned ? "إلغاء التثبيت" : "تثبيت في الأعلى", systemImage: clip.isPinned ? "pin.slash" : "pin")
            }
            
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("حذف", systemImage: "trash")
            }
        }
    }
    
    private var cardBackground: Color {
        if colorScheme == .dark {
            return Color(UIColor.secondarySystemBackground)
        } else {
            return Color.white
        }
    }
}

/// زر يمنح إحساساً بالحركة والضغط عند النقر
struct ScaleEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}
