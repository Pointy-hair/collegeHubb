//
//  PopularNearbyCarpoolCollectionViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PopularNearbyCarpoolCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblDayAndDate: UILabel!
    @IBOutlet var lblDestinationName: UILabel!
    
    let HomeStoryBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
    
    @IBAction func btnBookNowAction(_ sender: Any) {
         
    }
    
    
}
