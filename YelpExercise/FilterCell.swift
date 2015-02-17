//
//  FilterCell.swift
//  YelpExercise
//
//  Created by Shajith on 2/11/15.
//  Copyright (c) 2015 zd. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var optionValueSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
