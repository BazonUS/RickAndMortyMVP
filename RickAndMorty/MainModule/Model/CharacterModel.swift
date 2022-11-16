//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import Foundation

struct AllChar: Codable {
    let info: Info
    var results: [CharacterModel]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct CharacterModel: Codable, Hashable {
    
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
    
    static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Origin: Codable {
    var name: String
    var url: String
}

struct Location: Codable {
    var name: String
    var url: String
}
