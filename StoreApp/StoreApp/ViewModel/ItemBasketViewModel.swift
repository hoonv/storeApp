//
//  ItemBasketViewModel.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/15.
//

import Foundation
import NetworkHelper

class ItemBasketViewModel {
    
    var itemBasket = ItemBasket.shared
    var items: [Dictionary<StoreItem, Int>.Element] { Array(ItemBasket.shared.items) }
    var count: Int { items.count }
    var orderButtonContent: ((String) -> Void)?
    var itemDidUpdate: (() -> Void)?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(itemDidChanged), name: .ItemBasketDidChanged, object: nil)
    }
    
    func load() {
        orderButtonContent?("주문하기 \(itemBasket.totalPrice)원")
    }
    
    func clear() {
        itemBasket.clear()
    }
    
    @objc func itemDidChanged() {
        itemDidUpdate?()
        orderButtonContent?("주문하기 \(itemBasket.totalPrice)원")
    }
    
    public func itemSheet() -> String {
        return items
            .map { "\($0.key.title) \($0.value)개, 금액 \( ($0.key.sPrice.priceToInt() ?? 0) * $0.value)원" }
            .reduce("") { $0 + $1 + "\n" }
    }
    
    public func orderSheet() -> String {
        return "\(itemSheet()) 총 금액: \(itemBasket.totalPrice)원"
    }
    
    public func post(path: String, completion: @escaping (() -> Void)) {
        guard let url = URL(string: path) else { return }
        let data = ["text" : orderSheet()]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
//            NetworkLayer.shared.postData(url: url, data: jsonData)
            completion()
        } catch {
            print("error")
        }
        
    }
}
