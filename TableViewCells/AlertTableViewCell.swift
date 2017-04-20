//
//  AlertTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 29/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class AlertTableViewCell: UITableViewCell {

//MARK::- CELL OUTLETS
    @IBOutlet var lblNotificationDate: UILabel!
    @IBOutlet var lblNotification: UILabel!
    @IBOutlet var imgUserProfileImage: UIImageView!

//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

           }

}
