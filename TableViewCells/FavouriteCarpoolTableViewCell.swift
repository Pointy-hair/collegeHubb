//
//  FavouriteCarpoolTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 29/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class FavouriteCarpoolTableViewCell: UITableViewCell {
    
//MARK::- CELL OUTLETS
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblDestination: UILabel!
    @IBOutlet var lblDeparture: UILabel!
    
//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
