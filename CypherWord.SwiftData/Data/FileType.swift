//
//  FileType.swift
//  CypherWord.SwiftData
//
//  Created by Ian Plumb on 29/01/2025.
//


enum FileType:RawRepresentable {
    case level
     case layout

     init?(rawValue: Bool) {
         switch rawValue {
         case true: self = .level
         case false: self = .layout
         }
     }

     var rawValue: Bool {
         switch self {
         case .level: return true
         case .layout: return false
         }
     }
}
