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
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        cardArray = model.getCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = CollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        
        if card.itsFlipped == false {
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
             
        } else {
            //It's not match
            
            //set statuses cards
            cardOne.itsFlipped = false
            cardTwo.itsFlipped = false
            
            //flip back cards
            cardOneCell?.backFlip()
            cardTwoCell?.backFlip()
        }
        firstFlippedCardIndex = nil
    }
    
}

