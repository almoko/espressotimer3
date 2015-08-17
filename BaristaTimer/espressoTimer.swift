//
//  espressoTimer.swift
//  BaristaTimer
//
//  Created by Alex Motrenko on 8/17/15.
//  Copyright (c) 2015 Alex Motrenko. All rights reserved.
//

import Foundation
import AVFoundation

class EspressoTimer {

    var targetTimerCount = 25
    let minTimerSetting = 20
    let maxTimerSetting = 40
    var currentTimerCount : Int
    var timerIsGo = false

    init () {
        currentTimerCount = targetTimerCount
    }

    func timerPlus() -> Int {
        AudioServicesPlaySystemSound(1057)
        if !timerIsGo && currentTimerCount < maxTimerSetting {
            targetTimerCount = ++currentTimerCount
        return targetTimerCount
        }
        else {
            return currentTimerCount
        }
        
    }
    func timerMinus() -> Int {
        AudioServicesPlaySystemSound(1057)
        if !timerIsGo && currentTimerCount > minTimerSetting {
            targetTimerCount = --currentTimerCount
            return targetTimerCount
        } else {
            return currentTimerCount
        }
    }
    
}

