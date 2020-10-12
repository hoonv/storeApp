//
//  StoreItemViewModel.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import Foundation
import NetworkHelper

class StoreItemViewModel {
    
    struct Header {
        let title: String
        let category: String
    }
    
    var items: [StoreItems] = []
    var headers: [Header] = [] { didSet {
        NotificationCenter.default.post(name: .StoreItemDidChange, object: nil)
    }}
    var badges: [String] {
        get { Array(Set(items.flatMap { $0.items.compactMap{ $0.badge }.joined() })).sorted() }
    }

    init() {
        setData()
    }

    private func setData() {
        fetchStoreItems(url: Constant.mainURL) { [weak self] storeItems in
            self?.items.append(storeItems)
            self?.headers.append(Header(title: "한그릇 뚝딱 메인 요리", category: "메인반찬"))
        }
        fetchStoreItems(url: Constant.sideURL) { [weak self] storeItems in
            self?.items.append(storeItems)
            self?.headers.append(Header(title: "언제 먹어도 든든한 밑반찬", category: "밑반찬"))
        }
        fetchStoreItems(url: Constant.soupURL) { [weak self] storeItems in
            self?.items.append(storeItems)
            self?.headers.append(Header(title: "김이 모락모락 국・찌개", category: "국・찌개"))
        }
    }
    
    private func fetchStoreItems(url: String, completion: @escaping (StoreItems) -> Void) {
        NetworkLayer.shared.fetchModel(from: url) {
            (result: Result<StoreItemResponse,APIError>) in
            switch result {
            case .success(let model):
                completion(StoreItems(items: model.body))
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension StoreItemViewModel {
    enum Constant {
        static let mainURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main"
        static let soupURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/soup"
        static let sideURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/side"
    }
}
