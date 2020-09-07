//
//  APIManager.swift
//  SwiftApp
//
//  Created by WYH_MAC001 on 05/09/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum APIError: Error {
    case missingData
}

enum Result<T> {
    case success(T)
    case failure(Error)
}


final class APIManager{
    static let shared = APIManager()
    typealias SerializationFunction<T> = (Data?, Error?) -> Result<T>
    private var manager = Alamofire.Session(configuration: URLSessionConfiguration.default)
    
    @discardableResult
    private func getRequest<T>(_ url: URL, serializationFunction: @escaping SerializationFunction<T>, completion: @escaping (Result<T>) -> Void) -> Session{
        
        manager.request(url, method: .get).responseJSON { (response) in
            switch (response.result) {
            case .success:
                let result: Result<T> = serializationFunction(response.data, nil)
                DispatchQueue.main.async {
                    completion(result)
                }
            case .failure(let error):
                let result: Result<T> = serializationFunction(response.data, error)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
        return manager
    }

    @discardableResult
    func getRequest<T: Decodable>(_ url: URL, completion: @escaping (Result<T>) -> Void) -> Session{
        return getRequest(url, serializationFunction: serializeJSON, completion: completion)
    }
    
    private func serializeJSON<T: Decodable>(with data: Data?, error: Error?) -> Result<T> {
        if let error = error { return .failure(error) }
        guard let data = data else { return .failure(APIError.missingData) }
        do {
            let serializedValue = try JSONDecoder().decode(T.self, from: data)
            return .success(serializedValue)
        } catch let error {
            return .failure(error)
        }
    }
}
