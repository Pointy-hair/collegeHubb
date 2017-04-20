//
//  PastOrderItemOrServiceCellTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 29/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PastOrderItemOrServiceCellTableViewCell: UITableViewCell {

//MARK::- CELL OUTLETS
    @IBOutlet var lblTitleItemOrservice: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTitleDate: UILabel!
    @IBOutlet var lblAmountPayedOrEarned: UILabel!
    @IBOutlet var lblTitlePayedOrEarned: UILabel!
    @IBOutlet var lblItemOrServiceProvided: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!

//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
