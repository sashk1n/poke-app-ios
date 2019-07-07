//
//  LocationAreaDetail.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct LocationAreaEncounter: Codable {
    public let locationArea: Species
    public let versionDetails: [LocationAreaEncounterVersionDetail]
    
    enum CodingKeys: String, CodingKey {
        case locationArea = "location_area"
        case versionDetails = "version_details"
    }
    
    public init(locationArea: Species, versionDetails: [LocationAreaEncounterVersionDetail]) {
        self.locationArea = locationArea
        self.versionDetails = versionDetails
    }
}
