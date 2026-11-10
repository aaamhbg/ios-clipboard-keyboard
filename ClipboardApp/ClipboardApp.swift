//
//  ClipboardApp.swift
//  ClipboardApp
//

import SwiftUI

@main
struct ClipboardApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var store = ClipboardStore.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(store)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        // التقاط أي نص تم نسخه مؤخراً في أي تطبيق آخر بمجرد فتح التطبيق
                        store.checkAndCaptureSystemPasteboard()
                        store.reload()
                    }
                }
                .onOpenURL { url in
                    // فتح التطبيق من الكيبورد إذا تم النقر على رابط فتح التطبيق
                    if url.scheme == "clipboardapp" {
                        store.reload()
                    }
                }
        }
    }
}
