//
//  HomeScreenCarpoolTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 06/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class HomeScreenCarpoolTableViewCell: UITableViewCell {
    
    @IBOutlet var lblDeparture: UILabel!
    @IBOutlet var lblDayDate: UILabel!
    @IBOutlet var lblDestination: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
