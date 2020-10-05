//
//  Verifier.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/04.
//

import Foundation


enum ValidatorMessage: String {
    
    case validId = "사용 가능한 아이디입니다."
    case invalidlengthID = "아이디는 5~20글자만 가능합니다."
    case invalidSpecialCharactor = "영 소문자 숫자 '_', '-' 만 가능합니다."
    case validPassword = "안전한 비밀번호 입니다"
    case invalidlengthPassword = "비밀번호는 8~16글자만 가능합니다."
    case invalidNotIncludeNumber = "비밀번호는 1개이상의 숫자를 포함해야 합니다."
    case invalidNotIncludeSmall = "비밀번호는 1개이상의 소문자를 포함해야 합니다."
    case invalidNotIncludeLarge = "비밀번호는 1개이상의 대문자를 포함해야 합니다."
    case invalidNotIncludeSpecial = "비밀번호는 1개이상의 특수문자를 포함해야 합니다."
    case invalidIncludeSpace = "비밀번호는 공백을 포함하면 안됩니다."
}

class Validator {
    
    func id(input: String) -> ValidatorMessage {
        
        if input.getArray(regex: "^(?=.*).{5,20}$").isEmpty {
            return .invalidlengthID
        }
        
        if input.getArray(regex: "^[0-9a-z_-]+$").isEmpty {
            return .invalidSpecialCharactor
        }
    
        return .validId
    }
    
    func password(input: String) -> ValidatorMessage {

        if input.getArray(regex: "^(?=.*).{8,16}$").isEmpty {
            return .invalidlengthPassword
        }
        
        if input.getArray(regex: "(?=.*[0-9]).+").isEmpty {
            return .invalidNotIncludeNumber
        }
        
        if input.getArray(regex: "(?=.*[a-z]).+").isEmpty {
            return .invalidNotIncludeSmall
        }
        
        if input.getArray(regex: "(?=.*[A-Z]).+").isEmpty {
            return .invalidNotIncludeLarge
        }
        
        if input.getArray(regex: "(?=.*\\W).+").isEmpty {
            return .invalidNotIncludeSpecial
        }
        
        if !input.getArray(regex: "(?=\\s).+").isEmpty {
            return .invalidIncludeSpace
        }

        return .validPassword
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
