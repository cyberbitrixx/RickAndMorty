//
//  RMEpisode.swift
//  Rick&Morty
//
//  Created by sofia on 24.07.2023.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
