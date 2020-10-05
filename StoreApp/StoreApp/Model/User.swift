//
//  User.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import Foundation

struct User: Codable {
    
    let id: String
    let password: String
    let name: String
    
    init(id: String, password: String, name: String) {
        self.id = id
        self.password = password
        self.name = name
    }
}

