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
    lazy var game =  Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return cardButtons.count/2
    }
    
    // class has this free initializer as long as cards are defined
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "flip count: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Not Set.")
        }
    }
    
    // MARK: ONE
    
    func updateViewFromModel(){
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
    
    
    var emojiChoises = ["👻","🐧","🤪","🐴","🌚","💬","♾","🔆","💮","🈚️"]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoises.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
            emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

