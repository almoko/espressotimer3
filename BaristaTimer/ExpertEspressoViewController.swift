//
//  ExpertEspressoViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 8/27/15.
//  Copyright (c) 2015 Alex Motrenko. All rights reserved.
//

import UIKit

class ExpertEspressoViewController: UIViewController {
    
    // MARK : My Timer class definition
    
    class EspressoShot {
        var blendName = "Espresso Blend"
        var groundWeight : Float = 0
        var grindSetting : Float = 0
        var basketSize : Int = 2
        var basketSizeTemp : Float = 2
        var outputGrams : Float = 0
        var tasteEval : Int = 1
        var tasteEvalTemp : Float = 0
        var shotTime : Int?
    }
    
    enum extPhases {
        case Prep
        case Go
        case Record
        case Done
    }
    
    var currentPhase : extPhases = .Prep
    
    var timer = NSTimer()
    let aSel : Selector = "timerStep"
    var timerIsGo = false
    
    
    var currentTimerCount = 1
    var currenShot = EspressoShot()

    // MARK : Number Displays
    
    @IBOutlet weak var blendNameDisplay: UILabel!
    @IBOutlet weak var groundCoffeeWeightDisplay: UILabel!
    @IBOutlet weak var grinderSettingDisplay: UILabel!
    @IBOutlet weak var outputGramsDisplay: UILabel!
    @IBOutlet weak var qualityEstimationDisplay: UILabel!
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var timerExplanationText: UILabel!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var discardBtn: UIButton!
    
    
    // MARK : Swiping arrows handles
    
    @IBOutlet weak var gramsAr: UILabel!
    @IBOutlet weak var grindAr: UILabel!
    @IBOutlet weak var outputAr: UILabel!
    @IBOutlet weak var tasteAr: UILabel!
    
    // MARK : Button Actions
    
    func checkPhase (phase: extPhases) {
        switch phase {
        case .Prep :
            timerExplanationText.alpha = 1
            outputGramsDisplay.textColor = UIColor.lightGrayColor()
            qualityEstimationDisplay.textColor = UIColor.lightGrayColor()
            timerDisplay.textColor = UIColor.lightGrayColor()
            gramsAr.alpha = 0.8
            grindAr.alpha = 0.8
            outputAr.alpha = 0.1
            tasteAr.alpha = 0.1
            saveBtn.alpha = 0.2
            discardBtn.alpha = 0.2
            saveBtn.enabled = false
            discardBtn.enabled = false
            groundCoffeeWeightDisplay.textColor = UIColor.blackColor()
            grinderSettingDisplay.textColor = UIColor.blackColor()
            timerExplanationText.text = "START"
        case .Go :
            timerDisplay.textColor = UIColor.blackColor()
            groundCoffeeWeightDisplay.textColor = UIColor.lightGrayColor()
            grinderSettingDisplay.textColor = UIColor.lightGrayColor()
            gramsAr.alpha = 0.1
            grindAr.alpha = 0.1
        case .Record :
            timerExplanationText.alpha = 0.2
            outputGramsDisplay.textColor = UIColor.blackColor()
            qualityEstimationDisplay.textColor = UIColor.blackColor()
            timerDisplay.textColor = UIColor.lightGrayColor()
            outputAr.alpha = 0.8
            tasteAr.alpha = 0.8
            saveBtn.alpha = 1
            discardBtn.alpha = 1
            saveBtn.enabled = true
            discardBtn.enabled = true
        case .Done : break
        }
    }
    
    @IBAction func tapOnTimerDisplay(sender: UITapGestureRecognizer) {
        
            if currentPhase == .Prep {
                currentPhase = .Go
                currentTimerCount = 0
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSel, userInfo: nil, repeats: true)
                timerDisplay.text = "00"
                timerExplanationText.text = "STOP"
            } else if currentPhase == .Go {
                currentPhase = .Record
                timer.invalidate()
                currenShot.shotTime = currentTimerCount
                timerExplanationText.text = "TASTE"
            }
        
        checkPhase(currentPhase)
        
    }
    
    @IBAction func panGroundCoffeeWeight(sender: UIPanGestureRecognizer) {
        
        if currentPhase == .Prep || currentPhase == .Go {
        
        let vel = Float(sender.velocityInView(self.view).y)
        switch vel {
        case 0 ... 100 : if currenShot.groundWeight >= 0.02 { currenShot.groundWeight -= 0.015 }
        case -100 ..< 0 : if currenShot.groundWeight < 39.8 { currenShot.groundWeight += 0.015 }
        case 101 ..< 1000 : if currenShot.groundWeight >= 1 { currenShot.groundWeight -= 0.3 }
        case -1000 ... -101 : if currenShot.groundWeight <= 39 { currenShot.groundWeight += 0.3 }
        default : break
        }
        groundCoffeeWeightDisplay.text = String(format : "%.1f", currenShot.groundWeight)
        groundCoffeeWeightDisplay.textColor = UIColor.blackColor()
            
        }
    }
    
    @IBAction func panGrindSetting(sender: UIPanGestureRecognizer) {
        
        if currentPhase == .Prep || currentPhase == .Go {
        
        let vel = Float(sender.velocityInView(self.view).y)
        switch vel {
        case 0 ... 100 : if currenShot.grindSetting >= 0.02 { currenShot.grindSetting -= 0.015 }
        case -100 ..< 0 : if currenShot.grindSetting < 29.8 { currenShot.grindSetting += 0.015 }
        case 101 ..< 1000 : if currenShot.grindSetting >= 1 { currenShot.grindSetting -= 0.3 }
        case -1000 ... -101 : if currenShot.grindSetting <= 29 { currenShot.grindSetting += 0.3 }
        default : break
        }
        grinderSettingDisplay.text = String(format : "%.1f", currenShot.grindSetting)
            
        }
    }
    
    @IBAction func panGramsOutput(sender: UIPanGestureRecognizer) {
        
        if currentPhase == .Record {
        
        let vel = Float(sender.velocityInView(self.view).y)
        switch vel {
        case 0 ... 100 : if currenShot.outputGrams >= 0.02 { currenShot.outputGrams -= 0.015 }
        case -100 ..< 0 : if currenShot.outputGrams < 39.8 { currenShot.outputGrams += 0.015 }
        case 101 ..< 1000 : if currenShot.outputGrams >= 1 { currenShot.outputGrams -= 0.3 }
        case -1000 ... -101 : if currenShot.outputGrams <= 39 { currenShot.outputGrams += 0.3 }
        default : break
        }
        
        outputGramsDisplay.text = String(format : "%.1f", currenShot.outputGrams)
            
        }
        
    }
    
    @IBAction func panTasteEval(sender: UIPanGestureRecognizer) {
        
        if currentPhase == .Record {
        
        let vel = Float(sender.velocityInView(self.view).y)
        
        switch vel {
        case 0 ... 100 : if currenShot.tasteEval > 1 {
            currenShot.tasteEvalTemp -= 0.015
            currenShot.tasteEval = Int(currenShot.tasteEvalTemp)
            }
        case -100 ..< 0 : if currenShot.tasteEval < 10 {
            currenShot.tasteEvalTemp += 0.015
            currenShot.tasteEval = Int(currenShot.tasteEvalTemp)
            }
        case 101 ..< 1000 : if currenShot.tasteEval > 1 {
            currenShot.tasteEvalTemp -= 0.3
            currenShot.tasteEval = Int(currenShot.tasteEvalTemp)
            }
        case -1000 ... -101 : if currenShot.tasteEval < 10 {
            currenShot.tasteEvalTemp += 0.3
            currenShot.tasteEval = Int(currenShot.tasteEvalTemp)
            }
        default : break
        }
        qualityEstimationDisplay.text = String(currenShot.tasteEval)
            
        }
    }
    
    func timerStep() {
        
        if currentTimerCount < 35 {
            if currentTimerCount < 9 {
                timerDisplay.text = "0\(++currentTimerCount)"
            } else {
                timerDisplay.text = String(++currentTimerCount)
            }
        } else {
            timerIsGo = false
            currenShot.shotTime = currentTimerCount
            timer.invalidate()
            timerExplanationText.text = "extraction finished"
        }
    }
    
    @IBAction func saveCurrentShot() {
        
        currentPhase = .Prep
        checkPhase(currentPhase)
        currentTimerCount = 0
        timerDisplay.text = "00"
    }
    
    @IBAction func discardCurrentShot() {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blendNameDisplay.text = currenShot.blendName
        groundCoffeeWeightDisplay.text = String(format : "%.1f", currenShot.groundWeight)
        grinderSettingDisplay.text = String(format : "%.1f", currenShot.grindSetting)
        outputGramsDisplay.text = String(format : "%.1f", currenShot.outputGrams)
        qualityEstimationDisplay.text = String(currenShot.tasteEval)
        timerDisplay.text = "00"
        
        checkPhase(currentPhase)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
