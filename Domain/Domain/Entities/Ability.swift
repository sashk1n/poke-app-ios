//
//  PokemonAbility.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct Ability: Codable {
    public let isHidden: Bool
    public let slot: Int
    public let ability: Species
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot, ability
    }
    
    public init(isHidden: Bool, slot: Int, ability: Species) {
        self.isHidden = isHidden
        self.slot = slot
        self.ability = ability
    }
}
