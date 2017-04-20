//
//  RideCardView.swift
//  CollegeHub
//
//  Created by Sumanpreet on 04/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class RideCardView: UIView {
}
//    @IBOutlet weak var heightOptionalStops: NSLayoutConstraint!
//    @IBOutlet weak var heightOfImageStackView: NSLayoutConstraint!
//    @IBOutlet weak var heightOfDesToDepLayout: NSLayoutConstraint!
//    @IBOutlet weak var lblPrice: UILabel!
//    @IBOutlet weak var viewDottedTop: UIView!
//    @IBOutlet weak var viewDottedBottom: UIView!
//    @IBOutlet weak var lblPickUp: UILabel!
//    @IBOutlet weak var lblDestination: UILabel!
//    @IBOutlet weak var lblRideOfferedBy: UILabel!
//    @IBOutlet weak var lblLeavingOn: UILabel!
//    @IBOutlet weak var lblOptionalStops: UILabel!
//    @IBOutlet weak var imgView: UIImageView!
//    
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//
//        self.layer.cornerRadius = 5
//        self.clipsToBounds = true
//
//        lblPrice.roundCorners([.topLeft, .bottomLeft], radius: 24)
//        viewDottedTop.addDashedLine()
//        viewDottedBottom.addDashedLine()
//        
//        imgView.layer.cornerRadius = imgView.frame.width/2
//        imgView.clipsToBounds = true
//        
//        if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height {
//            case 480:
//                print("iPhone Classic")
//                heightOfDesToDepLayout.constant = 130
//                heightOfImageStackView.constant = 90
//                heightOptionalStops.constant = 40
//            case 960:
//                print("iPhone 4 or 4S")
//                heightOfDesToDepLayout.constant = 130
//                heightOfImageStackView.constant = 90
//                heightOptionalStops.constant = 40
//            case 1136:
//                print("iPhone 5 or 5S or 5C")
//                heightOfDesToDepLayout.constant = 130
//                heightOfImageStackView.constant = 90
//                heightOptionalStops.constant = 40
//            case 1334:
//                print("iPhone 6 or 6S")
//            case 2208:
//                print("iPhone 6+ or 6S+")
//            default:
//                print("unknown")
//            }
//        }
//    }
//    
//    func updateLookingForRideUI(rideModel: RidePostViewModel){
//        print(rideModel.stop1 ?? "", rideModel.stop2 ?? "", rideModel.stop3 ?? "")
//        
//        lblPrice.text = "$ " + rideModel.price.unwrap()
//        lblPickUp.text = rideModel.departure
//        lblDestination.text = rideModel.destination
//        lblRideOfferedBy.text = rideModel.firstname.unwrap() + " " + rideModel.lastname.unwrap()
//        lblLeavingOn.text = rideModel.departure_time
//        let stops = rideModel.stop1.unwrap() + "," + rideModel.stop2.unwrap() + "," + rideModel.stop3.unwrap()
//        lblOptionalStops.text = stops
//        
//        if let imgUrl = rideModel.image100{
//            imgView.sd_setImage(with: URL(string: imgUrl))
//        }
//        
//    }
//    
//    func updateLookingForPassengerUI(rideModel: RidePostViewModel){
//        print(rideModel.stop1.unwrap(), rideModel.stop2.unwrap(), rideModel.stop3.unwrap()
//)
//        
//        lblPrice.text = "$ " + rideModel.price.unwrap()
//        lblPickUp.text = rideModel.departure
//        lblDestination.text = rideModel.destination
//        lblRideOfferedBy.text = rideModel.firstname.unwrap() + " " + rideModel.lastname.unwrap()
//        lblLeavingOn.text = rideModel.departure_time
//        let stops = rideModel.stop1.unwrap() + "," + rideModel.stop2.unwrap() + "," + rideModel.stop3.unwrap()
//
//        lblOptionalStops.text = stops
//        
//        if let imgUrl = rideModel.image100{
//            imgView.sd_setImage(with: URL(string: imgUrl))
//        }
//    }
//}
//
//extension UIView {
//    func addDashedLine(color: UIColor = UIColor.init(hexString: "#9E9E9E")!) {
//        layer.sublayers?.filter({ $0.name == "DashedTopLine" }).map({ $0.removeFromSuperlayer() })
//        backgroundColor = .clear
//        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.name = "DashedTopLine"
//        shapeLayer.bounds = bounds
//        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeColor = color.cgColor
//        shapeLayer.lineWidth = 2
//        shapeLayer.lineJoin = kCALineJoinRound
//        shapeLayer.lineDashPattern = [2,2,2,2]
//        
//        let path = CGMutablePath()
//        path.move(to: CGPoint.zero)
//        path.addLine(to: CGPoint(x: 0, y: frame.height))
//        shapeLayer.path = path
//        
//        layer.addSublayer(shapeLayer)
//    }
//}
//
//extension UIDevice {
//    var iPhone: Bool {
//        return UIDevice().userInterfaceIdiom == .phone
//    }
//    enum ScreenType: String {
//        case iPhone4
//        case iPhone5
//        case iPhone6
//        case iPhone6Plus
//        case unknown
//    }
//    var screenType: ScreenType {
//        guard iPhone else { return .unknown }
//        switch UIScreen.main.nativeBounds.height {
//        case 960:
//            return .iPhone4
//        case 1136:
//            return .iPhone5
//        case 1334:
//            return .iPhone6
//        case 2208:
//            return .iPhone6Plus
//        default:
//            return .unknown
//        }
//    }
//}
