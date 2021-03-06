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
    
    private(set) var cards = [Card]()
    private var unshuffledCards = [Card]()
    private(set) var Score = 0
    private(set) var flipCount = 0
    private(set) var speedBonus = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
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
    
    var timer = Date()
    
    func calculateScore(currentScore: Int) -> Int {
        var newScore = currentScore
        for index in cards.indices {
            for secondIndex in cards.indices {
                if index != secondIndex, cards[index].isFaceUp, cards[index].seenOrNot == true, cards[secondIndex].isFaceUp, cards[secondIndex].seenOrNot == true, cards[index].identifier != cards[secondIndex].identifier {
                     newScore = currentScore - 1
                }
                if index != secondIndex, cards[index].isFaceUp, cards[secondIndex].isFaceUp, cards[index].identifier == cards[secondIndex].identifier {
                    newScore = currentScore + 2
                }
            }
        }
        if CFDateGetTimeIntervalSinceDate(Date() as CFDate, timer as CFDate) < 1.5 {
            newScore = currentScore + 1
            speedBonus += 1
        }
        timer = Date()
        return newScore
    }

    func chooseCard (at index: Int) {
        flipCount += 1
        assert(cards.indices.contains(index), "Concentration.choooseCard(at: \(index): Choosen index not in the cards.")
        if !cards[index].isMatched {
            print("------")
            print("Card index: \(index) and cards.count: \(cards.count) and card.id: \(cards[index].identifier)")
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // There is only one FaceUp card currently
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                Score = calculateScore(currentScore: Score)
                cards[index].seenOrNot = true
                cards[matchIndex].seenOrNot = true
            } else {
                // There are no cards or 2 cards facing up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)):  You must have at least one pair of cards.")
        cards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unshuffledCards += [card, card]
        }
        cards = shuffleCards(for: unshuffledCards)
    }
    
    // TODO: shuffle the cards
    
    private func shuffleCards(for cards: [Card]) -> [Card]{
        var temp = cards
        var shuffledCards = cards
        for index in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(temp.count)))
            shuffledCards[index] = temp.remove(at: randomIndex)
        }
        return shuffledCards
    }
    
}
