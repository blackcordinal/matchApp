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
            
            var randomNumber = Int(arc4random_uniform(13) + 1)
            while !checkUniqueCard(randomNumber: randomNumber, array: generatedCards){
                randomNumber = Int(arc4random_uniform(13) + 1)
                
            }

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
            
            
            
            
            
        }
   
     
        //shuffle card Array
        
        for _  in 1..<generatedCards.count {
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCards.count)))
            let tempCard = generatedCards[randomNumber]
            generatedCards[randomNumber] = generatedCards[0]
            generatedCards[0] = tempCard
            
            
        }
        
        
        
        return generatedCards
    }
    // Make uniqe card in array
    func checkUniqueCard (randomNumber: Int, array: [Card] ) -> Bool {
        for card in array {
            if card.imageName == "card\(randomNumber)" {
                return false
            }
            
        }
        
        
        return true
        
    }
    
    
        

    
}
