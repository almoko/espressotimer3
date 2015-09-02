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
    
    struct espressoShot {
        var dose : Float
        var yield : Float
        var time : Int
//        var timeStamp : Date()
        var blendName : String?
        
        init () {
            self.dose = 0
            self.yield = 0
            self.time = 0
        }
    }
    
    var origXgrams : CGFloat = 0
    
    var doseGrams : Float = 18 {
        didSet {
            minYield = doseGrams * 1.8
            maxYield = doseGrams * 2.5
        }
    }
    
    var minYield : Float = 0
    var maxYield : Float = 0
    
    var oneGram : Float = 0
    var currentGrams : Float = 20
    
    let aSel : Selector = "timerStep"
    var timer = NSTimer()
    var currentTimer = 0
    var timerIsGo = false
    var targetTimerSetting = 25
    
    var lastShot = espressoShot()
    
    @IBAction func setTimerTarget(sender: UIButton) {
        
        if !timerIsGo {
            
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
        
    }
    
    func stopTimer () {
        
        // Visuals and Mechanics
        
        timer.invalidate()
        timerIsGo = false
        
        buttonLess.enabled = true
        buttonMore.enabled = true
        buttonLess.alpha = 1
        buttonMore.alpha = 1
        
        // Record data
        
        lastShot.dose = Float(round(doseGrams*10)/10)
        lastShot.time = currentTimer
        lastShot.yield = 0
        
        print(lastShot)
        
    }
    
    @IBAction func tapOnTimer(sender: UITapGestureRecognizer) {
        
        if !timerIsGo {
            timerDisplay.text = "0"
            currentTimer = 0
            timerIsGo = true
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSel, userInfo: nil, repeats: true)
            
            buttonLess.enabled = false
            buttonMore.enabled = false
            buttonLess.alpha = 0.3
            buttonMore.alpha = 0.3
            
        } else {
            stopTimer()
        }
        
    }
    
    @IBAction func panGrams(sender: UIPanGestureRecognizer) {
       
        switch sender.state.rawValue {
        case 1 : origXgrams = gramScalGr.frame.origin.x
        case 2 :
            let offsetX = sender.translationInView(sender.view).x
            let newX = origXgrams + offsetX

            if newX <= 0 && gramScalGr.frame.maxX > gramsView.frame.maxX-offsetX {
                gramScalGr.frame = CGRect(x: newX, y: gramScalGr.frame.origin.y, width: gramScalGr.frame.width, height: gramScalGr.frame.height)
                
                doseGrams = currentGrams - Float(offsetX) / oneGram
                
                gramsInDisplay.text = String(format: "%.01f", doseGrams)
                
        }
        case 3 :
            targetYieldMin.text = String(format: "%.01f", minYield)
            targetYieldMax.text = String(format: "%.01f", maxYield)
            currentGrams = doseGrams
        default : break
            
    }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        oneGram = Float(gramScalGr.frame.width / 40)
        print("oneGram: \(oneGram)")
        doseGrams = 20
        gramsInDisplay.text = String(doseGrams)
        
        
    }

}
