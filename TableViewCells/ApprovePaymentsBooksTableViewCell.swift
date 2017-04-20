//
//  ApprovePaymentsBooksTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 29/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class ApprovePaymentsBooksTableViewCell: UITableViewCell {

//MARK::- CELL OUTLETS
    @IBOutlet var btnApproveOutlet: UIButton!
    @IBOutlet var btnReportIssueOutlet: UIButton!
    @IBOutlet var imgProgileImage: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblAmmountToBePaid: UILabel!
    @IBOutlet var lblProductTitle: UILabel!
    @IBOutlet var lblTitle: UILabel!
//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
//MARK::- CELL BTN ACTIONS    
    @IBAction func btnApproveAction(_ sender: Any) {
    }
    
    
    @IBAction func btnReportIssueAction(_ sender: Any) {
    }
    
    

}
