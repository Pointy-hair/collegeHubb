//
//  ServiceCardView.swift
//  CollegeHub
//
//  Created by Sumanpreet on 06/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class ServiceCardView: UIView {
}

//    @IBOutlet weak var lblTitle: UILabel!
//    @IBOutlet weak var lblSession: UILabel!
//    @IBOutlet weak var lblSessionLength: UILabel!
//    @IBOutlet weak var lblServiceOfferedBy: UILabel!
//    @IBOutlet weak var lblAvailability: UILabel!
//    @IBOutlet weak var imgView: UIImageView!
//    @IBOutlet weak var lblPrice: UILabel!
//    
//
//    override func draw(_ rect: CGRect) {
//        self.layer.cornerRadius = 5
//        self.clipsToBounds = true
//        
//        lblPrice.roundCorners([.topLeft, .bottomLeft], radius: 24)
//        imgView.layer.cornerRadius = imgView.frame.width/2
//        imgView.clipsToBounds = true
//    }
//    
//    func updateLookingForServiceUI(serviceModel: ServicePostViewModel){
//        lblTitle?.text = serviceModel.name
//        lblSession?.text = "Session Length"
//        lblSessionLength?.text = serviceModel.duration
//        lblServiceOfferedBy?.text = serviceModel.firstname.unwrap() + " " + serviceModel.lastname.unwrap()
//        lblPrice?.text = "$ " + serviceModel.price.unwrap()
//        lblAvailability?.text = "By Appointment"
//        
//        if let imgUrl = serviceModel.image100{
//            imgView.sd_setImage(with: URL(string: imgUrl))
//        }
//        
//    }
//    
//    func updateOfferAServiceUI(serviceModel: ServicePostViewModel){
//        lblTitle?.text = serviceModel.name
//        lblSession?.text = "Session Length"
//        lblSessionLength?.text = serviceModel.duration
//        lblServiceOfferedBy?.text = serviceModel.firstname.unwrap() + " " + serviceModel.lastname.unwrap()
//        lblPrice?.text = "$ " + serviceModel.price.unwrap()
//        lblAvailability?.text = "By Appointment"
//        
//        if let imgUrl = serviceModel.image100{
//            imgView.sd_setImage(with: URL(string: imgUrl))
//        }
//        
//    }
//}
