//
//  APIService.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 19.01.2024.
//

import Foundation

protocol Service {
    func makeRequest<T:Decodable>(with request: URLRequest,
                                  responseModel: T.Type,
                                  completion: @escaping (Result<T, APIError>) -> Void)
}

final class APIService: Service {
    static let shared = APIService()
    
    private let cache = NSCache<NSString, AnyObject>()

    func makeRequest<T: Decodable>(with request: URLRequest,
                                   responseModel: T.Type,
                                   completion: @escaping (Result<T, APIError>) -> Void) {
        if let url = request.url?.absoluteString,
           let cachedData = cache.object(forKey: url as NSString) as? T {
            completion(.success(cachedData))
            return
        }
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(.failure(.urlSessionError(error.localizedDescription)))
                return
            }

            if let response = response as? HTTPURLResponse,
               (response.statusCode != 200) {
                completion(.failure(.serverError()))
                return
            }
            
            guard let data = data
            else {
                completion(.failure(.invalidResponse()))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                if let url = request.url?.absoluteString {
                    self.cache.setObject(result as AnyObject, forKey: url as NSString)
                }
                completion(.success(result))
                
            } catch let error {
                print("Error at service call " + error.localizedDescription )
                completion(.failure(.decodingError()))
                return
            }
            
        }.resume()
        
    }
    
}
