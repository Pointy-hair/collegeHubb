//
//  ItemCardView.swift
//  CollegeHub
//
//  Created by Sumanpreet on 06/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import SDWebImage


class ItemCardView: UIView {
}
//    
//    @IBOutlet weak var lblEdition: UILabel!
//    @IBOutlet weak var lblOwner: UILabel!
//    @IBOutlet weak var lblEditionValue: UILabel!
//    @IBOutlet weak var lblCondition: UILabel!
//    @IBOutlet weak var lblConditionValue: UILabel!
//    @IBOutlet weak var imgViewleft: UIImageView!
//    @IBOutlet weak var imgViewCenter: UIImageView!
//    @IBOutlet weak var imgViewRight: UIImageView!
//    @IBOutlet weak var lblItemTitle: UILabel!
//    @IBOutlet weak var imgView: UIImageView!
//    @IBOutlet weak var lblOwnerName: UILabel!
//    @IBOutlet weak var lblPrice: UILabel!
//    @IBOutlet weak var lblItemDescription: UILabel!
//    @IBOutlet weak var lblItemSubTitle: UILabel!
//    @IBOutlet weak var stackViewBottom: UIStackView!
//    
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        
//        lblPrice.roundCorners([.topLeft, .bottomLeft], radius: 24)
//        self.layer.cornerRadius = 5
//        self.clipsToBounds = true
//        
//        imgView.layer.cornerRadius = imgView.frame.width/2
//        imgView.clipsToBounds = true
//    }
//    
//    func updateBooksUI(bookModel: BookPostViewModel){
//        stackViewBottom.isHidden = false
//        lblItemSubTitle?.isHidden = true
//        lblItemDescription?.isHidden = true
//
//        lblOwner?.text = "Owner"
//        lblEdition?.text = "Edition"
//        lblEditionValue?.text = bookModel.duration
//        lblCondition?.text = "Condition"
//        
//        //let condition = bookModel.condition_status?.toInt()
//        let con = bookModel.condition_status
////        switch condition!{
////        case 0: con = "new_look"
////        case 1: con = "good"
////        case 2: con = "acceptable"
////        case 3: con = "poor"
////        default: break
////        }
//        lblConditionValue?.text = con
//        
//        lblOwnerName?.text = bookModel.firstname.unwrap() + " " + bookModel.lastname.unwrap()
//
//        lblPrice?.text = "$ " + bookModel.price!
//        lblItemTitle?.text = bookModel.name
//
////        let count = bookModel.arrayImages?.count
////        if  count == 0 || count == nil{
////            imgViewRight.isHidden = true
////            imgViewCenter.isHidden = true
////            imgViewleft.isHidden = true
////        }else if  count == 1{
////            imgViewleft.sd_setImage(with: URL(string: (bookModel.arrayImages?[0].image100).unwrap()))
////        }else if count == 2{
////            imgViewleft.sd_setImage(with: URL(string: (bookModel.arrayImages?[0].image100).unwrap()))
////            imgViewCenter.sd_setImage(with: URL(string: (bookModel.arrayImages?[1].image100).unwrap()))
////        }else if count == 3{
////            imgViewleft.sd_setImage(with: URL(string: (bookModel.arrayImages?[0].image100).unwrap()))
////            imgViewCenter.sd_setImage(with: URL(string: (bookModel.arrayImages?[1].image100).unwrap()))
////            imgViewRight.sd_setImage(with: URL(string: (bookModel.arrayImages?[2].image100).unwrap()))
////        }else{
////            imgViewleft.sd_setImage(with: URL(string: (bookModel.arrayImages?[0].image100).unwrap()))
////            imgViewCenter.sd_setImage(with: URL(string: (bookModel.arrayImages?[1].image100).unwrap()))
////            imgViewRight.sd_setImage(with: URL(string: (bookModel.arrayImages?[2].image100).unwrap()))
////            let overlayView = UIView.init(frame: imgViewRight.frame)
////            overlayView.backgroundColor = UIColor.black
////            overlayView.alpha = 0.8
////            let lbl = UILabel.init(frame: imgViewRight.frame)
////            
////            let extraCount = count! - 3
////            lbl.text = extraCount.toString
////            overlayView.addSubview(lbl)
////            imgViewRight.addSubview(overlayView)
////            imgViewRight.bringSubview(toFront: overlayView)
////        }
////        
////        if let imgUrl = bookModel.image100{
////            imgView.sd_setImage(with: URL(string: imgUrl))
////        }
//    }
//    
//    func updateTicketsUI(ticketModel: TicketPostViewModel){
//        stackViewBottom.isHidden = false
//        lblItemSubTitle?.isHidden = true
//        lblItemDescription?.isHidden = true
//        
//        lblOwner?.text = "Sold By"
//        lblEdition?.text = "Venue"
//        lblEditionValue?.text = ticketModel.duration
//        lblCondition?.text = "Date/Time"
//        lblConditionValue?.text = ticketModel.date
//        lblOwnerName?.text = ticketModel.firstname.unwrap() + " " + ticketModel.lastname.unwrap()
//
//        lblPrice?.text = "$ " + ticketModel.price.unwrap()
//
//        lblItemTitle?.text = ticketModel.name
////    
////        let count = ticketModel.arrayImages?.count
////        if  count == 0 || count == nil{
////            imgViewRight.isHidden = true
////            imgViewCenter.isHidden = true
////            imgViewleft.isHidden = true
////        }else if  count == 1{
////            imgViewleft.sd_setImage(with: URL(string: (ticketModel.arrayImages?[0].image100).unwrap()))
////        }else if count == 2{
////            imgViewleft.sd_setImage(with: URL(string: (ticketModel.arrayImages?[0].image100).unwrap()))
////            imgViewCenter.sd_setImage(with: URL.init(string: (ticketModel.arrayImages?[1].image100).unwrap()))
////        }else if count == 3{
////            imgViewleft.sd_setImage(with: URL(string: (ticketModel.arrayImages?[0].image100).unwrap()))
////            imgViewCenter.sd_setImage(with: URL(string: (ticketModel.arrayImages?[1].image100).unwrap()))
////            imgViewRight.sd_setImage(with: URL(string: (ticketModel.arrayImages?[2].image100).unwrap()))
////        }else{
////            imgViewleft.sd_setImage(with: URL(string: (ticketModel.arrayImages?[0].image100).unwrap()))
////            imgViewCenter.sd_setImage(with: URL(string: (ticketModel.arrayImages?[1].image100).unwrap()))
////            imgViewRight.sd_setImage(with: URL(string: (ticketModel.arrayImages?[2].image100).unwrap()))
////            
////            let overlayView = UIView.init(frame: imgViewRight.frame)
////            overlayView.backgroundColor = UIColor.black
////            overlayView.alpha = 0.8
////            let lbl = UILabel.init(frame: imgViewRight.frame)
////
////            let extraCount = count! - 3
////            lbl.text = extraCount.toString
////            overlayView.addSubview(lbl)
////            imgViewRight.addSubview(overlayView)
////            imgViewRight.bringSubview(toFront: overlayView)
////        }
////        
////        if let imgUrl = ticketModel.image100{
////            imgView.sd_setImage(with: URL(string: imgUrl))
////        }
//    }
//    
//    func updateOthersUI(OtherModel: OtherPostViewModel){
//        stackViewBottom.isHidden = true
//        lblItemSubTitle?.isHidden = true
//        lblItemDescription?.isHidden = true
//        
//        lblOwner?.text = "Owner"
//        lblOwnerName?.text = OtherModel.firstname.unwrap() + " " + OtherModel.lastname.unwrap()
//
//        lblPrice?.text = "$ " + OtherModel.price.unwrap()
//
//        lblItemTitle?.text = OtherModel.name
////        lblItemDescription?.text = OtherModel.description
//        
//        let count = OtherModel.arrayImages?.count
//        if  count == 0 || count == nil{
//            imgViewRight.isHidden = true
//            imgViewCenter.isHidden = true
//            imgViewleft.isHidden = true
//        }else if  count == 1{
//            imgViewleft.sd_setImage(with: URL(string: (OtherModel.arrayImages?[0].image100).unwrap()))
//        }else if count == 2{
//            imgViewleft.sd_setImage(with: URL(string: (OtherModel.arrayImages?[0].image100).unwrap()))
//            imgViewCenter.sd_setImage(with: URL(string: (OtherModel.arrayImages?[1].image100).unwrap()))        }else if count == 3{
//            imgViewleft.sd_setImage(with: URL(string: (OtherModel.arrayImages?[0].image100).unwrap()))
//            imgViewCenter.sd_setImage(with: URL(string: (OtherModel.arrayImages?[1].image100).unwrap()))
//            imgViewRight.sd_setImage(with: URL(string: (OtherModel.arrayImages?[2].image100).unwrap()))
//        }else{
//            imgViewleft.sd_setImage(with: URL(string: (OtherModel.arrayImages?[0].image100).unwrap()))
//            imgViewCenter.sd_setImage(with: URL(string: (OtherModel.arrayImages?[1].image100).unwrap()))
//            imgViewRight.sd_setImage(with: URL(string: (OtherModel.arrayImages?[2].image100)!.unwrap()))            
//            let overlayView = UIView.init(frame: imgViewRight.frame)
//            overlayView.backgroundColor = UIColor.black
//            overlayView.alpha = 0.8
//            let lbl = UILabel.init(frame: imgViewRight.frame)
//            
//            let extraCount = count! - 3
//            lbl.text = extraCount.toString
//            overlayView.addSubview(lbl)
//            imgViewRight.addSubview(overlayView)
//            imgViewRight.bringSubview(toFront: overlayView)
//        }
//        
//        if let imgUrl = OtherModel.image100{
//            imgView.sd_setImage(with: URL(string: imgUrl))
//        }
//    }
//
//}
