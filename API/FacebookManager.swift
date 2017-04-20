//
//  FacebookManager.swift
//  Glam360
//
//  Created by cbl16 on 7/6/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SDWebImage
import SwiftyJSON
//import NVActivityIndicatorView


class FacebookManager : NSObject/*,NVActivityIndicatorViewable*/ {
    
    
    static let sharedInstance : FacebookManager = {
        let instance = FacebookManager()
        return instance
    }()
    
    
    override init(){
    }
    
     func fbLogin(_ loginManager : FBSDKLoginManager, viewcontroller:UIViewController,Success: @escaping (AnyObject?) -> () , Failure: @escaping (String?) -> ()) {
   

        loginManager.logIn(withReadPermissions: ["public_profile","email"], from: viewcontroller) { (result, error) in
            
                let fbloginresult : FBSDKLoginManagerLoginResult? = result
                if fbloginresult?.grantedPermissions != nil {
                    
                        self.LoginWithFacebook({ (modelData) in
                            
                            Success(modelData)
                            
                            }, Failure: { (Fbdata) in
                                
                                Failure(Fbdata)
                        })
                }
            }
    }
    
    
    
     func LoginWithFacebook(_ Success: @escaping (AnyObject?) -> () , Failure: @escaping (String?) -> ()) {
        
//        startAnimating(CGSize(width:44 , height: 44), message: nil, type: .lineScale, color:UIColor.white  , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)

        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){

                    do {
                      let fbModal = try Facebook(withAttributes: JSON(result).dictionaryValue)
                        Success(fbModal)
                    } catch _ {
                        Failure(nil)
                    }
                    
                    
                }else{
                   
                    Failure(error?.localizedDescription )
                }
            })
        }
    }
}


class Facebook : NSObject {
    
    var fbId : String?
    var firstName : String?
    var lastName : String?
    var imageUrl : String?
    var email : String?
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        fbId = FBSDKAccessToken.current().userID
        firstName = UserKeys.first_name.rawValue => attributes
        lastName = UserKeys.last_name.rawValue => attributes
        guard let url = fbId else {return}
        imageUrl = "https://graph.facebook.com/\(url)/picture?type=normal"
        email = UserKeys.email.rawValue => attributes
        
    }
  
    override init() {
        super.init()
}


}

