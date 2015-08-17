//
//  ViewController.swift
//  BaristaTimer
//
//  Created by Alex Motrenko on 8/17/15.
//  Copyright (c) 2015 Alex Motrenko. All rights reserved.
//

import UIKit
import AVFoundation

var esTimer = EspressoTimer()

class ViewController: UIViewController {
    
    var secondsTimer = NSTimer()
    let aSelector : Selector = "decreaseTimer"
    
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func changeCurrentTimerCount(sender: UIButton) {
        switch sender.currentTitle! {
        case ">" : timerDisplay.text = String(esTimer.timerPlus())
        case "<" : timerDisplay.text = String(esTimer.timerMinus())
        default : break
        }
    }
    
    @IBAction func startResetButton(sender: UIButton) {

        switch sender.currentTitle! {
        case "Start" :
            rightButton.enabled = false
            rightButton.alpha = 0.3
            leftButton.enabled = false
            leftButton.alpha = 0.3
            startButton.enabled = false
            startButton.alpha = 0
            resetButton.enabled = true
            resetButton.alpha = 1
            startTimer()
        
        case "Reset" :
            resetTimer()
            
        default : break
        }

    }
    
    @objc func decreaseTimer() {
    
        esTimer.currentTimerCount--

        switch esTimer.currentTimerCount {
            
        case -1 : resetTimer()
            
        case 0 :
            timerDisplay.textColor = UIColor.redColor()
            AudioServicesPlaySystemSound(1116)
            
        case 1...3 :
            AudioServicesPlaySystemSound(1115)
            
        default :
            timerDisplay.text = String(esTimer.currentTimerCount)
        }
        
        timerDisplay.text = String(esTimer.currentTimerCount)
    }
    
    func startTimer() {
        esTimer.timerIsGo = true
        secondsTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
    }
    
    func resetTimer() {
        rightButton.enabled = true
        rightButton.alpha = 1
        leftButton.enabled = true
        leftButton.alpha = 1
        startButton.enabled = true
        startButton.alpha = 1
        resetButton.enabled = false
        resetButton.alpha = 0
        esTimer.timerIsGo = false
        secondsTimer.invalidate()
        esTimer.currentTimerCount = esTimer.targetTimerCount
        timerDisplay.textColor = UIColor.blackColor()
        timerDisplay.text = String(esTimer.targetTimerCount)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.alpha = 1
        startButton.enabled = true
        resetButton.alpha = 0
        resetButton.enabled = false
        timerDisplay.text = String(esTimer.targetTimerCount)
    }

}

