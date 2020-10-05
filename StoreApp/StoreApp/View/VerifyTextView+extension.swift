//
//  VerifyTextView+extensions.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit

extension UILabel {
    //자간 조절
    func addCharacterSpacing(kernValue: Double = 1.15) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

