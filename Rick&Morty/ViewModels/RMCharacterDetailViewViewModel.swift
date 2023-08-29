//
//  File.swift
//  Rick&Morty
//
//  Created by sofia on 28.08.2023.
//

import Foundation

/// Model that handles single character detail view configuration and set up
final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
