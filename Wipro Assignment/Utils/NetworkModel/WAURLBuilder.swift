//
//  WAURLBuilder.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 31/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

final class WAURLBuilder {
    private var components: URLComponents?
    
    public init(_ baseUrl: String) {
        self.components = URLComponents(string: baseUrl)
    }
    
    
    /// Invoke addQueryItem, when you want to add more query items in your URL
    /// e.g. - https://example.com?apikey=11111aaa
    ///
    /// - Parameters:
    ///   - key: set the key of query. apikey is key in the above example.
    ///   - value: set value to the key.
    /// - Returns: same instance of SPDNetworkURLBuilder
    public func addQueryItem<Element>(key: String, value: Element) -> WAURLBuilder  {
        if self.components?.queryItems == nil {
            self.components?.queryItems = []
        }
        self.components?.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
        return self
    }
    
    
    /// Invoke build, when you add all your query items. It will build the URL.
    ///
    /// - Throws: error, if unable to build url
    /// - Returns: returns URL
    public func build() throws -> URL {
        guard let url = self.components?.url else {
            throw WAError.validation(message: "Unable to fetch data. URL is broken")
        }
        
        return url
    }
}
