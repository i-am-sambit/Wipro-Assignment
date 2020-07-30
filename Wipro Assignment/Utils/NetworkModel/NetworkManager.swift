//
//  NetworkHandler.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import UIKit

class NetworkManager<Response: Decodable>: NSObject {
    private var url: URL
    private var request: Encodable?
    private var requestType: NetworkRequestType
    
    init(url: URL, request: Encodable? = nil, type: NetworkRequestType) {
        self.url         = url
        self.request     = request
        self.requestType = type
    }
    
    private let sessionConfig: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 300.0
        sessionConfiguration.timeoutIntervalForResource = 300.0
        return sessionConfiguration
    }()
    
    
    /// getURLRequest
    ///
    /// - Returns: URLRequest instance
    /// - Throws: error while enoding request
    private func getURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.requestType.value
        urlRequest.addValue("text/html", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("text/html", forHTTPHeaderField: "Accept")
        
        if let request = request {
            urlRequest.httpBody = try request.convertToData()
        }
        
        return urlRequest
    }
    
    
    /// Request
    ///
    /// - Parameters:
    ///   - onResult: onResult callback
    public func request(completionHandler: @escaping((Result<Response, Error>) -> Void)) {
        
        do {
            
            let session = URLSession(configuration: sessionConfig)
            session.dataTask(with: try getURLRequest()) { (data, urlResponse, error) in
                if let error = error {
                    completionHandler(.failure(error))
                    
                } else {
                    let httpUrlResponse: HTTPURLResponse = urlResponse as! HTTPURLResponse
                    if httpUrlResponse.statusCode == 200 {
                        
                        guard var unwrappedData = data else { return }
                        
                        if let contentType: String = httpUrlResponse.allHeaderFields["Content-Type"] as? String, contentType == "text/plain; charset=ISO-8859-1" {
                            let responseString: String = String(data: unwrappedData, encoding: String.Encoding.windowsCP1251) ?? ""
                            unwrappedData = responseString.data(using: .utf8) ?? Data()
                        }
                        
                        do {
                            
                            let response = try JSONDecoder().decode(Response.self, from: unwrappedData)
                            completionHandler(.success(response))
                            
                        } catch let error {
                            completionHandler(.failure(error))
                        }
                        
                    } else {
                        print("status code : \(httpUrlResponse.statusCode)")
                    }
                }
            }.resume()
            session.finishTasksAndInvalidate()
            
        } catch let error {
            completionHandler(.failure(error))
            
        }
        
    }
    
    func convertDictonaryToJSON<Response: Decodable>(dictionary: [String: Any]) throws -> Response {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let jsonResponse = try decoder.decode(Response.self, from: jsonData)
        return jsonResponse
    }
}

fileprivate extension Encodable {
    func convertToData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
