//
//  SignUpViewController+extension.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit

extension SignUpViewController: VerifyTextViewDelegate {
    var pass: ValidatorMessage {
        get { .equalPassword }
    }
    
    func verify(input: String) -> ValidatorMessage {
        if firstPWTextView.textField.text == input {
            return .equalPassword
        }
        return .notEqualPassward
    }
}
