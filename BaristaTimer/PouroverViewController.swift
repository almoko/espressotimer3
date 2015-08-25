//
//  PouroverViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 8/20/15.
//  Copyright (c) 2015 Alex Motrenko. All rights reserved.
//

import UIKit
import AVFoundation

var secondsTimer = NSTimer()

class PouroverViewController: UIViewController {
    
    let aSel : Selector = "increaseTimer"
    let aBloomSel : Selector = "increaseBloomTimer"
    var pourOver = PouroverTimer()
    var bloomTimer = BloomingTimer()
    
    @IBOutlet weak var displayTimer: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var bloomStartButton: UIButton!
    @IBOutlet weak var bloomTimerDisplay: UILabel!
    
    // Enabling the blooming timer
    
    @IBAction func bloomStart() {
        bloomTimer.isGo = true
        bloomStartButton.hidden = true
        bloomStartButton.enabled = false
        bloomTimerDisplay.hidden = false
    }
    
    // Initialize the Pour Over Timer
    
    @IBAction func startTimerButton() {
        
        if !pourOver.IsGo {
            UIApplication.sharedApplication().idleTimerDisabled = true
            secondsTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSel, userInfo: nil, repeats: true)
            startBtn.enabled = false
            startBtn.alpha = 0
            resetBtn.enabled = true
            resetBtn.alpha = 1
            pourOver.IsGo = true
            AudioServicesPlaySystemSound(1110)
            
            bloomStartButton.enabled = true
            bloomStartButton.hidden = false
        }
    }
    
    @IBAction func resetTimerButton() {
        secondsTimer.invalidate()
        pourOver.IsGo = false
        resetBtn.enabled = false
        resetBtn.alpha = 0
        startBtn.enabled = true
        startBtn.alpha = 1
        pourOver.currentTimer = 0
        displayTimer.text = "\(pourOver.currentMins):0\(pourOver.currentSecs)"
        displayTimer.textColor = UIColor.blackColor()
        AudioServicesPlaySystemSound(1111)
        UIApplication.sharedApplication().idleTimerDisabled = false
        
        bloomTimerDisplay.hidden = true
        bloomTimerDisplay.text = "00"
        bloomTimer.isGo = false
        bloomTimer.currentTimer = 0
        
        bloomStartButton.enabled = false
        bloomStartButton.hidden = true
        
    }
    
    @objc func increaseTimer() {
        
        if pourOver.currentTimer < pourOver.maxTimerMins*60+30 {
            
            pourOver.currentTimer++
            
            if pourOver.currentSecs < 10 {
                displayTimer.text = "\(pourOver.currentMins):0\(pourOver.currentSecs)"
            } else {
                displayTimer.text = "\(pourOver.currentMins):\(pourOver.currentSecs)"
            }
            
            for x in pourOver.warningSeconds {
                if pourOver.currentTimer == x {
                    AudioServicesPlaySystemSound(1111)
                    displayTimer.textColor = UIColor.redColor()
                    break
                } else {
                    displayTimer.textColor = UIColor.blackColor()
                }
            }
            
            
            // Blooming Timer Works:
            
            if bloomTimer.isGo && bloomTimer.currentTimer < bloomTimer.maxBloomSeconds {
                
                // Increase the blooming timer seconds by 1
                
                bloomTimer.currentTimer++
                
                // Update the blooming timer display accordingly
                
                if bloomTimer.currentTimer < 10 {
                    bloomTimerDisplay.text = "0\(bloomTimer.currentTimer)"
                } else {
                    bloomTimerDisplay.text = "\(bloomTimer.currentTimer)"
                }
                
                if bloomTimer.currentTimer == bloomTimer.maxBloomSeconds {
                    AudioServicesPlaySystemSound(1111)
//                    bloomTimerDisplay.textColor = UIColor.redColor()
                }
                
            } else if bloomTimer.isGo {
                bloomTimer.isGo = false
                bloomTimerDisplay.hidden = true
                bloomTimer.currentTimer = 0
//                bloomTimerDisplay.textColor = UIColor.blackColor()
            }
            
            
        } else {
            resetTimerButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBtn.alpha = 0
        resetBtn.enabled = false
        
        bloomStartButton.layer.cornerRadius = 10
        bloomStartButton.backgroundColor = UIColor.clearColor()
        bloomStartButton.layer.borderWidth = 1
        bloomStartButton.layer.borderColor = UIColor.grayColor().CGColor
        bloomStartButton.hidden = true
        bloomStartButton.enabled = false
        
        bloomTimerDisplay.hidden = true
//        bloomTimerDisplay.layer.cornerRadius = 35
//        bloomTimerDisplay.layer.borderWidth = 1
//        bloomTimerDisplay.backgroundColor = UIColor.clearColor()
//        bloomTimerDisplay.layer.borderColor = UIColor.grayColor().CGColor
        bloomTimerDisplay.textColor = UIColor.grayColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
