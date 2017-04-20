//
//  HomeScreenServiceTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 06/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class HomeScreenServiceTableViewCell: UITableViewCell {    
    @IBOutlet var lblServiceTitle: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var lblServiceDuration: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
