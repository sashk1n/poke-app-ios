//
//  NetworkManager.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public final class NetworkClient {
    
    public class func request<T: Codable>(route: NetworkRoute, 
                                          completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.host
        components.path = route.path
        components.queryItems = route.parameters
        
        guard let url = components.url else { 
            return 
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.method
        
        // Log requests.
        print("\(route.method): \(url)")
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                error.map { completion(.failure($0)) }
                print(String(describing: error?.localizedDescription))
                return
            }
            
            // TODO: Uncomment for debug.
            //debugPrint(data?.prettyPrintedJSONString ?? "nil")
            
            guard response != nil else {
                return
            }
            guard let data = data else {
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            // TODO: resolve REST errors
            do {
                let responseObject = try jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch {
                completion(.failure(error))
                print(String(describing: error))
            }
        }
        dataTask.resume()
    }
}

// MARK: Pretty printed JSON
private extension Data {
    
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
