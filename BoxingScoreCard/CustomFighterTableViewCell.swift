//
//  CustomFighterTableViewCell.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/23/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit

class CustomFighterTableViewCell: UITableViewCell {
    @IBOutlet var fighterImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var divisionLabel: UILabel!
    @IBOutlet var stanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.fighterImage.layer.borderWidth = 1.0
//        self.fighterImage.layer.borderColor = UIColor.blackColor().CGColor
//        self.fighterImage.layer.cornerRadius = 5.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
