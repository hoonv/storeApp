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
        let currPrice = curr.replacingOccurrences(of: "원", with: "")
                            .replacingOccurrences(of: ",", with: "")
        let prevPrice = prev.replacingOccurrences(of: ",", with: "")
        
        guard let currNum = Double(currPrice), let prevNum = Double(prevPrice) else { return nil }

        let percent = Int((prevNum - currNum) / prevNum * 100)
        
        return "\(percent)%"
    }
    
}
