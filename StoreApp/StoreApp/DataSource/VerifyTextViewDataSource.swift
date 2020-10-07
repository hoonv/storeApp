//
//  VerifyTextViewDataSource.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit

protocol VerifyTextViewDataSource {
    
    func defaultIcon() -> UIImage?
    
    func passIcon() -> UIImage?
    
    func failIcon() -> UIImage?
    
    func placeholder() -> String
    
    func title() -> String
}

class IdDataSource: VerifyTextViewDataSource {
    
    func defaultIcon() -> UIImage? {
        return UIImage(named: "icon-person")
    }
    
    func passIcon() -> UIImage? {
        return UIImage(named: "icon-person-cyan")
    }
    
    func failIcon() -> UIImage? {
        return UIImage(named: "icon-person-red")
    }
    
    func placeholder() -> String {
        return "영문 소문자 숫자 특수기호(_,-), 5~20자"
    }
    
    func title() -> String {
        return "아이디"
    }
}

class FirstPWDataSource: VerifyTextViewDataSource {
    
    func defaultIcon() -> UIImage? {
        return UIImage(named: "icon-lock")
    }
    
    func passIcon() -> UIImage? {
        return UIImage(named: "icon-lock-cyan")
    }
    
    func failIcon() -> UIImage? {
        return UIImage(named: "icon-lock-red")
    }
    
    func placeholder() -> String {
        return "영문 대소문자 숫자 특수기호, 8~16자"
    }
    
    func title() -> String {
        return "비밀번호"
    }
}

class SecondPWDataSource: VerifyTextViewDataSource {
    
    func defaultIcon() -> UIImage? {
        return UIImage(named: "icon-lock")
    }
    
    func passIcon() -> UIImage? {
        return UIImage(named: "icon-lock-cyan")
    }
    
    func failIcon() -> UIImage? {
        return UIImage(named: "icon-lock-red")
    }
    
    func placeholder() -> String {
        return ""
    }
    
    func title() -> String {
        return "비밀번호 재확인"
    }
}

class NameDataSource: VerifyTextViewDataSource {
    
    func defaultIcon() -> UIImage? {
        return UIImage(named: "icon-tag")
    }
    
    func passIcon() -> UIImage? {
        return UIImage(named: "icon-tag-cyan")
    }
    
    func failIcon() -> UIImage? {
        return UIImage(named: "icon-tag-red")
    }
    
    func placeholder() -> String {
        return ""
    }
    
    func title() -> String {
        return "이름"
    }
}
