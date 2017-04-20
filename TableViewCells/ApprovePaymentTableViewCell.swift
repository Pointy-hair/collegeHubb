//
//  ApprovePaymentTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 24/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class ApprovePaymentTableViewCell: UITableViewCell {
    
//MARK::- CELL OUTLETS
    @IBOutlet var btnApproveOutlet: UIButton!
    @IBOutlet var btnReportIssueOutlet: UIButton!
    @IBOutlet var imgProgileImage: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblTitleTripDetails: UILabel!
    @IBOutlet var lblDestinationTo: UILabel!
    @IBOutlet var lblDestinationFrom: UILabel!
    @IBOutlet var lblTo: UILabel!
    @IBOutlet var lblAmmountToBePaid: UILabel!
    
//MARK::- CELL LIFECYCLE
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
