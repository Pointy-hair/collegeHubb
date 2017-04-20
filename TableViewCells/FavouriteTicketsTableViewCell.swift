//
//  FavouriteTicketsTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 12/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class FavouriteTicketsTableViewCell: UITableViewCell {

    //MARK::- CELL OUTLETS
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!
    
    //MARK::- CELL LIFE CUCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
