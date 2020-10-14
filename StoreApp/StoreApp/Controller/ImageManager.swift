//
//  ImageManager.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/14.
//

import UIKit
import NetworkHelper

func getImageByString(name: String) -> UIImage? {
    guard let url = URL(string: name) else { return nil }
    do {
        let data = try Data(contentsOf: url)
        return UIImage(data: data)
    } catch {
        return nil
    }
}


func setImageFromLocalOrNetwork(imageView: UIImageView, item: StoreItem) {
    
    guard
        let fileURL = try? FileManager.default.url(for: .cachesDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
            .appendingPathComponent(item.detailHash) else { return }
    
    if FileManager.default.fileExists(atPath: fileURL.path) {
        setImage(to: imageView, url: fileURL)
    } else {
        NetworkLayer.shared.downloadTaskToCache(from: item.image, name: item.detailHash) {
            (result: Result<URL,APIError>) in
            switch result {
            case .success(let url):
                setImage(to: imageView, url: url)
            case .failure(let error):
                print(error)
            }
        }
    }
}

private func setImage(to target: UIImageView, url: URL) {
    DispatchQueue.global().async {
        do {
            let data = try Data(contentsOf: url)
            DispatchQueue.main.async {
                target.image = UIImage(data: data)
            }
        } catch {
            target.image = nil
        }
    }
}
