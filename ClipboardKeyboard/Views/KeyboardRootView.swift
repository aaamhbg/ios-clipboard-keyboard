//
//  KeyboardRootView.swift
//  ClipboardKeyboard
//

import SwiftUI

/// الواجهة الشاملة للوحة مفاتيح الحافظة
struct KeyboardRootView: View {
    @ObservedObject var store = ClipboardStore.shared
    
    let onInsertText: (String) -> Void
    let onDeleteBackward: () -> Void
    let onInsertReturn: () -> Void
    let onInsertSpace: () -> Void
    let onSwitchKeyboard: () -> Void
    let onDismissKeyboard: () -> Void
    let onPasteCurrentSystemClipboard: () -> Void
    
    let hasFullAccess: Bool
    let needsInputModeSwitchKey: Bool
    
    @State private var showPinnedOnly: Bool = false
    @State private var isSearching: Bool = false
    @State private var searchText: String = ""
    @State private var selectedCategory: ClipCategory = .all
    
    @Environment(\.colorScheme) var colorScheme
    
    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        VStack(spacing: 6) {
            // شريط الأدوات العلوي
            KeyboardToolbar(
                showPinnedOnly: $showPinnedOnly,
                isSearching: $isSearching,
                searchText: $searchText,
                onSwitchKeyboard: onSwitchKeyboard,
                onPasteCurrentSystemClipboard: onPasteCurrentSystemClipboard,
                onDeleteBackward: onDeleteBackward,
                needsInputModeSwitchKey: needsInputModeSwitchKey
            )
            
            // حقل البحث إذا تم تفعيله
            if isSearching {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                        .font(.system(size: 13))
                    TextField("بحث في الحافظة...", text: $searchText)
                        .font(.system(size: 13))
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                                .font(.system(size: 13))
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(8)
                .padding(.horizontal, 8)
            }
            
            // شريط التصنيفات السريعة
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(ClipCategory.allCases, id: \.self) { category in
                        categoryChip(category)
                    }
                }
                .padding(.horizontal, 8)
            }
            .frame(height: 28)
            
            // تنبيه في حال عدم تفعيل الوصول الكامل
            if !hasFullAccess {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                    Text("يرجى تفعيل 'السماح بالوصول الكامل' من الإعدادات لمزامنة الحافظة.")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.yellow.opacity(0.15))
                .cornerRadius(6)
                .padding(.horizontal, 8)
            }
            
            // محتوى الحافظة
            let items = store.filteredClips(
                searchText: searchText,
                category: selectedCategory,
                onlyPinned: showPinnedOnly
            )
            
            if items.isEmpty {
                emptyStateView
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(items) { clip in
                            ClipCardView(
                                clip: clip,
                                onSelect: {
                                    onInsertText(clip.text)
                                },
                                onTogglePin: {
                                    store.togglePin(id: clip.id)
                                },
                                onDelete: {
                                    store.deleteClip(id: clip.id)
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 4)
                }
            }
            
            // شريط الإجراءات السفلي (مسافة، إدخال، إغلاق)
            bottomActionBar
        }
        .background(keyboardBackground)
    }
    
    // MARK: - Components
    
    private func categoryChip(_ category: ClipCategory) -> some View {
        let isSelected = selectedCategory == category
        return Button(action: {
            selectedCategory = category
        }) {
            HStack(spacing: 4) {
                Image(systemName: category.iconName)
                    .font(.system(size: 10))
                Text(category.rawValue)
                    .font(.system(size: 11, weight: isSelected ? .bold : .medium))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(isSelected ? Color.blue : Color(UIColor.tertiarySystemFill))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(14)
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "tray")
                .font(.system(size: 30))
                .foregroundColor(.secondary)
            Text("لا توجد نصوص منسوخة هنا")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.secondary)
            Text("انسخ أي نص أو اضغط 'لصق الأخير' بالأعلى لإضافته.")
                .font(.system(size: 11))
                .foregroundColor(.secondary.opacity(0.8))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    private var bottomActionBar: some View {
        HStack(spacing: 8) {
            // زر مسافة (Space)
            Button(action: onInsertSpace) {
                Text("مسافة")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 38)
                    .background(buttonBackground)
                    .cornerRadius(8)
            }
            
            // زر سطر جديد (Return)
            Button(action: onInsertReturn) {
                Text("إدخال")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 80, height: 38)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            // زر إخفاء الكيبورد
            Button(action: onDismissKeyboard) {
                Image(systemName: "keyboard.chevron.compact.down")
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                    .frame(width: 44, height: 38)
                    .background(buttonBackground)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 6)
    }
    
    private var keyboardBackground: Color {
        if colorScheme == .dark {
            return Color(UIColor.systemGray6)
        } else {
            return Color(UIColor.systemGroupedBackground)
        }
    }
    
    private var buttonBackground: Color {
        if colorScheme == .dark {
            return Color(UIColor.secondarySystemBackground)
        } else {
            return Color.white
        }
    }
}
