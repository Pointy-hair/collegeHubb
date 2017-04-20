//
//  User.swift
//  Glam360
//
//  Created by Night Reaper on 30/06/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import Foundation
import SwiftyJSON
import EZSwiftExtensions

typealias OptionalSwiftJSONParameters = [String : JSON]?


protocol JSONDecodable {
    init(withAttributes attributes : OptionalSwiftJSONParameters) throws
}


protocol JSONDecodableWithIndex {
    init(withAttributes attributes : OptionalSwiftJSONParameters,index : Int) throws
}



infix operator =>
infix operator =|
infix operator =/

func =>(key : String, json : OptionalSwiftJSONParameters) -> String?{
    return json?[key]?.stringValue
}
func =|(key : String, json : OptionalSwiftJSONParameters) -> [JSON]?{
    return json?[key]?.arrayValue
}

func =/(key : String, json : OptionalSwiftJSONParameters) -> [String : JSON]?{
    return json?[key]?.dictionaryValue
}

prefix operator ¿
prefix func ¿(value : String?) -> String {
    return value.unwrap()
}

enum  UserKeys : String {
    
    case user_id = "users_id"
    case access_token = "access_token"
    case firstname = "firstname"
    case lastname = "lastname"
    case fb_id = "fb_id"
    case google_id = "google_id"
    case email = "email"
    case image100 = "image100"
    case image200 = "image200"
    case image400 = "image400"
    case edu_email = "edu_email"
    case verification_code = "verification_code"
    case dob = "dob"
    case gender = "gender" // 0 or 1
    case is_verified = "is_verified" // 0 or 1 
    case ios_version = "ios_version"
    case android_version = "android_version"
    
    //edited
    case stripe_account_id = "stripe_account_id"
    case stripe_customer_id = "stripe_customer_id"
    case card_added = "card_added"
    //complete
    
    //Facebook Parameters
    case first_name = "first_name"
    case last_name = "last_name"
}


class User : NSObject,JSONDecodable {
   
    var user_id : String?
    var access_token : String?
    var firstname : String?
    var lastname : String?
    var fb_id : String?
    var google_id : String?
    var email : String?
    var image100 : String?
    var image200 : String?
    var image400 : String?
    var edu_email : String?
    var verification_code : String?
    var dob : String?
    var gender : String?
    var is_verified : String?
    var ios_version : String?
    var android_version : String?
    //edited
    var stripe_account_id: String?
    var stripe_customer_id: String?
    var card_added : String?
    //complete
    
    var fullName : String?
        
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        user_id = UserKeys.user_id.rawValue => attributes
        access_token = UserKeys.access_token.rawValue => attributes
        firstname = UserKeys.firstname.rawValue => attributes
        lastname = UserKeys.lastname.rawValue => attributes
        fb_id = UserKeys.fb_id.rawValue => attributes
        google_id = UserKeys.google_id.rawValue => attributes
        email = UserKeys.email.rawValue => attributes
        image100 = UserKeys.image100.rawValue => attributes
        image200 = UserKeys.image200.rawValue => attributes
        image400 = UserKeys.image400.rawValue => attributes
        edu_email = UserKeys.edu_email.rawValue => attributes
        verification_code = UserKeys.verification_code.rawValue => attributes
        dob = UserKeys.dob.rawValue => attributes
        gender = UserKeys.gender.rawValue => attributes
        is_verified = UserKeys.is_verified.rawValue => attributes
        ios_version = UserKeys.ios_version.rawValue => attributes
        android_version = UserKeys.android_version.rawValue => attributes
        
        //edited
        stripe_account_id = UserKeys.stripe_account_id.rawValue => attributes
        stripe_customer_id = UserKeys.stripe_customer_id.rawValue => attributes
        card_added = UserKeys.card_added.rawValue => attributes
        //complete
        
        fullName = ¿firstname + ¿lastname
    }
    
    override init() {
        super.init()
    }
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [User] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try User(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
    
}


protocol StringType { var get: String { get } }
extension String: StringType { var get: String { return self } }

extension Optional where Wrapped: StringType {
    func unwrap() -> String {
        return self?.get ?? ""
    }
}

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}




