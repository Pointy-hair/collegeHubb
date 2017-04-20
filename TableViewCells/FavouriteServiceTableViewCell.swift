//
//  FavouriteServiceTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 29/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class FavouriteServiceTableViewCell: UITableViewCell {

//MARK::- CELL OUTLETS
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!
    
    @IBOutlet var lblServiceName: UILabel!
    @IBOutlet var lblSessionLength: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblPrice: UILabel!
//MARK::- CELL LIFE CUCLE
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            }

}
