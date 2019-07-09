//
//  NamedEntity.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct NamedEntity: Codable {
    public let name: String
    public let url: URL
    
    public init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}

// MARK: Pokemon hacks.
public extension NamedEntity {
    
    var pokemonId: Int? {
        guard let stringId = self.url.path.split(separator: "/").last else {
            return nil
        }
        return Int(stringId)
    }
    
    var pokemonImageURL: URL? {
        guard let pokemonId = self.pokemonId else {
            return nil
        }
        
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")
    }
}
