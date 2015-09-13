 //
//  ExpertViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 8/29/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit

class ExpertViewController: UIViewController {
    
    @IBOutlet weak var gramsView: UIView!
    @IBOutlet weak var gramScalGr: UIView!
    @IBOutlet weak var gramsDisplay: UILabel!
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var gramsDisplayView: UIView!
    @IBOutlet weak var centerPointer: UILabel!
    
    @IBOutlet weak var circle1: UILabel!
    @IBOutlet weak var circle2: UILabel!
    @IBOutlet weak var circle3: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var hintText: UILabel!
    @IBOutlet weak var hintText2: UILabel!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    enum timerStates {
        case Idle
        case Active
        case Done
    }
    
    var timerState : timerStates = .Idle
    
    let myBlueColor = UIColor.init(red: 39/255, green: 179/255, blue: 225/255, alpha: 0.8)
    var origXgrams : CGFloat = 0
    var doseGrams : Float = 18 {
        didSet {
            minYield = round(doseGrams*10)/10 * 1.8
            maxYield = round(doseGrams*10)/10 * 2.5
        }
    }
    var yieldGrams : Float = 0
    
    var minYield : Float = 0
    var maxYield : Float = 0
    
    var oneGram : Float = 0
    var currentGrams : Float = 50
    
    let aSel : Selector = "timerStep"
    var timer = NSTimer()
    var currentTimer = 0
    var targetTimerSetting = 25
    
    var lastShot = espressoShot()
    var shots = [espressoShot]()
    
    func timerStep() {
        
        if currentTimer < 60 {
            currentTimer++
        } else {
            stopTimer()
        }
        
        timerDisplay.text = String(currentTimer)
        if currentTimer == targetTimerSetting {
            timerDisplay.textColor = UIColor.redColor()
            //play final sound here
        } else {
            timerDisplay.textColor = UIColor.blackColor()
        }
        if currentTimer >= targetTimerSetting-3 && currentTimer < targetTimerSetting {
            // play warning sounds here
        }
    }
    
    func stopTimer () {
        
        // Visuals and Mechanics
        
        timer.invalidate()
        
        timerState = .Done
        
        gramsDisplay.textColor = self.myBlueColor
        gramsDisplay.text = String(format: "%.01f", self.yieldGrams)
        
        centerPointer.textColor = myBlueColor
    }
    
    @IBAction func actionBtnTap(sender: UIButton) {
        tapOnTimer(nil)
    }
    
    
    @IBAction func tapOnTimer(sender: UITapGestureRecognizer?) {
        
        if timerState == .Idle {
            
            circle1.text = "○"
            circle2.text = "◉"
            
            // play START sound
            
            infoButton.enabled = false
            historyButton.enabled = false
            
            timerState = .Active
            timerDisplay.text = "0"
            currentTimer = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSel, userInfo: nil, repeats: true)
            
            hintText2.text = "At " + String(format: "%.01f", doseGrams) + "g dose of coffee, your espresso should weigh " + String(format: "%.01f", minYield) + " to " + String(format: "%.01f", maxYield) + " grams"
            
            
            hintText.alpha = 0
            actionButton.setTitle("STOP BREWING", forState: .Normal)
            gramsView.alpha = 0
            gramsDisplay.alpha = 0
            actionButton.alpha = 1
            
            UIView.animateWithDuration(0.3, animations: {
                self.hintText2.alpha = 1
            })
            
        } else if timerState == .Active {
            
            circle2.text = "○"
            circle3.text = "◉"
            
            hintText.text = "Pick your espresso weight"
            hintText.alpha = 1
            
            yieldGrams = (maxYield + minYield) / 2
            
            setScaleTo(yieldGrams, animate: true)
            stopTimer()
            
            actionButton.setTitle("BREW NOW", forState: .Normal)
            
            UIView.animateWithDuration(0.3, animations: {
                self.gramsView.alpha = 1
                self.gramsDisplayView.alpha = 1
            })
            
            hintText2.alpha = 0
            actionButton.alpha = 0
            saveButton.alpha = 1
            discardButton.alpha = 1
            
        } else if timerState == .Done {
            
            circle3.text = "○"
            circle1.text = "◉"
            
            timerState = .Idle
            
            // Save last Shot
            
            lastShot.dose = Float(round(doseGrams*10)/10)
            lastShot.time = currentTimer
            lastShot.yield = Float(round(yieldGrams*10)/10)
            
            // Set scale to last shot's grams
            hintText.text = "Grind and weigh your coffee"
            setScaleTo(lastShot.dose, animate: true)
            
            UIView.animateWithDuration(0.3, animations: {
                self.timerDisplay.text = "0"
            })
            
            infoButton.enabled = true
            historyButton.enabled = true
            discardButton.alpha = 0
            saveButton.alpha = 0
            actionButton.alpha = 1
            
            // Record data
            
            shots.append(lastShot)
        }
    }
    
    func setScaleTo (targetSetting: Float, animate: Bool) {
        
        let gramsDelta = currentGrams - targetSetting
        let xOffset = gramsDelta * oneGram
        currentGrams = targetSetting

        if animate {
            
            let options = UIViewAnimationOptions.CurveEaseInOut
            
            UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: options, animations: {
                
                self.gramScalGr.frame = CGRect(x: self.gramScalGr.frame.origin.x + CGFloat(xOffset), y: self.gramScalGr.frame.origin.y, width: self.gramScalGr.frame.width, height: self.gramScalGr.frame.height)
                
                }, completion: nil)

        } else {
            self.gramScalGr.frame = CGRect(x: self.gramScalGr.frame.origin.x + CGFloat(xOffset), y: self.gramScalGr.frame.origin.y, width: self.gramScalGr.frame.width, height: self.gramScalGr.frame.height)
        }
        
        gramsDisplay.text = String(targetSetting)
    }
    
    @IBAction func panGrams(sender: UIPanGestureRecognizer) {
        
        switch sender.state.rawValue {
        case 1 :
            origXgrams = gramScalGr.frame.origin.x
        case 2 :
            
            if timerState != .Active {
                
                let offsetX = sender.translationInView(sender.view).x
                let newX = origXgrams + offsetX
                
                if newX <= 0 && gramScalGr.frame.maxX > gramsView.frame.maxX-offsetX {
                    gramScalGr.frame = CGRect(x: newX, y: gramScalGr.frame.origin.y, width: gramScalGr.frame.width, height: gramScalGr.frame.height)
                    
                    if timerState == .Idle {
                        doseGrams = currentGrams - Float(offsetX) / oneGram
                        gramsDisplay.text = String(format: "%.01f", doseGrams)
                    } else if timerState == .Done {
                        yieldGrams = currentGrams - Float(offsetX) / oneGram
                        gramsDisplay.text = String(format: "%.01f", yieldGrams)
                    }
                }
            }
            
        case 3 :

            if timerState == .Idle {
                currentGrams = doseGrams
            } else if timerState == .Done {
                currentGrams = yieldGrams
            }
            
        default : break
    }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        oneGram = Float(gramScalGr.frame.width / 100)
        timerDisplay.text = "0"
        doseGrams = 16
        UIApplication.sharedApplication().idleTimerDisabled = true
        hintText2.alpha = 0
        saveButton.alpha = 0
        discardButton.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        setScaleTo(doseGrams, animate: false)
        doseGrams = 18
        setScaleTo(doseGrams, animate: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showHistoryVC" {
            let finalizeVC = segue.destinationViewController as! HistoryViewController
            finalizeVC.lastShot = lastShot
            finalizeVC.allShots = shots
        }
    }
}
