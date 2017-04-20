//
//  PostAdRightTextTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 21/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PostAdRightTextTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblRightText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
