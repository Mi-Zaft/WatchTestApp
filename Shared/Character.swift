//
//  Character.swift
//  WatchTestApp
//
//  Created by Максим Евграфов on 20.03.2025.
//

import Foundation

struct CharacterModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case imageUrl = "image"
    }
}

struct CharacterResult: Decodable {
    let results: [CharacterModel]
}
