//
//  HelpViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 9/4/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBAction func dismissView() {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {} )
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.view.backgroundColor = UIColor.blackColor()
        
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
