//
//  Pokemon.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct Pokemon: Codable {
    public let id: Int
    public let name: String
    public let baseExperience, height: Int
    public let isDefault: Bool
    public let order, weight: Int
    public let abilities: [Ability]
    public let forms: [Species]
    public let gameIndices: [GameIndex]
    public let heldItems: [HeldItem]
    public let locationAreaEncounters: [LocationAreaEncounter]
    public let moves: [Move]
    public let species: Species
    public let sprites: Sprites
    public let stats: [Stat]
    public let types: [TypeElement]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order, weight, abilities, forms
        case gameIndices = "game_indices"
        case heldItems = "held_items"
        case locationAreaEncounters = "location_area_encounters"
        case moves, species, sprites, stats, types
    }
    
    public init(id: Int, 
                name: String, 
                baseExperience: Int, 
                height: Int, 
                isDefault: Bool, 
                order: Int, 
                weight: Int, 
                abilities: [Ability], 
                forms: [Species], 
                gameIndices: [GameIndex], 
                heldItems: [HeldItem], 
                locationAreaEncounters: [LocationAreaEncounter], 
                moves: [Move], 
                species: Species, 
                sprites: Sprites, 
                stats: [Stat], 
                types: [TypeElement]) {
        self.id = id
        self.name = name
        self.baseExperience = baseExperience
        self.height = height
        self.isDefault = isDefault
        self.order = order
        self.weight = weight
        self.abilities = abilities
        self.forms = forms
        self.gameIndices = gameIndices
        self.heldItems = heldItems
        self.locationAreaEncounters = locationAreaEncounters
        self.moves = moves
        self.species = species
        self.sprites = sprites
        self.stats = stats
        self.types = types
    }
}
