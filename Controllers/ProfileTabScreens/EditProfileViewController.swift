//
//  EditProfileViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 15/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class EditProfileViewController: UIViewController {
    
//MARK:- VARIABLE
    var imagePicked: UIImage?

    
//MARK:- OUTLETS
    @IBOutlet weak var lblNameEditProfile: UILabel!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldFirstName: UITextField!
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var txtFieldBirthDate: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    
//MARK:- BTN ACTIONS
    @IBAction func btnDoneAction(_ sender: Any) {
        //Call Edit Profile API
        
        if case .success(_) = User.validateEditProfileFields(txtFieldEmail.text, firstName: txtFieldFirstName.text, lastName: txtFieldLastName.text, dob: txtFieldBirthDate.text, gender: txtFieldGender.text, controller: self){
            dismissKeyboard()
            
            let gender: String?
            if txtFieldGender.text == "Male"{
                gender = "1"
            }else{
                gender = "2"
            }
            
            let user = UserDataSingleton.sharedInstance.loggedInUser
            APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.editProfile(access_token: user?.access_token, firstname: txtFieldFirstName.text, lastname: txtFieldLastName.text, gender: gender, dob: txtFieldBirthDate.text)) , image: imagePicked , completion: { (response) in
                
                switch response{
                    
                case .success(let data) :
                    
                    print(data ?? "")
                    let x = data as? User
                    print(x?.access_token ?? "")
                    
                    UserDataSingleton.sharedInstance.loggedInUser = data as? User
                    print(UserDataSingleton.sharedInstance.loggedInUser ?? "")
                    
                case .failureMessage(let message):
                    print("failure")
                    UtilityFunctions.showAlert(message: message, controller: self)
                default : break
                    
                    
                }
            })
        }
    }
    
//MARK:- functions
    func addImagesToTextFields(){
        //set Text Field Accessory Image View
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imgView.image = UIImage(named: "ic_calender_black")
        if let size = imgView.image?.size {
            imgView.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 15.0, height: size.height)
        }
        imgView.contentMode = UIViewContentMode.center
        txtFieldBirthDate.rightView = imgView
        txtFieldBirthDate.rightViewMode = UITextFieldViewMode.always
        
        let imgView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imgView1.image = UIImage(named: "ic_dropdown_dark")
        if let size = imgView1.image?.size {
            imgView1.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 15.0, height: size.height)
        }
        imgView1.contentMode = UIViewContentMode.center
        txtFieldGender.rightView = imgView1
        txtFieldGender.rightViewMode = UITextFieldViewMode.always
    }
    
    func setupInitialValues(){
        if let firstName = UserDataSingleton.sharedInstance.loggedInUser?.firstname{
            lblNameEditProfile.text = "Hello \(firstName),\nEdit your details below."
        }
        
        txtFieldEmail.text = UserDataSingleton.sharedInstance.loggedInUser?.email
        txtFieldFirstName.text = UserDataSingleton.sharedInstance.loggedInUser?.firstname
        txtFieldLastName.text = UserDataSingleton.sharedInstance.loggedInUser?.lastname
        txtFieldBirthDate.text = UserDataSingleton.sharedInstance.loggedInUser?.dob
        
        let gender = UserDataSingleton.sharedInstance.loggedInUser?.gender
        if gender == "1"{
            txtFieldGender.text = "Male"
        }else if gender == "2"{
            txtFieldGender.text = "Female"
        }else{
            txtFieldGender.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remove bottom border of navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        addImagesToTextFields()
        setupInitialValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- HANDLE TEXTFIELD DELEGATES
extension EditProfileViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldEmail{
            txtFieldFirstName.becomeFirstResponder()
            return true
        }else if textField == txtFieldFirstName{
            txtFieldLastName.becomeFirstResponder()
            return true
        }else if textField == txtFieldLastName{
            txtFieldBirthDate.becomeFirstResponder()
            return true
        }else{
            return true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFieldBirthDate{
            self.view.endEditing(true)
            openDatePicker(txtFieldBirthDate)
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
        }
        return true
    }
}

//MARK:- DATE PICKER AND GENDER PICKER FUNCTIONS
extension EditProfileViewController{
    func openDatePicker(_ sender : Any){
        let datePicker = ActionSheetDatePicker(title: "Edit Birth Date", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
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
            
            self.txtFieldBirthDate.text = resultString
            
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
        let alert = UIAlertController(title: "", message: "Please edit your gender", preferredStyle: .actionSheet)
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

//MARK:- EDITPROFILE TEXTFIELD CLASS
class EditProfileTxtField: UITextField {
    
    var paddingLeft: CGFloat = 10
    var paddingRight: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(hexString: "EEEEEE")?.cgColor
        self.layer.cornerRadius = 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
