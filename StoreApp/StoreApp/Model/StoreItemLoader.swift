//
//  DataLoader.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/06.
//

import Foundation

class StoreItemLoader {
    
    private init() {
        
    }
    
    public static func load(name: String) -> [StoreItem]? {
        if let data = readLocalFile(forName: name) {
            return parse(jsonData: data)
        }
        return nil
    }
    
    private static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private static func parse(jsonData: Data) -> [StoreItem]? {
        do {
            let storeItems = try JSONDecoder().decode([StoreItem].self,
                                                       from: jsonData)
            return storeItems
        } catch {
            print("decode error")
        }
        return nil
    }
}
