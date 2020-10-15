//
//  NetworkHelper.swift
//  NetworkHelper
//
//  Created by 채훈기 on 2020/10/12.
//

import Foundation

public enum APIError: Error {
    case url
    case data
    case decodingJSON
}

public class NetworkLayer {
    
    public static let shared = NetworkLayer()
    
    private init() {
        
    }
    
    public func dataTask<T: Decodable>(from url: String, completion: @escaping (Result<T,APIError>) -> Void) {

        guard let url = URL(string: url) else { return completion(.failure(.url))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data else {
                return completion(.failure(.data))
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.decodingJSON))
            }
            
        }.resume()
    }
    
    public func downloadTaskToCache(from url: String, name: String, completion: @escaping (Result<URL,APIError>) -> Void) {
    
        guard let url = URL(string: url) else { return completion(.failure(.url)) }

        URLSession.shared.downloadTask(with: url) { urlOrNil, responseOrNil, errorOrNil in
            
            guard let fileURL = urlOrNil else { return completion(.failure(.url)) }
            
            do {
                let cacheURL = try
                    FileManager.default.url(for: .cachesDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                let savedURL = cacheURL.appendingPathComponent(name)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
                completion(.success(savedURL))

            } catch {
                completion(.failure(.data))
            }
        }.resume()
    }
    
    public func postData(url: URL, data: Data) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")        
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
    }
    
    
}

