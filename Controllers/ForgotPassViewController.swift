//
//  ForgotPassViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import SwiftyJSON

class ForgotPassViewController: UIViewController,UITextFieldDelegate {

    @IBAction func btnBackAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBAction func btnHelpMeAction(_ sender: Any) {
        if case .success(_) = User.validateForgotPasswordFields(txtFieldEmail.text, controller: self){
            dismissKeyboard()
                APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.forgotPassword(email: txtFieldEmail.text)),  completion: { (response) in
                    
                    switch response{
                        
                    case .success(let data) :
                        
                        print(data ?? "")
                        let message = data as! JSON
                        print(message.stringValue)
                        
                        self.txtFieldEmail.text = ""
                        UtilityFunctions.showAlert(message: message.stringValue, controller: self)
                        
                        
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
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldEmail{
            txtFieldEmail.resignFirstResponder()
            return true
        }
        return true
    }

}
