//
//  NetworkManager.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
  case emptyUrl
  case emptyResponse
  case emptyData
  case decodingError
}

public typealias NetworkHandler<T> = (Result<T, Error>) -> ()

public final class NetworkClient {

    public class func request<T: Codable>(route: NetworkRoute, 
                                          completion: @escaping NetworkHandler<T>) {
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.host
        components.path = route.path
        components.queryItems = route.parameters
        
        guard let url = components.url else { 
            completion(.failure(NetworkError.emptyUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.method
        
        // Log requests.
        print("\(route.method): \(url)")
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    print(String(describing: error.localizedDescription))
                }
                return
            }
            
            // TODO: Uncomment for debug.
            //debugPrint(data?.prettyPrintedJSONString ?? "nil")
            
            guard response != nil else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.emptyResponse))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.emptyData))
                }
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
