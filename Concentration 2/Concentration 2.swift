//
//  Concentration 2.swift
//  Concentration 2
//
//  Created by JINGYA HAN on 26/3/19.
//  Copyright © 2019 JINGYA HAN. All rights reserved.
//

import Foundation

// Model
// This is public API

class Concentration {
    
    var cards = [Card]()
    var unshuffledCards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if  foundIndex == nil {
                        foundIndex =  index
                    } else {
                        foundIndex = nil 
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // There is only one FaceUp card currently
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // There are no cards or 2 cards facing up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            unshuffledCards += [card, card]
        }
        cards = shuffleCards(for: unshuffledCards)
    }
    
    // TODO: shuffle the cards
    
    func shuffleCards(for cards: [Card]) -> [Card]{
        var temp = cards
        var shuffledCards = cards
        for index in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(temp.count)))
            shuffledCards[index] = temp.remove(at: randomIndex)
        }
        return shuffledCards
    }
    
}
