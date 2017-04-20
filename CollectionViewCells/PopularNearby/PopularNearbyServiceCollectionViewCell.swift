//
//  PopularNearbyServiceCollectionViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PopularNearbyServiceCollectionViewCell: UICollectionViewCell {
  
    //MARK::- CELL OUTLETS    
    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var lblServiceName: UILabel!
    @IBOutlet var lblDurationOfService: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    let HomeStoryBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
    
    
    @IBAction func btnBookNowAction(_ sender: Any) {
       
    }
}
