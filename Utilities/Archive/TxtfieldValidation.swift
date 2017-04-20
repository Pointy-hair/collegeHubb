//
//  TxtfieldValidation.swift
//  CollegeHub
//
//  Created by Sumanpreet on 12/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

enum Result{
    case success(String)
    case failure(String)
}

enum warningMessage : String{
    
    case emptyEmail = "Please enter Email"
    case emptyPassword = "Please enter Password"
    case validPassword = "Please enter a valid password."
    case validPhoneNumber = "Please enter a valid phone number"
    case validName = "Please enter a valid name"
    case validEmailAddress = "Please enter a valid email address."
    case validFirstName = "Please enter a firstname."
    case validLastName = "Please enter a lastname."
    case validBirthDate = "Please enter a birth date."
    case validGender = "Please enter a gender."
    case validEmailExtension = "Please enter a valid email extension."
    case validOTP = "Please enter the complete 4 digit code"

    case restYourPassword = "An email was sent to you to rest your password"
    case changePassword = "Your password has been changed successfully"
    case logoutMsg = "You've been logged out successfully."
}

internal struct RegexExpresssions {
    
    static let EmailRegex = "[A-Z0-9a-z._%+-]{1,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    static let PasswordRegex = "[A-Za-z0-9]{6,20}"
    static let PhoneRegex = "[0-9]{6,14}"
    
}

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension User{
    class func validateLoginFields (_ email : String? , password : String?, controller: UIViewController) -> Result{
        
        guard let mailId = email , mailId.characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.emptyEmail.rawValue, controller: controller)
            return .failure(warningMessage.emptyEmail.rawValue)
        }
        
        guard let mail = email , User.isValidEmail(mail) else{
            UtilityFunctions.showAlert(message: warningMessage.validEmailAddress.rawValue, controller: controller)
            return .failure(warningMessage.validEmailAddress.rawValue)
        }
        
        guard let pas = password  , pas.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.emptyPassword.rawValue, controller: controller)
            return .failure(warningMessage.emptyPassword.rawValue)
        }
        
        guard let pass = password  ,  User.isValidPassword(pass)  else{
            UtilityFunctions.showAlert(message: warningMessage.validPassword.rawValue, controller: controller)
            return .failure(warningMessage.validPassword.rawValue)
        }
        return .success("")
    }
    
    class func validateSignUpFields (_ email : String? , firstName : String?, lastName : String? , password : String?, dob : String? , gender : String?,  controller: UIViewController) -> Result{
        
        guard let mailId = email , mailId.characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.emptyEmail.rawValue, controller: controller)
            return .failure(warningMessage.emptyEmail.rawValue)
        }
        
        guard let mail = email , User.isValidEmail(mail) else{
            UtilityFunctions.showAlert(message: warningMessage.validEmailAddress.rawValue, controller: controller)
            return .failure(warningMessage.validEmailAddress.rawValue)
        }
        
        guard let first = firstName  , first.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validFirstName.rawValue, controller: controller)
            return .failure(warningMessage.validFirstName.rawValue)
        }
        
        guard let last = lastName  , last.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validLastName.rawValue, controller: controller)
            return .failure(warningMessage.validLastName.rawValue)
        }
        
        guard let pas = password  , pas.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.emptyPassword.rawValue, controller: controller)
            return .failure(warningMessage.emptyPassword.rawValue)
        }
        
        guard let pass = password  ,  User.isValidPassword(pass)  else{
            UtilityFunctions.showAlert(message: warningMessage.validPassword.rawValue, controller: controller)
            return .failure(warningMessage.validPassword.rawValue)
        }
        
        guard let birthDate = dob  , birthDate.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validBirthDate.rawValue, controller: controller)
            return .failure(warningMessage.validBirthDate.rawValue)
        }
        
        guard let gen = gender  , gen.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validGender.rawValue, controller: controller)
            return .failure(warningMessage.validGender.rawValue)
        }
        
        return .success("")
    }
    
    class func validateForgotPasswordFields (_ email : String?, controller: UIViewController) -> Result{
        
        guard let mailId = email , mailId.characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.emptyEmail.rawValue, controller: controller)
            return .failure(warningMessage.emptyEmail.rawValue)
        }
        
        guard let mail = email , User.isValidEmail(mail) else{
            UtilityFunctions.showAlert(message: warningMessage.validEmailAddress.rawValue, controller: controller)
            return .failure(warningMessage.validEmailAddress.rawValue)
        }
        
        return .success("")
    }
    
    class func validateEduEmailFields (_ email : String? , emailExtension : String?, controller: UIViewController) -> Result{
        
        guard let mailId = email , mailId.trim().characters.count != 0  else{
            UtilityFunctions.showAlert(message: warningMessage.emptyEmail.rawValue, controller: controller)
            return .failure(warningMessage.emptyEmail.rawValue)
        }
        guard let exten = emailExtension  , exten.trim().characters.count != 0  else{
            UtilityFunctions.showAlert(message: warningMessage.validEmailExtension.rawValue, controller: controller)
            return .failure(warningMessage.validEmailExtension.rawValue)
        }
        return .success("")
    }
    
    class func validateOTPCodeFields (_ field1 : String? , field2 : String?, field3 : String?, field4 : String?, controller: UIViewController) -> Result{
        
        guard let f1 = field1, let f2 = field2 ,let f3 = field3, let f4 = field4 , f1.trim().characters.count != 0 && f2.trim().characters.count != 0 && f3.trim().characters.count != 0 && f4.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validOTP.rawValue, controller: controller)
            return .failure(warningMessage.validOTP.rawValue)
        }
        
        return .success("")
    }
    
    class func validateEditProfileFields (_ email : String? , firstName : String?, lastName : String?, dob : String?, gender : String?, controller: UIViewController) -> Result{
        
        guard let mailId = email , mailId.characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.emptyEmail.rawValue, controller: controller)
            return .failure(warningMessage.emptyEmail.rawValue)
        }
        
        guard let mail = email , User.isValidEmail(mail) else{
            UtilityFunctions.showAlert(message: warningMessage.validEmailAddress.rawValue, controller: controller)
            return .failure(warningMessage.validEmailAddress.rawValue)
        }
        
        guard let first = firstName  , first.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validFirstName.rawValue, controller: controller)
            return .failure(warningMessage.validFirstName.rawValue)
        }
        guard let last = lastName  , last.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validLastName.rawValue, controller: controller)
            return .failure(warningMessage.validLastName.rawValue)
        }
        guard let birthDate = dob  , birthDate.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validBirthDate.rawValue, controller: controller)
            return .failure(warningMessage.validBirthDate.rawValue)
        }
        
        guard let gen = gender  , gen.trim().characters.count != 0 else{
            UtilityFunctions.showAlert(message: warningMessage.validGender.rawValue, controller: controller)
            return .failure(warningMessage.validGender.rawValue)
        }
        return .success("")
    }
    
    
    class func isValidEmail(_ testStr:String) -> Bool {
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", RegexExpresssions.EmailRegex)
        return emailTest.evaluate(with: testStr)
    }
    
    class func isValidPassword(_ testStr:String) -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", RegexExpresssions.PasswordRegex)
        return passwordTest.evaluate(with: testStr)
    }
    
    
}
