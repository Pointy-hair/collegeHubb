//
//  Notification.swift
//  CollegeHub
//
//  Created by Sierra 4 on 11/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import EZSwiftExtensions

enum  NotificationKeys : String {
    
    case date = "date"
    case time_since = "time_since"
    case notifications_id = "notifications_id"
    case users_id = "users_id"
    case firstname = "firstname"
    case lastname = "lastname"
    case is_read = "is_read"
    case type = "type"
    case image100 = "image100"
    case time = "time"
    case details = "details"
    case formatted_date = "formatted_date"
}

class NotificationModal : NSObject,JSONDecodable {
    
    var formatted_date : String?
    var date : String?
    var time_since : String?
    var notifications_id : String?
    var users_id : String?
    var firstname : String?
    var lastname : String?
    var is_read : String?
    var type : String?
    var image100 : String?
    var time : String?
    var details = [NotificationModal]()
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        formatted_date = NotificationKeys.formatted_date.rawValue => attributes
        date = NotificationKeys.date.rawValue => attributes
        time_since = NotificationKeys.time_since.rawValue => attributes
        notifications_id = NotificationKeys.notifications_id.rawValue => attributes
        users_id = NotificationKeys.users_id.rawValue => attributes
        firstname = UserKeys.firstname.rawValue => attributes
        lastname = NotificationKeys.lastname.rawValue => attributes
        is_read = NotificationKeys.is_read.rawValue => attributes
        type = NotificationKeys.type.rawValue => attributes
        image100 = NotificationKeys.image100.rawValue => attributes
        time = NotificationKeys.time.rawValue => attributes
        
        if  let notificationTemp = NotificationKeys.details.rawValue =| attributes {
            for dict in notificationTemp {
                details.append(try NotificationModal(withAttributes: dict.dictionaryValue))
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [NotificationModal] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try NotificationModal(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
    
}
