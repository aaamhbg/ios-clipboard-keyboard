//
//  TestKeyboardAreaView.swift
//  ClipboardApp
//

import SwiftUI

/// مساحة اختبار حية لتجربة لوحة المفاتيح داخل التطبيق مباشرة
struct TestKeyboardAreaView: View {
    @State private var sampleInputText: String = ""
    @FocusState private var isFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // بطاقة الإرشادات
            VStack(alignment: .leading, spacing: 8) {
                Label("مساحة تجربة الكيبورد", systemImage: "sparkles")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text("اضغط داخل الصندوق أدناه لفتح لوحة المفاتيح، ثم اضغط مطولاً على أيقونة الكرة الأرضية 🌐 للتبديل إلى لوحة Clipboard Keyboard وجرب لصق النصوص فوراً بنمط أندرويد.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.blue.opacity(0.08))
            .cornerRadius(12)
            
            // حقل النص التفاعلي
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("اكتب أو الصق هنا:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    if !sampleInputText.isEmpty {
                        Button("مسح الحقل") {
                            sampleInputText = ""
                        }
                        .font(.caption)
                        .foregroundColor(.red)
                    }
                }
                
                TextEditor(text: $sampleInputText)
                    .focused($isFieldFocused)
                    .frame(height: 180)
                    .padding(8)
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isFieldFocused ? Color.blue : Color.gray.opacity(0.2), lineWidth: 1.5)
                    )
            }
            
            // أزرار سريعة
            HStack(spacing: 12) {
                Button(action: {
                    isFieldFocused = true
                }) {
                    Label("فتح الكيبورد", systemImage: "keyboard")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    isFieldFocused = false
                }) {
                    Label("إخفاء الكيبورد", systemImage: "keyboard.chevron.compact.down")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(UIColor.secondarySystemFill))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("تجربة الكيبورد")
    }
}
