//
//  ClipItem.swift
//  ClipboardApp & ClipboardKeyboard
//
//  Created for Android-style Keyboard Clipboard on iOS.
//

import Foundation

/// تصنيف النص المنسوخ لتسهيل الفرز والوصول السريع
public enum ClipCategory: String, Codable, CaseIterable {
    case all = "الكل"
    case text = "نصوص"
    case link = "روابط"
    case email = "إيميل"
    case phone = "أرقام"
    case snippets = "قصاصات سريعة"
    
    public var iconName: String {
        switch self {
        case .all: return "tray.full.fill"
        case .text: return "text.quote"
        case .link: return "link"
        case .email: return "envelope.fill"
        case .phone: return "phone.fill"
        case .snippets: return "star.fill"
        }
    }
}

/// عنصر الحافظة (Clip) الذي يخزن النص المنسوخ وتفاصيله
public struct ClipItem: Identifiable, Codable, Equatable, Hashable {
    public let id: UUID
    public var text: String
    public var createdAt: Date
    public var isPinned: Bool
    public var category: ClipCategory
    
    public init(
        id: UUID = UUID(),
        text: String,
        createdAt: Date = Date(),
        isPinned: Bool = false,
        category: ClipCategory = .text
    ) {
        self.id = id
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.createdAt = createdAt
        self.isPinned = isPinned
        self.category = category == .text ? ClipItem.detectCategory(for: text) : category
    }
    
    /// استكشاف نوع النص تلقائياً (رابط، بريد، هاتف...)
    public static func detectCategory(for string: String) -> ClipCategory {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed.hasPrefix("http://") || trimmed.hasPrefix("https://") || trimmed.hasPrefix("www.") {
            return .link
        }
        
        if trimmed.contains("@") && trimmed.contains(".") && !trimmed.contains(" ") {
            return .email
        }
        
        // التحقق من أرقام الهواتف
        let phoneRegex = "^[+]?[0-9\\s\\-\\(\\)]{7,20}$"
        if trimmed.range(of: phoneRegex, options: .regularExpression) != nil {
            return .phone
        }
        
        return .text
    }
    
    /// معاينة مختصرة للنص للعرض داخل أزرار الكيبورد
    public var previewText: String {
        let clean = text.replacingOccurrences(of: "\n", with: " ")
        if clean.count > 60 {
            let index = clean.index(clean.startIndex, offsetBy: 57)
            return String(clean[..<index]) + "..."
        }
        return clean
    }
    
    /// عدد الحروف والكلمات
    public var characterCount: Int {
        return text.count
    }
    
    /// نص التاريخ بصيغة عربية ودية
    public var relativeDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ar")
        formatter.unitsStyle = .short
        return formatter.localizedString(for: createdAt, relativeTo: Date())
    }
}
