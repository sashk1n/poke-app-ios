//
//  Page.swift
//  Domain
//
//  Created by marcenuk on 07/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import Foundation

public struct Page: Codable {
    public let count: Int
    public let next: URL?
    public let previous: URL?
    public let results: [NamedEntity]
    
    public init(count: Int, 
                next: URL?, 
                previous: URL?, 
                results: [NamedEntity]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
