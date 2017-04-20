//
//  MyProfileTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 15/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
