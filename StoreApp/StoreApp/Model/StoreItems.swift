//
//  StoreItems.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import Foundation

class StoreItems {
    
    var items: [StoreItem]
    var count: Int {
        get { return items.count }
    }
    
    init(items: [StoreItem]) {
        self.items = items
    }
    
    public func append(_ newElement: StoreItem) {
        items.append(newElement)
    }
    
    public func popLast() -> StoreItem? {
        return items.popLast()
    }
    
    private func indexIsValid(index: Int) -> Bool {
        return index < items.count || index >= 0
        
    }
    subscript(index: Int) -> StoreItem {
        assert(indexIsValid(index: index), "Index out of range")
        return items[index]
    }
}
