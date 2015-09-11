//
//  HistoryViewController.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 9/11/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var lastShot = espressoShot!()
    var allShots = [espressoShot]!()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allShots.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath)
        cell.detailTextLabel!.text = "\(allShots[allShots.count - indexPath.item - 1].time) sec"
        cell.textLabel!.text = "\(allShots[allShots.count - indexPath.item - 1].dose) → \(allShots[allShots.count - indexPath.item - 1].yield)"
        
        print(indexPath.item)
        
        return cell
    }
    
    @IBAction func dismissHistory(sender: UIButton) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {})
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(lastShot)
//        print(allShots)

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
