//
//  SetupGuideView.swift
//  ClipboardApp
//

import SwiftUI

/// دليل خطوات تفعيل لوحة المفاتيح في إعدادات iOS
struct SetupGuideView: View {
    @State private var completedSteps: Set<Int> = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // رأس الصفحة
                VStack(alignment: .leading, spacing: 8) {
                    Label("دليل التفعيل السريع", systemImage: "keyboard")
                        .font(.title2.bold())
                    
                    Text("لتتمكن من استخدام حافظة الكيبورد في كافة التطبيقات مثل أندرويد، اتبع الخطوات التالية البسيطة:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // زر الانتقال المباشر للإعدادات
                Button(action: openSettings) {
                    HStack {
                        Image(systemName: "gearshape.fill")
                        Text("فتح إعدادات النظام مباشرة")
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "arrow.up.forward.app")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                
                // الخطوات
                VStack(spacing: 14) {
                    stepRow(
                        step: 1,
                        title: "افتح الإعدادات (Settings)",
                        description: "توجه إلى الإعدادات > عام (General) > لوحة المفاتيح (Keyboard)."
                    )
                    
                    stepRow(
                        step: 2,
                        title: "إضافة لوحة المفاتيح",
                        description: "اضغط على 'لوحات المفاتيح' (Keyboards) ثم 'إضافة لوحة مفاتيح جديدة...' (Add New Keyboard)."
                    )
                    
                    stepRow(
                        step: 3,
                        title: "اختر Clipboard Keyboard",
                        description: "ستجدها تحت قسم 'لوحات مفاتيح الجهات الخارجية' (Third-Party Keyboards)."
                    )
                    
                    stepRow(
                        step: 4,
                        title: "تفعيل 'السماح بالوصول الكامل' (هام جداً)",
                        description: "اضغط على اسم الكيبورد بعد إضافته، ثم قم بتفعيل خيار 'السماح بالوصول الكامل' (Allow Full Access). هذا التصريح ضروري لنظام iOS ليسمح للكيبورد بقراءة النصوص المشتركة من الحافظة.",
                        isWarning: true
                    )
                    
                    stepRow(
                        step: 5,
                        title: "جاهز للاستخدام! 🎉",
                        description: "افتح أي تطبيق (واتساب، الملاحظات، سفاري...) واضغط على أيقونة الكرة الأرضية 🌐 في لوحة المفاتيح للتبديل لحافظة الكيبورد ولصق أي نص بلمسة واحدة."
                    )
                }
                
                // بطاقة توضيحية حول الخصوصية
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "lock.shield.fill")
                            .foregroundColor(.green)
                        Text("خصوصيتك بأمان كامل")
                            .font(.headline)
                    }
                    Text("بياناتك ونصوصك تُخزن محلياً فقط على جهازك داخل حاوية التطبيق، ولا يتم إرسال أي نصوص عبر الإنترنت إلى أي خادم خارجي إطلاقاً.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.green.opacity(0.08))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.green.opacity(0.2), lineWidth: 1)
                )
            }
            .padding()
        }
        .navigationTitle("طريقة التفعيل")
    }
    
    private func stepRow(step: Int, title: String, description: String, isWarning: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(isWarning ? Color.orange : Color.blue)
                    .frame(width: 32, height: 32)
                Text("\(step)")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(isWarning ? .orange : .primary)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(14)
    }
    
    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
