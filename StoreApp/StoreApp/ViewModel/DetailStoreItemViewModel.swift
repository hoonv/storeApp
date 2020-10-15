//
//  DetailStoreItemViewModel.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/13.
//

import Foundation
import NetworkHelper

class DetailViewModel {
    
    var item: StoreItem?
    var title: String { item?.title ?? "" }
    var desc: String { item?.description ?? "" }
    var sPrice: String { item?.sPrice ?? "" }
    var nPrice: String? { item?.nPrice }
    var salePercent: String? { calculateSalePercent(prev: nPrice, curr: sPrice) }
    var storeItem: ((StoreItem, String?) -> Void)?
    var detailStoreItem: ((DetailStoreItem) -> Void)?
    var thumbImages: (([String]) -> Void)?
    var detailSection: (([String]) -> Void)?
    
    init() {
        
    }
    
    func load() {
        guard let item = item else { return }
        storeItem?(item, salePercent)
    }
    
    func request() {
        guard let item = item else { return }
        NetworkLayer.shared.dataTask(from: "\(Constant.detailURL)\(item.detailHash)") {
            [weak self] (result: Result<DetailStoreItem,APIError>) in
            switch result {
            case .success(let model):
                self?.detailStoreItem?(model)
                self?.thumbImages?(model.data.thumbImages)
                self?.detailSection?(model.data.detailSection)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func post(completion: @escaping (() -> Void)) {
        guard let url = URL(string: Constant.postURL),
              let item = item else { return }
        
        let data = ["text" : "\(item.title) 1개, 금액: \(item.sPrice)\n총 금액: \(item.sPrice)"]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            NetworkLayer.shared.postData(url: url, data: jsonData)
            completion()
        } catch {
            print("error")
        }
    }
    
    private func calculateSalePercent(prev: String?, curr: String) -> String? {
        guard let prev = prev,
              let currPrice = curr.priceToInt(),
              let prevPrice = prev.priceToInt() else { return nil }
        
        let currNum = Double(currPrice)
        let prevNum = Double(prevPrice)
        let percent = Int((prevNum - currNum) / prevNum * 100)
        
        return "\(percent)%"
    }
}

extension DetailViewModel {
    enum Constant {
        static let detailURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail/"
        static let postURL = "https://hooks.slack.com/services/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"
    }
}
