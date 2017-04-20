//
//  CardRideTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardRideTableViewCell: UITableViewCell {
    var currentData:AnyObject?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblDeparture: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
