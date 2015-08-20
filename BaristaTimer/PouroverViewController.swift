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
    var pourOver = PouroverTimer()
    
    @IBOutlet weak var displayTimer: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
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
    }
    
    @objc func increaseTimer() {
        
        if pourOver.currentTimer < pourOver.maxTimerMins*60 {
            
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
            
        } else {
            resetTimerButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBtn.alpha = 0
        resetBtn.enabled = false

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
