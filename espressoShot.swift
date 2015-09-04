//
//  espressoShot.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 9/3/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import Foundation

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