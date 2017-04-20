//
//  CardSegmentTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardSegmentTableViewCell: UITableViewCell {
    var currentData:AnyObject?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblSegment1: UILabel!
    @IBOutlet weak var lblSegment1Value: UILabel!
    @IBOutlet weak var lblSegment2: UILabel!
    @IBOutlet weak var lblSegment2Value: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
