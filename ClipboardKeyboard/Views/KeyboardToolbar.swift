//
//  KeyboardToolbar.swift
//  ClipboardKeyboard
//

import SwiftUI

/// شريط الأدوات العلوي للكيبورد بنمط أندرويد Gboard
struct KeyboardToolbar: View {
    @Binding var showPinnedOnly: Bool
    @Binding var isSearching: Bool
    @Binding var searchText: String
    
    let onSwitchKeyboard: () -> Void
    let onPasteCurrentSystemClipboard: () -> Void
    let onDeleteBackward: () -> Void
    let needsInputModeSwitchKey: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 6) {
            // زر تبديل لوحة المفاتيح (أيقونة الكرة الأرضية كما في iOS)
            Button(action: onSwitchKeyboard) {
                Image(systemName: "globe")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(width: 38, height: 36)
                    .background(buttonBackground)
                    .cornerRadius(8)
            }
            
            // زر لصق الحافظة الفورية (الميزة الأشهر في أندرويد)
            Button(action: onPasteCurrentSystemClipboard) {
                HStack(spacing: 4) {
                    Image(systemName: "doc.on.clipboard.fill")
                        .font(.system(size: 13, weight: .semibold))
                    Text("لصق الأخير")
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .frame(height: 36)
                .background(Color.blue)
                .cornerRadius(8)
            }
            
            // زر تصفية المثبتات فقط
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showPinnedOnly.toggle()
                }
            }) {
                Image(systemName: showPinnedOnly ? "pin.fill" : "pin")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(showPinnedOnly ? .orange : .primary)
                    .frame(width: 36, height: 36)
                    .background(showPinnedOnly ? Color.orange.opacity(0.18) : buttonBackground)
                    .cornerRadius(8)
            }
            
            // زر إظهار/إخفاء البحث
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isSearching.toggle()
                    if !isSearching {
                        searchText = ""
                    }
                }
            }) {
                Image(systemName: isSearching ? "xmark" : "magnifyingglass")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isSearching ? .blue : .primary)
                    .frame(width: 36, height: 36)
                    .background(isSearching ? Color.blue.opacity(0.15) : buttonBackground)
                    .cornerRadius(8)
            }
            
            Spacer()
            
            // زر الحذف للخلف (Backspace)
            Button(action: onDeleteBackward) {
                Image(systemName: "delete.backward.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(width: 44, height: 36)
                    .background(buttonBackground)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 6)
    }
    
    private var buttonBackground: Color {
        if colorScheme == .dark {
            return Color(UIColor.tertiarySystemFill)
        } else {
            return Color(UIColor.systemGray5)
        }
    }
}
