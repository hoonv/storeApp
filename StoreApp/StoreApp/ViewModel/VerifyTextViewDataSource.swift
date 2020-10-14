//
//  VerifyTextViewDataSource.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit

protocol VerifyTextViewDataSource {
    
    var defaultIcon: UIImage? { get }
    
    var passIcon: UIImage? { get }
    
    var failIcon: UIImage? { get }
    
    var placeholder: String { get }
    
    var title: String { get }
}

class IdDataSource: VerifyTextViewDataSource {
    
    var defaultIcon: UIImage? {
        get { return UIImage(named: "icon-person") }
    }
    
    var passIcon: UIImage? {
        get { return UIImage(named: "icon-person-cyan") }
    }
    
    var failIcon: UIImage? {
        get { return UIImage(named: "icon-person-red") }
    }
    
    var placeholder: String {
        get { return "영문 소문자 숫자 특수기호(_,-), 5~20자" }
    }
    
    var title: String {
        get { return "아이디" }
    }
}

class FirstPWDataSource: VerifyTextViewDataSource {
    
    var defaultIcon: UIImage? {
        get { return UIImage(named: "icon-lock") }
    }
    
    var passIcon: UIImage? {
        get { return UIImage(named: "icon-lock-cyan") }
    }
    
    var failIcon: UIImage? {
        get { return UIImage(named: "icon-lock-red") }
    }
    
    var placeholder: String {
        get { return "영문 대소문자 숫자 특수기호, 8~16자" }
    }
    
    var title: String {
        get { return "비밀번호" }
    }
}

class SecondPWDataSource: VerifyTextViewDataSource {
    
    var defaultIcon: UIImage? {
        get { return UIImage(named: "icon-lock") }
    }
    
    var passIcon: UIImage? {
        get { return UIImage(named: "icon-lock-cyan") }
    }
    
    var failIcon: UIImage? {
        get { return UIImage(named: "icon-lock-red") }
    }
    
    var placeholder: String {
        get { return "" }
    }
    
    var title: String {
        get { return "비밀번호 재확인" }
    }
}

class NameDataSource: VerifyTextViewDataSource {
    
    var defaultIcon: UIImage? {
        get { return UIImage(named: "icon-tag") }
    }
    
    var passIcon: UIImage? {
        get { return UIImage(named: "icon-tag-cyan") }
    }
    
    var failIcon: UIImage? {
        get { return UIImage(named: "icon-tag-red") }
    }
    
    var placeholder: String {
        get { return "" }
    }
    
    var title: String {
        get { return "이름" }
    }
}
