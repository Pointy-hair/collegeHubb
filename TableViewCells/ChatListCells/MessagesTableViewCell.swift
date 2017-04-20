//
//  MessagesTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 09/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

//MARK:- CELL OUTLETS
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblLastMsg: UILabel!
    @IBOutlet weak var lblUnreadCount: UILabel!

//MARK:- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
