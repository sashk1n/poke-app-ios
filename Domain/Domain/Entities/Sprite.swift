//
//  Sprite.swift
//  PokeApp
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct Sprites: Codable {
    public let backFemale: URL?
    public let backShinyFemale: URL?
    public let backDefault: URL?
    public let frontShinyFemale: URL?
    public let backShiny: URL?
    public let frontDefault: URL?
    public let frontShiny: URL?
    public let frontFemale: URL?
    
    enum CodingKeys: String, CodingKey {
        case backFemale = "back_female"
        case backShinyFemale = "back_shiny_female"
        case backDefault = "back_default"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
    public init(backFemale: URL?, 
                backShinyFemale: URL?, 
                backDefault: URL?, 
                frontFemale: URL?, 
                frontShinyFemale: URL?, 
                backShiny: URL?, 
                frontDefault: URL?, 
                frontShiny: URL?) {
        self.backFemale = backFemale
        self.backShinyFemale = backShinyFemale
        self.backDefault = backDefault
        self.frontFemale = frontFemale
        self.frontShinyFemale = frontShinyFemale
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}
