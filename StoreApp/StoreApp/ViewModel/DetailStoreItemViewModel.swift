//
//  DetailStoreItemViewModel.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/13.
//

import Foundation

class DetailViewModel {
    
    let title: String
    let desc: String
    let sPrice: String
    var nPrice: String?
    var salePercent: String?
    
    init(item: StoreItem) {
        title = item.title
        desc = item.description
        sPrice = item.sPrice
        nPrice = item.nPrice
        if let nPrice = nPrice {
            salePercent = calculateSalePercent(prev: nPrice, curr: sPrice)
        }
    }
    
    
    private func calculateSalePercent(prev: String, curr: String) -> String? {
        guard
            let currPrice = curr.priceToInt(),
            let prevPrice = prev.priceToInt() else { return nil }
        
        let currNum = Double(currPrice)
        let prevNum = Double(prevPrice)

        let percent = Int((prevNum - currNum) / prevNum * 100)
        
        return "\(percent)%"
    }
    
}

extension String {
    func priceToInt() -> Int? {
        let price = self.replacingOccurrences(of: "원", with: "")
                        .replacingOccurrences(of: ",", with: "")
        
        return Int(price) ?? nil
    }
}
