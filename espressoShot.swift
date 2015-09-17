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
    var date = NSDate()
    var rating : Int
    
    struct PropertyKey {
        static let doseKey = "dose"
        static let yieldKey = "yield"
        static let timeKey = "time"
        static let dateKey = "date"
        static let ratingKey = "rating"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiverURL = DocumentsDirectory.URLByAppendingPathComponent("shots")
    
    init(dose: Float, yield: Float, time: Int, date: NSDate?, rating: Int) {
        
        self.dose = dose
        self.yield = yield
        self.time = time
        self.rating = rating
        
        if let savedDate = date {
            self.date = savedDate
        } else {
            self.date = NSDate()
        }
        
        super.init()
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(dose, forKey: PropertyKey.doseKey)
        aCoder.encodeObject(yield, forKey: PropertyKey.yieldKey)
        aCoder.encodeInteger(time, forKey: PropertyKey.timeKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let dose = aDecoder.decodeObjectForKey(PropertyKey.doseKey) as! Float
        let yield = aDecoder.decodeObjectForKey(PropertyKey.yieldKey) as! Float
        let time = aDecoder.decodeIntegerForKey(PropertyKey.timeKey)
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? NSDate
      
        self.init(dose: dose, yield: yield, time: time, date: date, rating: rating)
//        print(self.date.description)
    }
    
}