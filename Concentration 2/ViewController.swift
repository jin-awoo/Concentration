//
//  ViewController.swift
//  Concentration 2
//
//  Created by JINGYA HAN on 19/3/19.
//  Copyright © 2019 JINGYA HAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // UIViewController is the superclass
    private lazy var game =  Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return cardButtons.count/2
    }
    
    // class has this free initializer as long as cards are defined
    
    private(set) var flipCount = 0 {
        didSet{
            flipCountLabel.text = "flip count: \(flipCount)"
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Not Set.")
        }
    }
    
    // MARK: ONE
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.isFaceUp == true {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    
    private var emojiChoises = ["👻","🐧","🤪","🐴","🌚","💬","♾","🔆","💮","🈚️"]
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoises.count > 0{
            emoji[card.identifier] = emojiChoises.remove(at: emojiChoises.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

