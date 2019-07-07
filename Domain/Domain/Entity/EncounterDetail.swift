//
//  EncounterDetail.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct EncounterDetail: Codable {
    public let minLevel, maxLevel: Int
    public let conditionValues: [Species]
    public let chance: Int
    public let method: Species
    
    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
        case maxLevel = "max_level"
        case conditionValues = "condition_values"
        case chance, method
    }
    
    public init(minLevel: Int, maxLevel: Int, conditionValues: [Species], chance: Int, method: Species) {
        self.minLevel = minLevel
        self.maxLevel = maxLevel
        self.conditionValues = conditionValues
        self.chance = chance
        self.method = method
    }
}
