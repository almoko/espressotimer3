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
    @IBOutlet weak var gramsInDisplay: UILabel!
    @IBOutlet weak var targetYieldMin: UILabel!
    @IBOutlet weak var targetYieldMax: UILabel!
    @IBOutlet weak var buttonMore: UIButton!
    @IBOutlet weak var buttonLess: UIButton!
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var gramsOutDisplay: UILabel!
    
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
    
    @IBAction func setTimerTarget(sender: UIButton) {
        
        if timerState == .Idle {
            switch sender.currentTitle! {
            case ">" : if targetTimerSetting < 40 { targetTimerSetting++ }
            case "<" : if targetTimerSetting > 1 { targetTimerSetting-- }
            default : print("wrong button")
            }
            timerDisplay.text = String(targetTimerSetting)
        }
    }
    
    func timerStep() {
        
        if currentTimer < 40 {
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
        
        buttonLess.enabled = true
        buttonMore.enabled = true
        buttonLess.alpha = 1
        buttonMore.alpha = 1
        
        // Record data
        
        gramsOutDisplay.alpha = 1
        targetYieldMax.alpha = 0
        targetYieldMin.alpha = 0
        gramsOutDisplay.textColor = myBlueColor
        gramsInDisplay.textColor = UIColor.grayColor()
        gramsOutDisplay.text = String(format: "%.01f", yieldGrams)
        
        if #available(iOS 8.2, *) {
            gramsInDisplay.font = UIFont.systemFontOfSize(60, weight: UIFontWeightThin)
        } else {
            // Fallback on earlier versions
        }
        
        // Play STOP sound
        
        shots.append(lastShot)
        
        // Show YIELD reading Finalize VC
        
//        self.performSegueWithIdentifier("finalizeShot", sender: self)
    }
    
    
    @IBAction func tapOnTimer(sender: UITapGestureRecognizer) {
        
        if timerState == .Idle {
            
            // play START sound
            
            timerState = .Active
            timerDisplay.text = "0"
            currentTimer = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSel, userInfo: nil, repeats: true)
            
            buttonLess.enabled = false
            buttonMore.enabled = false
            buttonLess.alpha = 0.6
            buttonMore.alpha = 0.6
            
        } else if timerState == .Active {
            
            yieldGrams = (maxYield + minYield) / 2
            
            setScaleTo(yieldGrams, animate: true)
            stopTimer()
            
        } else if timerState == .Done {
            
            timerState = .Idle
            
            // Save last Shot
            
            lastShot.dose = Float(round(doseGrams*10)/10)
            lastShot.time = currentTimer
            lastShot.yield = Float(round(yieldGrams*10)/10)
            
            // Set scale to last shot's grams
            
            setScaleTo(lastShot.dose, animate: true)
            
            // Re-initialize timer
            
            timerDisplay.text = "0"
            targetYieldMax.alpha = 1
            targetYieldMin.alpha = 1
            gramsOutDisplay.alpha = 0
            gramsOutDisplay.textColor = UIColor.blackColor()
            
            gramsInDisplay.textColor = myBlueColor
            
            if #available(iOS 8.2, *) {
                gramsInDisplay.font = UIFont.systemFontOfSize(60, weight: UIFontWeightLight)
            } else {
                gramsInDisplay.font = UIFont.systemFontOfSize(60)
            }
            
        }
        
    }
    
    
    func setScaleTo (targetSetting: Float, animate: Bool) {
        
        let gramsDelta = currentGrams - targetSetting
        let xOffset = gramsDelta * oneGram
        currentGrams = targetSetting
        
        print("gramsDelta \(gramsDelta) xOffset \(xOffset)")
        
        if animate {
            UIView.animateWithDuration(1, animations: {
                self.gramScalGr.frame = CGRect(x: self.gramScalGr.frame.origin.x + CGFloat(xOffset), y: self.gramScalGr.frame.origin.y, width: self.gramScalGr.frame.width, height: self.gramScalGr.frame.height)
            })
        } else {
            self.gramScalGr.frame = CGRect(x: self.gramScalGr.frame.origin.x + CGFloat(xOffset), y: self.gramScalGr.frame.origin.y, width: self.gramScalGr.frame.width, height: self.gramScalGr.frame.height)
        }
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
                        gramsInDisplay.text = String(format: "%.01f", doseGrams)
                    } else if timerState == .Done {
                        yieldGrams = currentGrams - Float(offsetX) / oneGram
                        gramsOutDisplay.text = String(format: "%.01f", yieldGrams)
                    }
                }
            }
            
        case 3 :
            
//            doseGrams = round(doseGrams*10)/10
//            yieldGrams = round(yieldGrams*10)/10
//            
//            print("dose \(doseGrams) yiled \(yieldGrams)")
//            
//            if timerState == .Idle {
//                setScaleTo(doseGrams, animate: false)
//            } 
//                else if timerState == .Done {
//                setScaleTo(yieldGrams, animate: false)
//            }
            
            targetYieldMin.text = String(format: "%.01f", minYield)
            targetYieldMax.text = String(format: "%.01f", maxYield)
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
        targetYieldMin.text = String(format: "%.01f", minYield)
        targetYieldMax.text = String(format: "%.01f", maxYield)
        
        gramsOutDisplay.alpha = 0
        
        if #available(iOS 9.0, *) {
            timerDisplay.font = UIFont.monospacedDigitSystemFontOfSize(180, weight: UIFontWeightUltraLight)
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        setScaleTo(doseGrams, animate: false)
        doseGrams = 18
        gramsInDisplay.text = String(doseGrams)
        setScaleTo(doseGrams, animate: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finalizeShot" {
            let finalizeVC = segue.destinationViewController as! finalizeShotViewController
            finalizeVC.aShot = lastShot
            finalizeVC.shots = shots
            
        }
    }
}
