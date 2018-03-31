//
//  ViewController.swift
//  matchApp
//
//  Created by bkackcordinal on 29.03.2018.
//  Copyright © 2018 bkackcordinal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var model = CardModel()
    var cardArray = [Card]()
    var timer:Timer?
    var milliSeconds: Float = 10 * 1000
    
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        cardArray = model.getCards()
        
        //create Timer
        timer = Timer.scheduledTimer(timeInterval:  0.001 , target: self, selector: #selector(timeElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Timer logic
    @objc func timeElapsed() {
        milliSeconds -= 1
        //convert to seconds
        let seconds = String(format: "%.2f", milliSeconds/1000)
        
        //set label
        timerLabel.text = seconds
        //stop timer
        
        if milliSeconds <= 0 {
            //stop timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            //check game
            checkGameEnded()
            
            
        }
        
    }
    
    
    //MARK: - UICollectionView Protocol implementation
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Get an CollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Check time remaining
        if milliSeconds <= 0 {
            return
        }
        
        
        let cell = CollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        
        if card.itsFlipped == false && card.itsMatched == false {
            //flip card
            cell.flip()
            card.itsFlipped = true
            
            //Determine if it's first or second card
            if  firstFlippedCardIndex == nil {
                //This first card set
                firstFlippedCardIndex = indexPath
                
            } else {
                //This second card
                
                
                //TODO: make logic
                checkForMatches(indexPath )
            }
        
        } else {
            //back flip card
            cell.backFlip()
            card.itsFlipped = false 
        }
        
        
        
    }
 
    //MARK: Game logic
    
    func checkForMatches(_ secondFlippedCardIndex: IndexPath){
        //Get cells for two cards
        let cardOneCell = CollectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = CollectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //Get two cards
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //Match cards
        if cardOne.imageName == cardTwo.imageName {
            //It's match
            
            //set the statuses of the card
            cardOne.itsMatched = true
            cardTwo.itsMatched = true
            
            //Remove cards from grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //Check game for end
            checkGameEnded()
             
        } else {
            //It's not match
            
            //set statuses cards
            cardOne.itsFlipped = false
            cardTwo.itsFlipped = false
            
            //flip back cards
            cardOneCell?.backFlip()
            cardTwoCell?.backFlip()
        }
        // Tell the collectionViewCell to reload of the first card is nil
        if cardOneCell == nil {
            CollectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        //Reset the track the first card flipped
        
        firstFlippedCardIndex = nil
        
    }
    
    func checkGameEnded() {
        //Determine if any cards unmatched
        var isWon = true
        for card in cardArray {
            if card.itsMatched == false {
                isWon = false
                break
            }
        }
        // Messages
        var title = ""
        var message = ""
        
        // If user won stop timer
        if isWon == true {
            if milliSeconds > 0 {
                timer?.invalidate()
            }
            title = "Congratulation"
            message = "You won"
            
        } else {
            //check left time
            if milliSeconds > 0 {
                return
            }
            title = "Game over"
            message = "You loser"
        }
        // Message user
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}

