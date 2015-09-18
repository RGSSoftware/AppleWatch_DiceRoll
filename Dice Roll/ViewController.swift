//
//  ViewController.swift
//  diceRollWatch
//
//  Created by PC on 4/29/15.
//  Copyright (c) 2015 Randel Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var twoDiceSwitch: UISwitch!

    @IBOutlet weak var firstDiceImage: UIImageView!
    @IBOutlet weak var secondDiceImage: UIImageView!
    
    private var diceImageNames : [String]!
    
    private var finalfirstDiceImage : UIImage!
    private var finalSecondDiceImage : UIImage!
    
    private var timer : NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.diceImageNames = ["dice01.png", "dice02.png","dice03.png","dice04.png","dice05.png","dice06.png"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func roll(sender: AnyObject) {
        let firstDiceImages : NSMutableArray = []
        let secondDiceImages : NSMutableArray = []
        
        
        
        for var i = 0; i < 10; i++ {
            var randNumber = Int(arc4random_uniform(7))
            if randNumber > 0 {
                randNumber = randNumber - 1
            }
            var diceImage = UIImage(named: self.diceImageNames[randNumber])
            firstDiceImages.addObject(diceImage!)
            
            if self.twoDiceSwitch.on == true {
                randNumber = Int(arc4random_uniform(7))
                if randNumber > 0 {
                    randNumber = randNumber - 1
                }
                diceImage = UIImage(named: self.diceImageNames[randNumber])
                secondDiceImages.addObject(diceImage!)
            }
            
        }
        
        self.finalfirstDiceImage = firstDiceImages[firstDiceImages.count - 1] as! UIImage
       
        
        self.firstDiceImage.animationImages = firstDiceImages as [AnyObject]
        self.firstDiceImage.startAnimating()
        
        if self.twoDiceSwitch.on == true {
             self.finalSecondDiceImage = secondDiceImages[secondDiceImages.count - 1] as! UIImage
            
            self.secondDiceImage.animationImages = secondDiceImages as [AnyObject]
            self.secondDiceImage.startAnimating()
        }
        
        
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("stopAnimation"), userInfo: nil, repeats: true)
    }
    
    func stopAnimation(){
        self.timer.invalidate()
        self.firstDiceImage.stopAnimating()
        self.secondDiceImage.stopAnimating()
        
        self.firstDiceImage.image = self.finalfirstDiceImage
        if self.twoDiceSwitch.hidden == false {
            self.secondDiceImage.image = self.finalSecondDiceImage
        }
        
    }
    @IBAction func twoDiceValueChanged(sender: AnyObject) {
        if((sender as! UISwitch).on){
            self.secondDiceImage.hidden = false
        } else {
            self.secondDiceImage.hidden = true
        }
    }
}

