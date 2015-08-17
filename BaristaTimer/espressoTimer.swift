//
//  espressoTimer.swift
//  BaristaTimer
//
//  Created by Alex Motrenko on 8/17/15.
//  Copyright (c) 2015 Alex Motrenko. All rights reserved.
//

import Foundation
import AVFoundation

var a = ViewController()

class EspressoTimer {

    var targetTimerCount = 25
    let minTimerSetting = 20
    let maxTimerSetting = 40
    var currentTimerCount : Int {
        didSet {
//            print("changed value of the timer")
        }
    }
    var timerIsPaused = false
    var timerIsGo = false
    var secondsTimer = NSTimer()
    let aSelector : Selector = "decreaseTimer"

    init () {
        currentTimerCount = targetTimerCount
    }

    func timerPlus() -> Int {
        if !timerIsGo && currentTimerCount < maxTimerSetting {
            targetTimerCount = ++currentTimerCount
        return targetTimerCount
        }
        else {
            return currentTimerCount
        }
        
    }
    func timerMinus() -> Int {
        if !timerIsGo && currentTimerCount > minTimerSetting {
            targetTimerCount = --currentTimerCount
            return targetTimerCount
        } else {
            return currentTimerCount
        }
    }
    
    func startTimer() {
        timerIsGo = true
        timerIsPaused = false
        secondsTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
    }

    func resetTimer() {
        timerIsGo = false
        secondsTimer.invalidate()
        currentTimerCount = targetTimerCount
    }
    
    @objc func decreaseTimer() {
        ViewController.updateTimerDisplay(a)
            }
    
}

