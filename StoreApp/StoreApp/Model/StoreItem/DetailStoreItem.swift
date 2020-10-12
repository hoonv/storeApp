//
//  DetailStoreItem.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/12.
//

import Foundation

struct DetailStoreItem: Codable {
    let hash: String
    let data: DataClass
}

struct DataClass: Codable {
    let topImage: String
    let thumbImages: [String]
    let productDescription, point, deliveryInfo, deliveryFee: String
    let prices: [String]
    let detailSection: [String]

    enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSection = "detail_section"
    }
}
