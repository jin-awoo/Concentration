//
//  Card.swift
//  Concentration 2
//
//  Created by JINGYA HAN on 26/3/19.
//  Copyright © 2019 JINGYA HAN. All rights reserved.
//

import Foundation

// Model

// struct has no inheritance
// struct is a value type ( Int dict are all struct)
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    // static fun & var are tied to the type. Think of it as a Global function or var
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
