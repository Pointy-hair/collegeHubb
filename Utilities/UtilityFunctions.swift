//
//  UtilityFunctions.swift
//  Clikat Supplier
//
//  Created by Night Reaper on 08/04/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import Foundation
//import TYAlertController
//import RMDateSelectionViewController
import EZSwiftExtensions
import SystemConfiguration
import NVActivityIndicatorView

class UtilityFunctions {
    
    class func startLoader(){
//        GiFHUD.setGif("loader.gif")
//        GiFHUD.dismissOnTap()
//        GiFHUD.showWithOverlay()
    }
    
    class func stopLoader(){
//        GiFHUD.dismiss()
    }
    
    class func shareContentOnSocialMedia (withViewController controller : UIViewController?,message : String?){
        let  activityController = UIActivityViewController(activityItems: [message ?? ""], applicationActivities: [])
        controller?.present(activityController, animated: true, completion: nil)
    }
    
    class func sharedAppDelegateInstance() -> AppDelegate  {
        
        let delegate = UIApplication.shared.delegate
        return delegate as! AppDelegate
    }
    
    class func showAlert(message : String?, controller: UIViewController){

        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.view.tintColor = appColor
        alert.view.backgroundColor = UIColor.white

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
            
        }))
        
        controller.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    class func showAlert(title : String?,message : String?,success: () -> (),cancel: () -> ()){
//        let alert = TYAlertView(title: title,message: message)
//        alert.buttonDefaultBgColor = Colors.MainColor.color()
//        alert.addAction(TYAlertAction(title: "Cancel", style: TYAlertActionStyle.Default, handler: { (action) in
//            alert.hideView()
//            cancel()
//        }))
//        alert.addAction(TYAlertAction(title: "OK", style: TYAlertActionStyle.Default, handler: { (action) in
//            alert.hideView()
//            success()
//        }))
//
//        alert.showInWindow()
    }
    
    /*
    static func addParallaxToView(view : UIView){
        let leftRightMin = -20.0
        let leftRightMax = 20.0
        
        let upDownMin = -20.0
        let upDownMax = 20.0
        
        
        let leftRight = UIInterpolatingMotionEffect(keyPath: "center.x",type: .TiltAlongHorizontalAxis)
        leftRight.minimumRelativeValue = leftRightMin
        leftRight.maximumRelativeValue = leftRightMax
        let upDown = UIInterpolatingMotionEffect(keyPath: "center.y",type: .TiltAlongVerticalAxis)
        upDown.minimumRelativeValue = upDownMin
        upDown.maximumRelativeValue = upDownMax
        
        //Create a motion effect group
        let meGroup = UIMotionEffectGroup()
        meGroup.motionEffects = [leftRight, upDown]
        
        view.addMotionEffect(meGroup)
    }
    */

}

//MARK: - Reachability
public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)} } )
            else { return false }

        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }
}
////MARK: - ImageScaling
//extension UIImage {
//   
//    func resizeWith(width: CGFloat,height : CGFloat) -> UIImage? {
//        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height:height )))
//        imageView.contentMode = .ScaleAspectFit
//        imageView.image = self
//        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//        imageView.layer.renderInContext(context)
//        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
//        UIGraphicsEndImageContext()
//        return result
//    }
//}
