//
//  RMCharacterCollectionViewCellViewModel.swift
//  Rick&Morty
//
//  Created by sofia on 15.08.2023.
//

import Foundation

/// Model that handles configuring a single Character cell instance to be further used in Character list ViewModel
final class RMCharacterCollectionViewCellViewModel {
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    
//    MARK: - Init
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageUrl: URL?){
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var charaterStatusText: String {
        return characterStatus.rawValue
    }
    
    public func fetchImage(handler: @escaping (Result<Data, Error>) -> Void) {
//        TODO: Abstract to Image Manager
         guard let url = characterImageUrl else {
            handler(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                handler(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            handler(.success(data))
        }
        task.resume()
    }
}
