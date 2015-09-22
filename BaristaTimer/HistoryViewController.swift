//
//  HistoryViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 9/11/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allShots = [espressoShot]!()
    
    @IBOutlet weak var historyTableView: UITableView!
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allShots.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! ShotsSummaryTableViewCell
        
//        cell.textLabel!.text = " →    \(allShots[allShots.count - indexPath.item - 1].rating)★"
        
        let ratio = round((allShots[allShots.count - indexPath.item - 1].yield / allShots[allShots.count - indexPath.item - 1].dose)*10)/10
        
        cell.doseDisplay.text = "\(allShots[allShots.count - indexPath.item - 1].dose)"
        cell.yieldDisplay.text = "\(allShots[allShots.count - indexPath.item - 1].yield)"
        cell.timeDisplay.text = "\(allShots[allShots.count - indexPath.item - 1].time) s"
        cell.ratioDisplay.text = "\(ratio)"
        cell.ratingDisplay.text = "\(allShots[allShots.count - indexPath.item - 1].rating)"
        
        return cell
    }
    
    @IBAction func dismissHistory(sender: UIButton) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func clearAll(sender: UIButton) {
        // Clear all records
        self.presentingViewController?.performSelector("clearAllRecords")
        allShots.removeAll()
        historyTableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
