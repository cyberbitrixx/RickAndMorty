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
    ///   - handler: Completion handler (callback with data or error)
    public func execute(_ request: RMRequest, handler: @escaping () -> Void) {
        
    }
}

