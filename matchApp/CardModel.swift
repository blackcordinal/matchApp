//
//  CardModel.swift
//  matchApp
//
//  Created by bkackcordinal on 29.03.2018.
//  Copyright © 2018 bkackcordinal. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card]  {
        
        var generatedCards = [Card]()
        
        for _ in 1...8 {
            
            let randomNumber = arc4random_uniform(13) + 1
            //log the number
            print(randomNumber)
            
            //create first card object
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            generatedCards.append(cardOne)
            
            //create pair card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            generatedCards.append(cardTwo)
            
            
            //OPTIONAL: make unique cards in array
        }
        
        
        
        
        
        return generatedCards
    }
    
}