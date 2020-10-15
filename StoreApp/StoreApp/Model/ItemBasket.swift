//
//  ItemBasket.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/15.
//

import Foundation

class ItemBasket {
    
    static var shared = ItemBasket()
    var items: [StoreItem: Int] = [:]
    var totalPrice: Int {
        get { items.map { (item, count) in
            (item.sPrice.priceToInt() ?? 0) * count }.reduce(0, +)
        }
    }
    
    private init() {
        
    }

    public func append(element: StoreItem) {
        items[element, default: 0] += 1
        NotificationCenter.default.post(name: .ItemBasketDidChanged, object: nil)
    }
    
    public func clear() {
        items.removeAll()
        NotificationCenter.default.post(name: .ItemBasketDidChanged, object: nil)
    }
}
