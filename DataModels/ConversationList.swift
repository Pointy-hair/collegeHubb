//
//  ConversationList.swift
//  CollegeHub
//
//  Created by Sumanpreet on 08/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import Foundation
import SwiftyJSON
import EZSwiftExtensions

enum messageKeys : String{
    case users_id1 = "users_id1"
    case users_id2 = "users_id2"
    case date = "date" //2017-02-14
    case message_id = "message_id"
    case message = "message"
    case is_read = "is_read"
    case firstname = "firstname"
    case lastname = "lastname"
    case image100 = "image100"
    case time = "time"
    case unread_count = "unread_count"
}

class MessageModel : NSObject, JSONDecodable{
    
    var users_id1 : String?
    var users_id2 : String?
    var date : String?
    var message_id : String?
    var message : String?
    var is_read : String?
    var firstname : String?
    var lastname : String?
    var image100 : String?
    var time : String?
    var unread_count : String?

    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        users_id1 = messageKeys.users_id1.rawValue => attributes
        users_id2 = messageKeys.users_id2.rawValue => attributes
        date = messageKeys.date.rawValue => attributes
        message_id = messageKeys.message_id.rawValue => attributes
        message = messageKeys.message.rawValue => attributes
        is_read = messageKeys.is_read.rawValue => attributes
        firstname = messageKeys.firstname.rawValue => attributes
        lastname = messageKeys.lastname.rawValue => attributes
        image100 = messageKeys.image100.rawValue => attributes
        time = messageKeys.time.rawValue => attributes
        unread_count = messageKeys.unread_count.rawValue => attributes
        
    }
    
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [MessageModel] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try MessageModel(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
    
}

