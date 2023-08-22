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

    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }

    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - handler: Completion handler (callback with data or error)
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, handler: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            handler(.failure(RMServiceError.failedToCreateRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                handler(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
//        Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                handler(.success(result))
            } catch {
                handler(.failure(error))
            }
        }
        task.resume()
    }
    
    //    MARK: - Private
//    translating request into URL request because RMRequest returns String URL, not URL object
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod

        return request
    }

}


