//
//  Character.swift
//  WatchTestApp
//
//  Created by Максим Евграфов on 20.03.2025.
//

import Foundation

struct CharacterModel: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let imageUrl: URL?
    
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        return dictionary
    }
    
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
