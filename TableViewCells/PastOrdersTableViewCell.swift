//
//  PastOrdersTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 24/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PastOrdersTableViewCell: UITableViewCell {
    
//MARK::- CELL OUTLETS
    @IBOutlet var imgProgileImage: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblTitleTripDetails: UILabel!
    @IBOutlet var lblDestinationTo: UILabel!
    @IBOutlet var lblDestinationFrom: UILabel!
    @IBOutlet var lblTo: UILabel!
    @IBOutlet var lblTitlePayed: UILabel!
    @IBOutlet var lblTitleDate: UILabel!
    @IBOutlet var lblPayed: UILabel!
    @IBOutlet var lblDate: UILabel!

//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
