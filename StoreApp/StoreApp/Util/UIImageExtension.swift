//
//  ImageManager.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/14.
//

import UIKit
import NetworkHelper


extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}

extension URL {
    func toUIImage() -> UIImage? {
        do {
            let data = try Data(contentsOf: self)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}

extension UIImageView {
    
    func setImageFromLocalOrNetwork(path : String, fileName: String) {
        guard let fileURL = try? FileManager.default.url(for: .cachesDirectory,
                                                         in: .userDomainMask,
                                                         appropriateFor: nil,
                                                         create: false)
                .appendingPathComponent(fileName) else { return }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            self.setImageFromLocal(url: fileURL)
        } else {
            self.setImageFromNetwork(path: path, fileName: fileName)
        }
    }
    
    func setImageFromLocal(url: URL) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } catch {
                self.image = nil
            }
        }
    }
    
    func setImageFromNetwork(path: String, fileName: String) {
        NetworkLayer.shared.downloadTaskToCache(from: path, name: fileName) {
            (result: Result<URL,APIError>) in
            switch result {
            case .success(let url):
                self.setImageFromLocal(url: url)
            case .failure(let error):
                print(error)
            }
        }
    }
}

