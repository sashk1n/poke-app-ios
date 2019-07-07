//
//  LocationAreaEncounterVersionDetail.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct LocationAreaEncounterVersionDetail: Codable {
    public let maxChance: Int
    public let encounterDetails: [EncounterDetail]
    public let version: Species
    
    enum CodingKeys: String, CodingKey {
        case maxChance = "max_chance"
        case encounterDetails = "encounter_details"
        case version
    }
    
    public init(maxChance: Int, encounterDetails: [EncounterDetail], version: Species) {
        self.maxChance = maxChance
        self.encounterDetails = encounterDetails
        self.version = version
    }
}
