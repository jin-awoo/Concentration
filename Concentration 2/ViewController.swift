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
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "flip count: \(flipCount)"
        }
    }
    
    var emojiChoises = ["👻","🎃","👻","🎃"]
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            flipCard(on: sender, withEmoji: emojiChoises[cardNumber])
        } else {
            print("Not Set.")
        }
    }
    
    
    
    func flipCard(on button: UIButton, withEmoji emoji: String){
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    

}

