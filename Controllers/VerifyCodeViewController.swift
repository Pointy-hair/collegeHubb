//
//  VerifyCodeViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 09/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import SwiftyJSON

class VerifyCodeViewController: UIViewController {
    
    @IBOutlet weak var txtField1: UITextField!
    @IBOutlet weak var txtField2: UITextField!
    @IBOutlet weak var txtField3: UITextField!
    @IBOutlet weak var txtField4: UITextField!
    @IBAction func btnVerifyAction(_ sender: Any) {
        
//        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabbarController") as? CustomTabbarController
//        self.presentVC(tabBarController!)
        
        if case .success(_) = User.validateOTPCodeFields(txtField1.text, field2: txtField2.text, field3: txtField3.text, field4: txtField4.text, controller: self){
            dismissKeyboard()
            
            let completeCode = txtField1.text! + txtField2.text! + txtField3.text! + txtField4.text!

            APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.verifyEduId(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, verification_code: completeCode)), completion: { (response) in
                
                switch response{
                    
                case .success(let data) :
                    
                    print(data ?? "")
                    let message = data as! JSON
                    print(message.stringValue)
                    let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabbarController") as? CustomTabbarController
                    self.presentVC(tabBarController!)

                    
                case .failureMessage(let message):
                    print("failure")
                    UtilityFunctions.showAlert(message: message, controller: self)
                default : break
                }
            })
        }
    }
    
    @IBAction func btnResendCodeAction(_ sender: Any) {
        
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.resendCode(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                let message = data as! JSON
                print(message.stringValue)
                
                UtilityFunctions.showAlert(message: message.stringValue, controller: self)
                
                
            case .failureMessage(let message):
                print("failure")
                UtilityFunctions.showAlert(message: message, controller: self)
            default : break
            }
        })
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
        
        txtField1.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VerifyCodeViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        let newLength: Int = newString.length
        if textField == txtField1 {
            if newLength == 2 {
                txtField2.becomeFirstResponder()
            }
        }
        if textField == txtField2{
            if newLength == 2{
                txtField3.becomeFirstResponder()
            }
        }
        if textField  == txtField3 {
            if newLength == 2 {
                txtField4.becomeFirstResponder()
            }
        }
        if textField == txtField4 {
            if newLength == 2 {
                self.view.endEditing(true)
            }
        }
        return true
    }
    
}
