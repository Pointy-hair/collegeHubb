//
//  PopularNearbyTicketsCollectionViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PopularNearbyTicketsCollectionViewCell: UICollectionViewCell {
 
    //MARK::- CELL VARIABLES
    let HomeStoryBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
    
    //MARK::- CELL OUTLETS
    @IBOutlet var lblTicketsTitle: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblTimeLeft: UILabel!
    @IBOutlet var lblDateDay: UILabel!
    
   //MARK::- BTN ACTIONS 
    @IBAction func btbBidNowAction(_ sender: Any) {
         
    }
    
}
