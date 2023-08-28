//
//  RMCharacterStatus.swift
//  Rick&Morty
//
//  Created by sofia on 08.08.2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
//    'Alive', 'Dead' or 'unknown'
    case alive = "Alive"
    case dead = "Dead"
    case  unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
