//
//  ViewController.swift
//  BaristaTimer
//
//  Created by Alex Motrenko on 8/17/15.
//  Copyright (c) 2015 Alex Motrenko. All rights reserved.
//

import UIKit

var esTimer = EspressoTimer()

class ViewController: UIViewController {
    
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
            leftButton.enabled = false
            startButton.enabled = false
            startButton.alpha = 0
            resetButton.enabled = true
            resetButton.alpha = 1
            esTimer.startTimer()
        
        case "Reset" :
            rightButton.enabled = true
            leftButton.enabled = true
            startButton.enabled = true
            startButton.alpha = 1
            resetButton.enabled = false
            resetButton.alpha = 0
            esTimer.resetTimer()
            
        default : break
        }

    }
    
    func updateTimerDisplay() {
        print(esTimer.currentTimerCount)
        print(timerDisplay)
//        timerDisplay.text = String(esTimer.currentTimerCount)
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

