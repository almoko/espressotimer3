//
//  ShotsSummaryTableViewCell.swift
//  EspressoTimer
//
//  Created by Alex Motrenko on 9/18/15.
//  Copyright © 2015 Alex Motrenko. All rights reserved.
//

import UIKit

class ShotsSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var doseDisplay: UILabel!
    @IBOutlet weak var yieldDisplay: UILabel!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var ratioDisplay: UILabel!
    @IBOutlet weak var ratingDisplay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
