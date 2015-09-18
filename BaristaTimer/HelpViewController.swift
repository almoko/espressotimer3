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
        self.view.alpha = 0.8
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
