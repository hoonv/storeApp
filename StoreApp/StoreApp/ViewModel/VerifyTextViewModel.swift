//
//  VerifyTextViewModel.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import Foundation
import RxSwift

class VerifyTextViewModel {
    
    var textFieldValueChanged = PublishSubject<String>()
    var inputDidValidate = PublishSubject<ValidatorMessage>()
    let disposeBag = DisposeBag()

    var validate: (String) -> ValidatorMessage
    var pass: ValidatorMessage
    var status: Bool
    
    init(validator: Validator) {
        validate = validator.validate
        pass = validator.pass
        status = false
        
        textFieldValueChanged
            .map(checkValidate)
            .bind(to: inputDidValidate)
            .disposed(by: disposeBag)
    }
    
    private func checkValidate(input: String) -> ValidatorMessage {
        let msg = validate(input)
        status = msg == pass
        return msg
    }
}
