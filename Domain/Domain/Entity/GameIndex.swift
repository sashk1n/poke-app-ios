//
//  GameIndex.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct GameIndex: Codable {
    public let gameIndex: Int
    public let version: Species
    
    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
    
    public init(gameIndex: Int, version: Species) {
        self.gameIndex = gameIndex
        self.version = version
    }
}
