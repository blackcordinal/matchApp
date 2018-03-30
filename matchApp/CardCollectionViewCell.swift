//
//  CardCollectionViewCell.swift
//  matchApp
//
//  Created by bkackcordinal on 29.03.2018.
//  Copyright © 2018 bkackcordinal. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    //Try to install image on card
    func setCard(_ card: Card){
        self.card = card
        if card.itsMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        if card.itsFlipped == true{
            // make sure the frontImageviev is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        } else {
            //make sure the backImageView on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
            
        }
    }
    
    func flip() {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }
    
    func backFlip() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
             UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
       
    }
    
    func remove() {
        //Remove image from grid
        backImageView.alpha = 0
        
        // Animate this
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
        
    }
    
}
