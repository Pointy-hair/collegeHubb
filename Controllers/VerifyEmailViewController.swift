//
//  VerifyEmailViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 09/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import SwiftyJSON

class VerifyEmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFieldEmail1: UITextField!
    @IBOutlet weak var txtFieldEmail2: UITextField!
    @IBAction func btnVerify(_ sender: Any) {
        
        if case .success(_) = User.validateEduEmailFields(txtFieldEmail1.text, emailExtension: txtFieldEmail2.text, controller: self){
            dismissKeyboard()
            
            let eduEmail = txtFieldEmail1.text! + "@" + txtFieldEmail2.text!
            
            APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.sendEmailToEduId(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, edu_email: eduEmail)), completion: { (response) in
                
                switch response{
                    
                case .success(let data) :
                    
                    print(data ?? "")
                    let message = data as! JSON
                    print(message.stringValue)
                    
                    let alert = UIAlertController(title: "", message: "Please verify yourself by clicking on the Verification Link that we have sent on your college Email ID and then try to login", preferredStyle: .alert)
                    alert.view.tintColor = appColor
                    alert.view.backgroundColor = UIColor.white
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
                        
                        let fbgoogleVC = self.storyboard?.instantiateViewController(withIdentifier: "FbGoogleViewController") as? FbGoogleViewController
                        let controllers = self.navigationController?.viewControllers
                        for vc in controllers! {
                            if vc is FbGoogleViewController {
                                _ = self.navigationController?.popToViewController(vc as! FbGoogleViewController, animated: true)
                            }
                        }
                    }))
                    
                    self.present(alert, animated: true, completion: {
                    })
                    

                case .failureMessage(let message):
                    print("failure")
                    
                    UtilityFunctions.showAlert(message: message, controller: self)
                    
                default : break
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navBar?.isHidden = false
        
        //Remove bottom border of navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Back button setting
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back_white")
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldEmail1{
            txtFieldEmail2.becomeFirstResponder()
            return true
        }else if textField == txtFieldEmail2{
            txtFieldEmail2.resignFirstResponder()
            return true
        }
        return true
    }
}
