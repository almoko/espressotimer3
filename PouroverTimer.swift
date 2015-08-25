//
//  PouroverTimer.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 8/20/15.
//  Copyright (c) 2015 Alex Motrenko. All rights reserved.
//

import Foundation

class PouroverTimer {
    
    var maxTimerMins = 4
    var warningSeconds = [60, 120, 180, 240]
    var currentTimer = 0 {
        didSet {
            currentMins = Int(currentTimer / 60)
            currentSecs = Int(currentTimer - currentMins*60)
        }
    }
    var IsGo = false
    var currentMins = 0
    var currentSecs = 0
}

class BloomingTimer {
    var maxBloomSeconds = 30
    var currentTimer = 0
    var isGo = false
}