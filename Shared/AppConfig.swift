//
//  AppConfig.swift
//  ClipboardApp & ClipboardKeyboard
//

import Foundation

public struct AppConfig {
    /// معرّف مجموعة التطبيق لمشاركة البيانات بين التطبيق الرئيسي وامتداد لوحة المفاتيح
    /// يمكنك تغييره لمعرّف حساب المطور الخاص بك في Apple Developer
    public static let appGroupID = "group.com.clipboard.keyboardapp"
    
    /// اسم ملف التخزين المشترك
    public static let storageFileName = "clipboard_history.json"
    
    /// الحد الأقصى للنصوص المحفوظة تلقائياً في السجل
    public static let defaultMaxClips = 100
    
    /// اسم إشعار المزامنة بين التطبيق والكيبورد
    public static let darwinNotificationName = "com.clipboard.keyboardapp.dataChanged" as CFString
    
    /// رابط فتح التطبيق من الكيبورد
    public static let appURLScheme = URL(string: "clipboardapp://open")!
}
