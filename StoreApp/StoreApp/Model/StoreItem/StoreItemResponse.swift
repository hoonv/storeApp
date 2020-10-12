//
//  StoreItemResponse.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/12.
//

import Foundation

struct StoreItemResponse: Codable {

    let statusCode: Int
    let body: [StoreItem]
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case body
    }
}
