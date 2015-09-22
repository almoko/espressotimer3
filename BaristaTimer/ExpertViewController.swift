 //
//  ExpertViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 8/29/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit
import AVFoundation

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
    @IBOutlet weak var leftGrayArrow: UILabel!
    @IBOutlet weak var rightGrayArrow: UILabel!
    @IBOutlet weak var finalizeShotCard: UIView!
    @IBOutlet weak var finalDozeDisplay: UILabel!
    @IBOutlet weak var finalYieldDisplay: UILabel!
    
    //Rating stars
    
    @IBOutlet weak var star1: UILabel!
    @IBOutlet weak var star2: UILabel!
    @IBOutlet weak var star3: UILabel!
    @IBOutlet weak var star4: UILabel!
    @IBOutlet weak var star5: UILabel!
    
    enum timerStates {
        case Idle
        case Active
        case Done
    }
    
    var timerState : timerStates = .Idle
    var shotRating = 1
    
//    let myBlueColor = UIColor.init(red: 39/255, green: 179/255, blue: 225/255, alpha: 0.8)
    
    let myBrownColor = UIColor.init(red: 153/255, green: 102/255, blue: 51/255, alpha: 1)
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
    
    var timer = NSTimer()
    var noSleepTimer = NSTimer()
    var currentTimer = 0
    var targetTimerSetting = 25
    
//    var lastShot = espressoShot(dose: 0, yield: 0, time: 0)
    var shots = [espressoShot]()
    
    // MARK: Functions
    
    func timerStep() {
        
        if currentTimer < 60 {
            currentTimer++
        } else {
            stopTimer()
        }
        
        timerDisplay.text = String(currentTimer)
//        if currentTimer == targetTimerSetting {
//            timerDisplay.textColor = UIColor.redColor()
//            //play final sound here
//        } else {
//             timerDisplay.textColor = myBrownColor
//        }
//        if currentTimer >= targetTimerSetting-3 && currentTimer < targetTimerSetting {
//            // play warning sounds here
//        }
    }
    
    func stopTimer () {
     
        timer.invalidate()
        timerState = .Done
        
        gramsDisplay.textColor = myBrownColor
        gramsDisplay.text = String(format: "%.01f", self.yieldGrams)
    }
    
    @IBAction func actionBtnTap(sender: UIButton) {
        tapOnTimer(nil)
    }
    
    @IBAction func tapOnTimer(sender: UITapGestureRecognizer?) {
        
        if timerState == .Idle {
            
            circle1.text = "○"
            circle2.text = "◉"
            
            // 1057 nice tink
            // 1110 tudu
            // 1113 begin recording - suttle
            // 1115-1116 my start and finish sounds
            
            AudioServicesPlaySystemSound(1057)
            
            infoButton.enabled = false
            historyButton.enabled = false
            
            timerState = .Active
            timerDisplay.text = "0"
            currentTimer = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerStep", userInfo: nil, repeats: true)
            
            hintText.text = "Your espresso should weigh \n" + String(format: "%.01f", minYield) + " to " + String(format: "%.01f", maxYield) + " grams"
            
            yieldGrams = (maxYield + minYield) / 2
            
            finalDozeDisplay.text = String(format: "%.01f", doseGrams)
            finalYieldDisplay.text = String(format: "%.01f", yieldGrams)

            actionButton.setTitle("STOP", forState: .Normal)
            
            UIView.animateWithDuration(1, animations: {
                self.gramsDisplay.textColor = UIColor.lightGrayColor()
                self.leftGrayArrow.alpha = 0
                self.rightGrayArrow.alpha = 0
            })
            
        } else if timerState == .Active {
            
            circle2.text = "○"
            circle3.text = "◉"
            
            hintText.text = "ESPRESSO WEIGHT"
            setScaleTo(yieldGrams, animate: true)
            stopTimer()
            
            actionButton.setTitle("START", forState: .Normal)
            finalizeShotCard.hidden = false
            
            leftGrayArrow.alpha = 1
            rightGrayArrow.alpha = 1
            
            AudioServicesPlaySystemSound(1057)
        }
    }
    
    @IBAction func saveAndNew(sender: UIButton) {
        
        if timerState == .Done {
            circle3.text = "○"
            circle1.text = "◉"
            
            timerState = .Idle
            
            let nowDate = NSDate()
            let l = espressoShot(dose: Float(round(doseGrams*10)/10), yield: Float(round(yieldGrams*10)/10), time: currentTimer, date: nowDate, rating: shotRating)
            
            // Set scale to last shot's grams
            
            hintText.text = "COFFEE WEIGHT"
            setScaleTo(l.dose, animate: true)
            timerDisplay.text = "0"
            infoButton.enabled = true
            historyButton.enabled = true
        
            switch sender.currentTitle! {
            case "✔︎", "SAVE" :
                shots.append(l)
                saveShots()
            case "✖︎", "DISCARD" :
                break
            default :
                break
            }
            finalizeShotCard.hidden = true
        }
        
    }
    
    @IBAction func setRating(sender: UITapGestureRecognizer) {
        switch sender.view! {
        case star1 :
            star1.text = "★"
            star2.text = "☆"
            star3.text = "☆"
            star4.text = "☆"
            star5.text = "☆"
            shotRating = 1
        case star2 :
            star1.text = "★"
            star2.text = "★"
            star3.text = "☆"
            star4.text = "☆"
            star5.text = "☆"
            shotRating = 2
        case star3 :
            star1.text = "★"
            star2.text = "★"
            star3.text = "★"
            star4.text = "☆"
            star5.text = "☆"
            shotRating = 3
        case star4 :
            star1.text = "★"
            star2.text = "★"
            star3.text = "★"
            star4.text = "★"
            star5.text = "☆"
            shotRating = 4
        case star5 :
            star1.text = "★"
            star2.text = "★"
            star3.text = "★"
            star4.text = "★"
            star5.text = "★"
            shotRating = 5
        default : break
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
            UIView.animateWithDuration(0.1, animations: {
                self.leftGrayArrow.alpha = 0
                self.rightGrayArrow.alpha = 0
            })
            if timerState != .Active {
                AudioServicesPlaySystemSound(1306)
            }
            
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
                finalYieldDisplay.text = String(format: "%.01f", self.yieldGrams)
            }
            
            UIView.animateWithDuration(0.5, animations: {
                self.leftGrayArrow.alpha = 0.8
                self.rightGrayArrow.alpha = 0.8
            })
            
        default : break
    }
    }
    
    func clearAllRecords() {
        shots.removeAll()
        saveShots()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        oneGram = Float(gramScalGr.frame.width / 100)
        timerDisplay.text = "0"
        doseGrams = 10
        
        noSleepTimer = NSTimer.scheduledTimerWithTimeInterval(60*3, target: self, selector: "removeNoSleepTimer", userInfo: nil, repeats: false)
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        if let savedShots = loadShots() {
            shots = savedShots
        }
    }
    
    func removeNoSleepTimer() {
        noSleepTimer.invalidate()
        UIApplication.sharedApplication().idleTimerDisabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        setScaleTo(doseGrams, animate: false)
        doseGrams = 18
        setScaleTo(doseGrams, animate: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showHistoryVC" {
            let historyVC = segue.destinationViewController as! HistoryViewController
            historyVC.allShots = shots
        }
    }
    
    // MARK: NSCoding
    
    func saveShots() {
        _ = NSKeyedArchiver.archiveRootObject(shots, toFile: espressoShot.ArchiverURL.path!)
    }
        
    func loadShots() -> [espressoShot]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(espressoShot.ArchiverURL.path!) as? [espressoShot]
    }
}
