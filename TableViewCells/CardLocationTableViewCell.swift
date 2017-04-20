//
//  CardLocationTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardLocationTableViewCell: UITableViewCell {
    var currentData:AnyObject?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationValue: UILabel!
    @IBOutlet weak var lblEnsure: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}

}
