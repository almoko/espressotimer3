//
//  finalizeShotViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 9/3/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit

class finalizeShotViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var shotDoseDisplay: UILabel!

    var aShot : espressoShot!
    var shots : [espressoShot]!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shots.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("aShotCell", forIndexPath: indexPath) as UITableViewCell
        
        if !shots.isEmpty {
            cell.textLabel?.text = "\(shots[shots.count - indexPath.row - 1].dose) → \(shots[shots.count - indexPath.row - 1].yield)"
            cell.detailTextLabel?.text = "\(shots[shots.count - indexPath.row - 1].time) sec"
        }
            return cell
    }
    
    @IBAction func dismissVC(sender: UIButton) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shotDoseDisplay.text = String(aShot.dose)
    }
}