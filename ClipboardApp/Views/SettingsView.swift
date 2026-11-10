//
//  SettingsView.swift
//  ClipboardApp
//

import SwiftUI

/// صفحة إعدادات التطبيق والحافظة
struct SettingsView: View {
    @ObservedObject var store = ClipboardStore.shared
    @State private var showClearAllConfirmation = false
    @State private var showClearUnpinnedConfirmation = false
    
    var body: some View {
        Form {
            Section(header: Text("حالة المزامنة")) {
                HStack {
                    Label("مجموعة التطبيق (App Group)", systemImage: "square.3.layers.3d.down.right")
                    Spacer()
                    if store.isAppGroupAvailable {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("متصلة ومفعلة")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                    } else {
                        HStack(spacing: 4) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.orange)
                            Text("وضع التخزين المحلي")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                        }
                    }
                }
                
                Text("معرّف المجموعة: \(AppConfig.appGroupID)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Section(header: Text("إحصائيات الحافظة")) {
                HStack {
                    Text("إجمالي النصوص المحفوظة")
                    Spacer()
                    Text("\(store.clips.count)")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("النصوص المثبتة (Pinned)")
                    Spacer()
                    Text("\(store.pinnedClips.count)")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("النصوص المؤقتة (Recent)")
                    Spacer()
                    Text("\(store.unpinnedClips.count)")
                        .foregroundColor(.secondary)
                }
            }
            
            Section(header: Text("إدارة البيانات")) {
                Button(role: .destructive, action: {
                    showClearUnpinnedConfirmation = true
                }) {
                    Label("مسح النصوص غير المثبتة فقط", systemImage: "pin.slash")
                }
                .confirmationDialog(
                    "هل أنت متأكد من مسح النصوص غير المثبتة؟ ستظل النصوص المثبتة محفوظة.",
                    isPresented: $showClearUnpinnedConfirmation,
                    titleVisibility: .visible
                ) {
                    Button("مسح غير المثبت", role: .destructive) {
                        store.clearUnpinned()
                    }
                }
                
                Button(role: .destructive, action: {
                    showClearAllConfirmation = true
                }) {
                    Label("مسح كافة النصوص بالكامل", systemImage: "trash")
                        .foregroundColor(.red)
                }
                .confirmationDialog(
                    "هل أنت متأكد من مسح جميع النصوص بما فيها المثبتة؟ لا يمكن التراجع عن هذا الإجراء.",
                    isPresented: $showClearAllConfirmation,
                    titleVisibility: .visible
                ) {
                    Button("مسح الكل", role: .destructive) {
                        store.clearAll()
                    }
                }
            }
            
            Section(header: Text("حول التطبيق")) {
                HStack {
                    Text("الاسم")
                    Spacer()
                    Text("Clipboard Keyboard")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("الإصدار")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("النمط")
                    Spacer()
                    Text("Android Gboard Style على iOS")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("الإعدادات")
    }
}
