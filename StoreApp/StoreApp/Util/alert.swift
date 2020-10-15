//
//  alert.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/15.
//

import UIKit

func defaultAlert(title: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
    return alert
}

