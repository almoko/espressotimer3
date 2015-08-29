//
//  ExpertViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 8/29/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit

class ExpertViewController: UIViewController {
    
    @IBOutlet weak var gramsView: UIView!
    @IBOutlet weak var grindView: UIView!
    @IBOutlet weak var gramsScale: UILabel!
    @IBOutlet weak var grindScale: UILabel!
    
    var origXgrams : CGFloat = 0
    var origXgrind : CGFloat = 0
    
    @IBAction func panGrams(sender: UIPanGestureRecognizer) {
       
        switch sender.state.rawValue {
        case 1 : origXgrams = gramsScale.frame.origin.x
        case 2 :
            let offsetX = sender.translationInView(sender.view).x
            let newX = origXgrams + offsetX
            print(gramsScale.frame.maxX)
            print(gramsView.frame.maxX)
            if newX <= 30 && gramsScale.frame.maxX > gramsView.frame.maxX-offsetX {
                gramsScale.frame = CGRect(x: newX, y: gramsScale.frame.origin.y, width: gramsScale.frame.width, height: gramsScale.frame.height) }
        case 3 : break
        default : break
            
    }
    }
    
    @IBAction func panGrind(sender: UIPanGestureRecognizer) {
        
        switch sender.state.rawValue {
        case 1 : origXgrind = grindScale.frame.origin.x
        case 2 :
            let offsetX = sender.translationInView(sender.view).x
            let newX = origXgrind + offsetX
            if newX <= 0 {
                grindScale.frame = CGRect(x: newX, y: grindScale.frame.origin.y, width: grindScale.frame.width, height: grindScale.frame.height) }
            
        case 3 : break
        default : break
        
    }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
