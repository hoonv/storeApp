//
//  SignUpViewModel.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel {
    
    var passwordsCombine = PublishSubject<(String, String)>()
    var isPWEqual: Bool = false

}
