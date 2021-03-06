//
//  StringExtension.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import Foundation

extension String {
    
    func addCancelLine() -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension String{
    
    func getArray(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

extension String {
    func priceToInt() -> Int? {
        let price = self.replacingOccurrences(of: "원", with: "")
                        .replacingOccurrences(of: ",", with: "")
        
        return Int(price) ?? nil
    }
}
