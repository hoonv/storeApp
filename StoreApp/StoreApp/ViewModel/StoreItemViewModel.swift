//
//  StoreItemViewModel.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import Foundation

class StoreItemViewModel {
    
    struct Header {
        let title: String
        let category: String
    }
    
    var items: [StoreItems] = []
    var badges: [String]
    var headers: [Header] = []
    
    init() {
        items.append(StoreItems(items: StoreItemLoader.load(name: "main") ?? []))
        items.append(StoreItems(items: StoreItemLoader.load(name: "side") ?? []))
        items.append(StoreItems(items: StoreItemLoader.load(name: "soup") ?? []))
        badges = Array(Set(items.flatMap { $0.items.compactMap{ $0.badge }.joined() })).sorted()
        
        headers.append(Header(title: "한그릇 뚝딱 메인 요리", category: "메인반찬"))
        headers.append(Header(title: "언제 먹어도 든든한 밑반찬", category: "밑반찬"))
        headers.append(Header(title: "김이 모락모락 국・찌개", category: "국・찌개"))
    }
    
}
