//
//  InterfaceController.swift
//  diceRollWatch WatchKit Extension
//
//  Created by PC on 4/29/15.
//  Copyright (c) 2015 Randel Smith. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var twoDiceSwitch: WKInterfaceSwitch!
    
    @IBOutlet weak var firstDiceImage: WKInterfaceImage!
    @IBOutlet weak var secondDiceImage: WKInterfaceImage!
    
    private var diceImageNames : [String]!
    
    private var shouldShowTwoDice : Bool!
    
    private var firstDiceImages : NSMutableArray!
    private var secondDiceImages : NSMutableArray!
    
    private var timer : NSTimer!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        self.twoDiceSwitch.setEnabled(true)
        self.shouldShowTwoDice = true
        
        self.diceImageNames = ["dice01.png", "dice02.png","dice03.png","dice04.png","dice05.png","dice06.png"]
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if self.shouldShowTwoDice != true {
            self.secondDiceImage.setHidden(true)
        }
        
        self.firstDiceImages = []
        self.secondDiceImages = []
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func roll() {
        let firstDiceImages : NSMutableArray = []
        let secondDiceImages : NSMutableArray = []
       
        
        
        for var i = 0; i < 10; i++ {
            var randNumber = Int(arc4random_uniform(7))
            if randNumber > 0 {
                randNumber = randNumber - 1
            }
            var diceImage = UIImage(named: self.diceImageNames[randNumber])
            firstDiceImages.addObject(diceImage!)
            
            if self.shouldShowTwoDice == true {
                randNumber = Int(arc4random_uniform(7))
                if randNumber > 0 {
                    randNumber = randNumber - 1
                }
                diceImage = UIImage(named: self.diceImageNames[randNumber])
                secondDiceImages.addObject(diceImage!)
            }
            
        }
        
        self.firstDiceImage.setImage(UIImage.animatedImageWithImages(firstDiceImages as [AnyObject], duration:0))
        self.firstDiceImage.startAnimating()
        
        if self.shouldShowTwoDice == true {
            self.secondDiceImage.setImage(UIImage.animatedImageWithImages(secondDiceImages as [AnyObject], duration: 0))
            self.secondDiceImage.startAnimating()
        }
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("stopAnimation"), userInfo: nil, repeats: true)
        
        
        
    }
    
    func stopAnimation(){
        self.timer.invalidate()
        self.firstDiceImage.stopAnimating()
        self.secondDiceImage.stopAnimating()
    }
    
    @IBAction func didChangeValue(value: Bool) {
        self.shouldShowTwoDice = value
        
        if (self.shouldShowTwoDice == true) {
            self.secondDiceImage.setHidden(false)
        } else {
             self.secondDiceImage.setHidden(true)
        }
    }
}
