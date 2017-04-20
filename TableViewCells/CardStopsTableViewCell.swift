//
//  CardStopsTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardStopsTableViewCell: UITableViewCell {
    var currentData:AnyObject?

    @IBOutlet weak var lblStopsValue1: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblStops: UILabel!
    @IBOutlet weak var lblStopsValue2: UILabel!
    @IBOutlet weak var lblStopsValue3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
