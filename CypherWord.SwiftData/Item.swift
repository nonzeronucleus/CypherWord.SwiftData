//
//  Item.swift
//  CypherWord.SwiftData
//
//  Created by Ian Plumb on 26/01/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
