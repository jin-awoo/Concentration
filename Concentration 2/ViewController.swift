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
    
    @IBAction func newGame(_ sender: UIButton) {
        Card.identifierFactory = 0
        emoji = [Int: String]()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        getEmojiChoises()
        getColors()
        updateViewFromModel()
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var score: UILabel!
    
    @IBOutlet weak var speedBonus: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Not Set.")
        }
    }
    
    private func updateViewFromModel(){
        self.view.backgroundColor = themeOfColorsChoice[2]
        for index in cardButtons.indices{
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.isFaceUp == true {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = themeOfColorsChoice[0]
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themeOfColorsChoice[1]
            }
        }
        flipCountLabel.text = "flip count: \(game.flipCount)"
        score.text = "score: \(game.Score)"
        speedBonus.text = "Speed Bonus: \(game.speedBonus)"
    }
    
    var indexOfRandomTheme = 0
    
    private func getEmojiChoises() {
        var themes = [[String]]()
        themes.append(["😀","😁","🤪","😋","😎","😏","😛","😤","😵","😬"])
        themes.append(["💟","☮️","✝️","☪️","🕉","☸️","✡️","🔯","🕎","☯️"])
        themes.append(["Ⓜ️","💤","🏧","🚾","♿️","🅿️","🈳","🈂️","🛂","🛄"])
        themes.append(["🉐","㊙️","㊗️","🈲","🅰️","🆘","🈵","‼️","🈴","🈹"])
        
        indexOfRandomTheme = themes.count.arc4random
        emojiChoises = themes[indexOfRandomTheme]
    }
    
    private var themeOfColorsChoice = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    
    private func getColors() {
        var themeOfColors = [[UIColor]]()
        themeOfColors.append([#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        themeOfColors.append([#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)])
        themeOfColors.append([#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)])
        themeOfColors.append([#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)])
        themeOfColorsChoice = themeOfColors[indexOfRandomTheme]
    }
    
    private var emojiChoises = ["😀","😁","🤪","😋","😎","😏","😛","😤","😵","😬"]
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
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

