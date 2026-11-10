//
//  KeyboardViewController.swift
//  ClipboardKeyboard
//

import UIKit
import SwiftUI

/// وحدة التحكم الرئيسية للوحة مفاتيح الحافظة
public class KeyboardViewController: UIInputViewController {
    
    private var hostingController: UIHostingController<KeyboardRootView>?
    private let hapticFeedback = UIImpactFeedbackGenerator(style: .light)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hapticFeedback.prepare()
        setupKeyboardUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // التحقق من الحافظة عند فتح الكيبورد
        if hasFullAccess {
            ClipboardStore.shared.checkAndCaptureSystemPasteboard()
        }
        ClipboardStore.shared.reload()
    }
    
    private func setupKeyboardUI() {
        // إنشاء واجهة SwiftUI للكيبورد مع ربط الأوامر
        let rootView = KeyboardRootView(
            onInsertText: { [weak self] text in
                self?.handleInsertText(text)
            },
            onDeleteBackward: { [weak self] in
                self?.handleDeleteBackward()
            },
            onInsertReturn: { [weak self] in
                self?.textDocumentProxy.insertText("\n")
                self?.hapticFeedback.impactOccurred()
            },
            onInsertSpace: { [weak self] in
                self?.textDocumentProxy.insertText(" ")
                self?.hapticFeedback.impactOccurred()
            },
            onSwitchKeyboard: { [weak self] in
                self?.advanceToNextInputMode()
            },
            onDismissKeyboard: { [weak self] in
                self?.dismissKeyboard()
            },
            onPasteCurrentSystemClipboard: { [weak self] in
                self?.handlePasteCurrentClipboard()
            },
            hasFullAccess: self.hasFullAccess,
            needsInputModeSwitchKey: self.needsInputModeSwitchKey
        )
        
        let host = UIHostingController(rootView: rootView)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        host.view.backgroundColor = .clear
        
        addChild(host)
        view.addSubview(host.view)
        
        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // تحديد ارتفاع قياسي مناسب للوحة المفاتيح
            host.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 260)
        ])
        
        host.didMove(toParent: self)
        self.hostingController = host
    }
    
    // MARK: - Actions
    
    private func handleInsertText(_ text: String) {
        hapticFeedback.impactOccurred()
        textDocumentProxy.insertText(text)
    }
    
    private func handleDeleteBackward() {
        hapticFeedback.impactOccurred()
        textDocumentProxy.deleteBackward()
    }
    
    private func handlePasteCurrentClipboard() {
        guard hasFullAccess else {
            showAccessAlert()
            return
        }
        
        if let string = UIPasteboard.general.string, !string.isEmpty {
            handleInsertText(string)
            ClipboardStore.shared.addClip(text: string)
        }
    }
    
    private func showAccessAlert() {
        hapticFeedback.impactOccurred()
    }
    
    public override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
    }
    
    public override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
    }
}
