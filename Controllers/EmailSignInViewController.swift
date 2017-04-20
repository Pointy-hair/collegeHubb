//
//  EmailSignInViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class EmailSignInViewController: UIViewController {

    //Dummy Account
    //anika@gmail.com
    //123456
    
    var imageView: UIImageView?
    var showPass: Bool?
    
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBAction func btnSignInAction(_ sender: UIButton) {
        if case .success(_) = User.validateLoginFields(txtFieldEmail?.text, password:  txtFieldPassword?.text, controller: self){
            dismissKeyboard()
            APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.login(email: txtFieldEmail.text, password: txtFieldPassword.text)) ) { (response) in

                switch response {
                case .success(let data):
                    
                    print(data ?? "")
                    let x = data as? User
                    print(x?.access_token ?? "")
                    print("parsed&&&&&&&&&&&&&&&&&&&&&&&&")
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
                     print(message ?? "")
                    UtilityFunctions.showAlert(message: message, controller: self)

                default : break
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        initialise()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true);
//    }
    
    func initialise(){
        self.navBar?.isHidden = false
        
        
        //Set custom Navigation item
        /*let rightButton = UIBarButtonItem(title: "Forgot Password ?", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        rightButton.tintColor = UIColor.white
        if let font = UIFont(name: "Gotham-Bold", size: 18) {
            rightButton.setTitleTextAttributes([NSFontAttributeName:font], for: .normal)
        }
        navigationItem.rightBarButtonItem = rightButton*/

        
        //Remove bottom border of navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Back button setting
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back_white")
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.white;

        showPass = false
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView?.image = UIImage(named: "ic_visibility")
        
        if let size = imageView?.image?.size {
            imageView?.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 15.0, height: size.height)
        }
        imageView?.contentMode = UIViewContentMode.center
        
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(EmailSignInViewController.showHidePassword))
        singleTap.numberOfTapsRequired = 1 // you can change this value
        imageView?.isUserInteractionEnabled = true
        imageView?.addGestureRecognizer(singleTap)
        txtFieldPassword.rightView = imageView
        txtFieldPassword.rightViewMode = UITextFieldViewMode.always
    }

    func showHidePassword(){
        if showPass == true{
            imageView?.image = UIImage(named: "ic_visibility")
            txtFieldPassword.isSecureTextEntry = true
            showPass = false
            
        }else{
            imageView?.image = UIImage(named: "ic_visibility_off")
            txtFieldPassword.isSecureTextEntry = false
            showPass = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EmailSignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldEmail{
            txtFieldPassword.becomeFirstResponder()
            return true
        }else if textField == txtFieldPassword{
            txtFieldPassword.resignFirstResponder()
            return true
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let whitespaceSet = NSCharacterSet.whitespaces
        if let _ = string.rangeOfCharacter(from: whitespaceSet) {
            return false
        }
        
        if textField == txtFieldPassword{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            let newLength: Int = newString.length
            if newLength == 15 {
                return false
            }
        }
        return true
    }
}
