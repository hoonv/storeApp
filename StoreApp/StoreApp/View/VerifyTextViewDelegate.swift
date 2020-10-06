//
//  VerifyTextViewDelegate.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit


protocol VerifyTextViewDelegate {
    
    var pass: ValidatorMessage { get }
 
    func verify(input: String) -> ValidatorMessage
}

class IdDelegate: VerifyTextViewDelegate {
    
    var pass: ValidatorMessage {
        get { .validId }
    }

    func verify(input: String) -> ValidatorMessage {
        let validator = Validator()
        return validator.id(input: input)
    }
}

class PWDelegate: VerifyTextViewDelegate {
    
    var pass: ValidatorMessage {
        get { .validPassword }
    }

    func verify(input: String) -> ValidatorMessage {
        let validator = Validator()
        return validator.password(input: input)
    }
}

class NameDelegate: VerifyTextViewDelegate {
    
    var pass: ValidatorMessage {
        get { .validName }
    }
    
    func verify(input: String) -> ValidatorMessage {
        let validator = Validator()
        return validator.name(input: input)
    }
}
