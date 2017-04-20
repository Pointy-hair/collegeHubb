//
//  FbGoogleViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn


class FbGoogleViewController: UIViewController ,GIDSignInUIDelegate{

    var dict : [String : AnyObject]!
    let fbManger = FBSDKLoginManager()
    
    @IBOutlet weak var btnGoogleLogin: UIButton!
    @IBOutlet weak var btnTermsConditions: UIButton!
    @IBOutlet weak var btnSignInEmail: UIButton!
    @IBOutlet weak var btnFbLogin: UIButton!
    
    @IBAction func btnGoogleLoginAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func btnSignInEmailAction(_ sender: UIButton) {

    }

    @IBAction func btnFbLoginAction(_ sender: UIButton) {
        
        FacebookManager.sharedInstance.fbLogin(fbManger, viewcontroller: self, Success: { (response) in

            self.callFacebookAccountLogin(accountType: "0", response: response as! Facebook)
        }) { (error) in
            
//            _ = SweetAlert().showAlert(helperNames.oops.rawValue, subTitle: error, style: AlertStyle.none)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initialise()
        GIDSignIn.sharedInstance().uiDelegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(FbGoogleViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true);
    }
    
    func initialise(){
//        self.navBar?.isHidden = true
        btnFbLogin.layer.borderWidth = 1.0
        btnFbLogin.layer.borderColor = UIColor.white.cgColor
        btnFbLogin.layer.cornerRadius = btnRadius
        btnGoogleLogin.layer.borderWidth = 1.0
        btnGoogleLogin.layer.borderColor = UIColor.white.cgColor
        btnGoogleLogin.layer.cornerRadius = btnRadius
        btnTermsConditions.titleLabel?.numberOfLines = 2
        btnTermsConditions.titleLabel?.adjustsFontSizeToFitWidth = true
        btnTermsConditions.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            if notification.userInfo != nil {
                if let googleUser = notification.userInfo?["data"] as? GIDGoogleUser {
                    print(googleUser.userID)
                    
                    self.callGoogleAccountLogin(accountType: "1", response: googleUser)
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                                  object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FbGoogleViewController{
    
    func callFacebookAccountLogin(accountType:String?,response: Facebook){
        
        let fbModel = response
        print(fbModel)

        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.socialAccountLogin(account_type: accountType, fb_id: fbModel.fbId,google_id: "", firstname: fbModel.firstName, lastname: fbModel.lastName, image: fbModel.imageUrl, email: fbModel.email, gender:"", dob: ""))  , completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                let x = data as? User
                print(x?.access_token ?? "")

                UserDataSingleton.sharedInstance.loggedInUser = data as? User
                print(UserDataSingleton.sharedInstance.loggedInUser ?? "")
                
                if UserDataSingleton.sharedInstance.loggedInUser?.is_verified != nil && UserDataSingleton.sharedInstance.loggedInUser?.is_verified == "1"{
                    let tabbarVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabbarController") as? CustomTabbarController
                    self.presentVC(tabbarVC!)

                }else{
                    let verifyEduVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyEmailViewController") as? VerifyEmailViewController
                    self.navigationController?.pushViewController(verifyEduVC!, animated: true)
                }
                
            case .failureMessage(let message):
                print("failure")
                UtilityFunctions.showAlert(message: message, controller: self)
            default : break
                
                
            }
        })
    }
    
    func callGoogleAccountLogin(accountType:String?,response: GIDGoogleUser){
        
        var image: String?
        if response.profile.hasImage{
            let imageUrl = response.profile.imageURL(withDimension:120)
            print(" image url: ", imageUrl?.absoluteString ?? "")
            image = imageUrl?.absoluteString
        }else{
            image = ""
        }
        
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.socialAccountLogin(account_type: accountType, fb_id:"" ,google_id: response.userID, firstname: response.profile.givenName, lastname: response.profile.familyName, image: image, email: response.profile.email, gender:"", dob: ""))  , completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                let x = data as? User
                print(x?.access_token ?? "")
                
                UserDataSingleton.sharedInstance.loggedInUser = data as? User
                print(UserDataSingleton.sharedInstance.loggedInUser ?? "")
                
                if UserDataSingleton.sharedInstance.loggedInUser?.is_verified != nil && UserDataSingleton.sharedInstance.loggedInUser?.is_verified == "1"{
                    let tabbarVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabbarController") as? CustomTabbarController
                    self.presentVC(tabbarVC!)
                }else{
                    let verifyEduVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyEmailViewController") as? VerifyEmailViewController
                    self.navigationController?.pushViewController(verifyEduVC!, animated: true)
                }
                
            case .failureMessage(let message):
                print("failure")
                UtilityFunctions.showAlert(message: message, controller: self)
            default : break
                
                
            }
        })
    }
    
}
