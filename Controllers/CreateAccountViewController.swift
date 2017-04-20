//
//  CreateAccountViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0


class CreateAccountViewController: UIViewController {

    var imageView: UIImageView?
    var showPass: Bool?
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldFirstName: UITextField!
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldDOB: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        
        if case .success(_) = User.validateSignUpFields(txtFieldEmail.text, firstName: txtFieldFirstName.text, lastName: txtFieldLastName.text, password: txtFieldPassword.text, dob: txtFieldDOB.text, gender: txtFieldGender.text, controller: self){
            dismissKeyboard()
            
            let gender: String?
            if txtFieldGender.text == "Male"{
                gender = "1"
            }else{
                gender = "2"
            }
            
            APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.signup(email: txtFieldEmail.text, password: txtFieldPassword.text, firstname: txtFieldFirstName.text, lastname: txtFieldLastName.text, gender: gender, dob: txtFieldDOB.text)) ) { (response) in
                
                switch response {
                case .success(let data):
                    
                    weak var weakSelf  = self
                    print(data ?? "")
                    let x = data as? User
                    print(x?.access_token ?? "")
                    
                    UserDataSingleton.sharedInstance.loggedInUser = data as? User
                    let uploadVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadPictureViewController") as? UploadPictureViewController
                    weakSelf?.navigationController?.pushViewController(uploadVC!, animated: true)
                    
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

        initialiseNavBar()
        initialiseTextFields()
    }
    
    func initialiseNavBar(){
        self.navBar?.isHidden = false
        
        //Remove bottom border of navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Back button setting
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back_white")
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }
    
    func initialiseTextFields(){
        //set Text Field Accessory Image View
        showPass = false
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView?.image = UIImage(named: "ic_visibility")
        if let size = imageView?.image?.size {
            imageView?.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 15.0, height: size.height)
        }
        imageView?.contentMode = UIViewContentMode.center
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(CreateAccountViewController.showHidePassword))
        singleTap.numberOfTapsRequired = 1 // you can change this value
        imageView?.isUserInteractionEnabled = true
        imageView?.addGestureRecognizer(singleTap)
        txtFieldPassword.rightView = imageView
        txtFieldPassword.rightViewMode = UITextFieldViewMode.always
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imgView.image = UIImage(named: "ic_calender")
        if let size = imgView.image?.size {
            imgView.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 15.0, height: size.height)
        }
        imgView.contentMode = UIViewContentMode.center
        txtFieldDOB.rightView = imgView
        txtFieldDOB.rightViewMode = UITextFieldViewMode.always
        
        let imgView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imgView1.image = UIImage(named: "ic_dropdown")
        if let size = imgView1.image?.size {
            imgView1.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 15.0, height: size.height)
        }
        imgView1.contentMode = UIViewContentMode.center
        txtFieldGender.rightView = imgView1
        txtFieldGender.rightViewMode = UITextFieldViewMode.always
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                txtFieldDOB.font = UIFont(name: "Gotham-Bold", size: 13)
            default:
                print("unknown")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }
    
    func showHidePassword(pass: Bool){
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


class FormTextField: UITextField {
    
     var paddingLeft: CGFloat = 10
     var paddingRight: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

//MARK:- Picker Functions
extension CreateAccountViewController{
    
    func openDatePicker(_ sender : Any){
         let datePicker = ActionSheetDatePicker(title: "Birth Date", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
         picker, value, index in
         
            //dd-MMM-YYYY
            //yyyy-mm-dd

             print("value = \(value)")
             let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: value as! Date)
             print ("true value = \(tomorrow)")
             print("index = \(index)")
             print("picker = \(picker)")
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            let myDateString = dateFormatter.string(from: value! as! Date)
            print(myDateString)
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd/mm/yy"
            let showDate = inputFormatter.date(from: myDateString)
            inputFormatter.dateFormat = "yyyy-dd-mm"
            let resultString = inputFormatter.string(from: showDate!)
            print(resultString)
            
            self.txtFieldDOB.text = resultString
            
         return
         }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
         
         datePicker?.maximumDate = NSDate() as Date!
         
         datePicker?.setTextColor(appColor)
         datePicker?.pickerBackgroundColor = UIColor.white
         datePicker?.toolbarBackgroundColor = UIColor.white
         datePicker?.toolbarButtonsColor = appColor
         
         datePicker?.show()
    }
    
    func openGenderPicker(_ sender : Any){
         let alert = UIAlertController(title: "", message: "Please select your gender", preferredStyle: .actionSheet)
         alert.view.tintColor = appColor
         alert.view.backgroundColor = UIColor.white
         
         alert.addAction(UIAlertAction(title: "Male", style: .default , handler:{ (UIAlertAction)in
            self.txtFieldGender.text = "Male"
         }))
         
         alert.addAction(UIAlertAction(title: "Female", style: .default , handler:{ (UIAlertAction)in
            self.txtFieldGender.text = "Female"
         }))
        
         self.present(alert, animated: true, completion: {
         print("completion block")
         })
 
    }
    
    
}

//MARK:- TextField Delegates
extension CreateAccountViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFieldDOB{
            self.view.endEditing(true)
            openDatePicker(txtFieldDOB)
            return false
        }else if textField == txtFieldGender{
            self.view.endEditing(true)
            openGenderPicker(txtFieldGender)
            return false
        }else{
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let whitespaceSet = NSCharacterSet.whitespaces
        let characterSet = CharacterSet.letters
        
        if textField == txtFieldFirstName || textField == txtFieldLastName{
            if let _ = string.rangeOfCharacter(from: whitespaceSet) {
                return false
            }else if string.rangeOfCharacter(from: characterSet.inverted) != nil {
                return false
            }else {
                return true
            }
        }else if textField == txtFieldPassword{
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldEmail{
            txtFieldFirstName.becomeFirstResponder()
            return true
        }else if textField == txtFieldFirstName{
            txtFieldLastName.becomeFirstResponder()
            return true
        }else if textField == txtFieldLastName{
            txtFieldPassword.becomeFirstResponder()
            return true
        }else if textField == txtFieldPassword{
            txtFieldDOB.becomeFirstResponder()
            return true
        }else{
            return true
        }
    }
}



