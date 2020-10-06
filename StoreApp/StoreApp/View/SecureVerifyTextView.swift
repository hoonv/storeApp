//
//  SecureVerifyTextView.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit

class SecureVerifyTextView: VerifyTextView {
    
    let rightButton  = UIButton(type: .custom)

    override func commonInit() {
        let container: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))

        rightButton.setImage(UIImage(named: "icon-eye") , for: .normal)
        rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        rightButton.frame = CGRect(x:10, y:6, width:26, height:24)
        container.addSubview(rightButton)
        textField.rightViewMode = .always
        textField.rightView = container
        textField.isSecureTextEntry = true
        super.commonInit()
    }

    @objc func toggleShowHide(button: UIButton) {
        toggle()
    }

    func toggle() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        if textField.isSecureTextEntry {
            rightButton.setImage(UIImage(named: "icon-eye") , for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "icon-eye-off") , for: .normal)
        }
    }
}
