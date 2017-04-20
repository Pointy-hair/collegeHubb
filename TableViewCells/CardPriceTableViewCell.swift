//
//  CardPriceTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardPriceTableViewCell: UITableViewCell {
    var currentData:AnyObject?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPriceValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblPriceValue.layer.cornerRadius = 24
        lblPriceValue.layer.borderWidth = 2
        lblPriceValue.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
