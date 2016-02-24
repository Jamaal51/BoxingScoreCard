//
//  CustomRoundsTableViewCell.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/23/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit

class CustomRoundsTableViewCell: UITableViewCell {
    @IBOutlet var roundNumberLabel: UILabel!
    @IBOutlet var blueScoreLabel: UILabel!
    @IBOutlet var redScoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
