//
//  WANetworkManager.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import UIKit

class WANetworkManager<Response: Decodable>: NSObject {
    typealias CompletionHandler = (Result<Response, WAError>) -> Void
    
    private var url: URL
    private var request: Encodable?
    private var httpMethod: WAHTTPRequestMethod
    
    private var completionHandler: CompletionHandler?
    
    init(url: URL, request: Encodable? = nil, httpMethod: WAHTTPRequestMethod) {
        self.url        = url
        self.request    = request
        self.httpMethod = httpMethod
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
        urlRequest.httpMethod = self.httpMethod.value
        
        if let request = request {
            urlRequest.httpBody = try request.convertToData()
        }
        
        return urlRequest
    }
    
    
    /// Invoke this method to fetch data from URL.
    ///
    /// This will use the url, requested data (if any) and request method,
    /// that you have passed, while initiating the WANetworkManager.
    ///
    /// By using url, it will create a URLRequest instance.
    ///
    /// It will create data from request model instance and
    /// attach it to URLRequest instance
    ///
    /// Also It will attach the request method to URLRequest instance.
    ///
    /// - Parameters:
    ///   - onResult: onResult callback
    public func makeServiceRequest(completionHandler: @escaping CompletionHandler) {
        self.completionHandler = completionHandler
        do {
            guard WANetworkRechability.shared.isConnected else {
                completionHandler(.failure(.operation(message: "Your device is not connected with internet")))
                return
            }
            
            let session = URLSession(configuration: sessionConfig)
            session.dataTask(with: try getURLRequest()) { (data, urlResponse, error) in
                if let error = error {
                    completionHandler(.failure(.api(message: error.localizedDescription)))
                } else {
                    let httpUrlResponse: HTTPURLResponse = urlResponse as! HTTPURLResponse
                    if httpUrlResponse.statusCode == 200 {
                        self.parse(with: data, and: httpUrlResponse)
                    } else {
                        completionHandler(.failure(.api(message: "Unable to fetch data")))
                    }
                }
            }.resume()
            session.finishTasksAndInvalidate()
            
        } catch let error {
            completionHandler(.failure(.operation(message: error.localizedDescription)))
        }
    }
    
    
    /// Parse With Data and HTTPURLResponse
    ///
    /// Invoke this method, while parsing the JSON Data
    /// It supports Content-Type: application/json and text/plain
    ///
    ///
    /// - Parameters:
    ///   - data: data received from Service Request
    ///   - httpUrlResponse: httpUrlResponse received from Service Request
    private func parse(with data: Data?, and httpUrlResponse: HTTPURLResponse) {
        guard var unwrappedData = data else {
            self.completionHandler?(.failure(.api(message: "Unable to fetch data")))
            return
        }
        
        // Check if, content-type is text/plain in HTTPURLResponse header
        if let contentType: String = httpUrlResponse.allHeaderFields["Content-Type"] as? String,
            contentType == "text/plain; charset=ISO-8859-1" {
            // Convert the unwrapped data to responseString with .windowsCP1251 String Encoding pattern
            let responseString: String = String(data: unwrappedData, encoding: .windowsCP1251) ?? ""
            
            // convert the responseString to data again with .utf8 String Encoding pattern
            unwrappedData = responseString.data(using: .utf8) ?? Data()
        }
        
        do {
            
            let response = try JSONDecoder().decode(Response.self, from: unwrappedData)
            self.completionHandler?(.success(response))
            
        } catch let error {
            self.completionHandler?(.failure(.api(message: error.localizedDescription)))
        }
    }
}

fileprivate extension Encodable {
    func convertToData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
