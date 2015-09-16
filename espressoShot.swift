//
//  espressoShot.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 9/3/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import Foundation

class espressoShot: NSObject, NSCoding {
    
    // MARK: Properties
    
    var dose : Float
    var yield : Float
    var time : Int
    
    struct PropertyKey {
        static let doseKey = "dose"
        static let yieldKey = "yield"
        static let timeKey = "time"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiverURL = DocumentsDirectory.URLByAppendingPathComponent("shots")
    
    init(dose: Float, yield: Float, time: Int) {
        
        self.dose = dose
        self.yield = yield
        self.time = time
        
        super.init()
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(dose, forKey: PropertyKey.doseKey)
        aCoder.encodeObject(yield, forKey: PropertyKey.yieldKey)
        aCoder.encodeInteger(time, forKey: PropertyKey.timeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let dose = aDecoder.decodeObjectForKey(PropertyKey.doseKey) as! Float
        let yield = aDecoder.decodeObjectForKey(PropertyKey.yieldKey) as! Float
        let time = aDecoder.decodeIntegerForKey(PropertyKey.timeKey)
      
        self.init(dose: dose, yield: yield, time: time)
    }
    
}