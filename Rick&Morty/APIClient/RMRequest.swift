//
//  RMRequest.swift
//  Rick&Morty
//
//  Created by sofia on 03.08.2023.
//

import Foundation


/// Object that represents a single API call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    
    /// Desired API endpoint
    private let endpoint: RMEndpoint
    
    
    /// Desired path components, if any
    private let pathComponents: Set<String>
    
    
    /// Desired path components, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed URL for the API request in String format
    public var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += ("/\($0)")
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    
    /// Computed and constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    /// Desired API http method
    public let httpMethod = "GET"
    
//    MARK: - Public
    
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Set of path components
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: RMEndpoint, pathComponents: Set<String> = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
