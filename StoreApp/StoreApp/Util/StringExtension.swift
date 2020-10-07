//
//  StringExtension.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import Foundation

extension String {
    
    func cancelLine() -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
