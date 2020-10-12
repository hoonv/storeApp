//
//  StoreItems.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import Foundation

struct StoreItems {
    
    static let empty = StoreItems(items: [], title: "", category: "")
    var items: [StoreItem]
    var title: String
    var category: String
    var count: Int {
        get { return items.count }
    }
    
    init(items: [StoreItem], title: String, category: String) {
        self.items = items
        self.title = title
        self.category = category
    }
    
    private func indexIsValid(index: Int) -> Bool {
        return index < items.count || index >= 0
        
    }
    
    subscript(index: Int) -> StoreItem {
        assert(indexIsValid(index: index), "Index out of range")
        return items[index]
    }
}
