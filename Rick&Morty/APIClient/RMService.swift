//
//  RMService.swift
//  Rick&Morty
//
//  Created by sofia on 03.08.2023.
//

import Foundation



/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    
    /// Privitized constructor
    private init() {}
    
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - handler: Completion handler (callback with data or error)
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, handler: @escaping (Result<T, Error>) -> Void) {
        
    }
}

