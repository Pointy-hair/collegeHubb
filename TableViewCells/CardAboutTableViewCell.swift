//
//  CardAboutTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardAboutTableViewCell: UITableViewCell {
    var currentData:AnyObject?

    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblAboutValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
