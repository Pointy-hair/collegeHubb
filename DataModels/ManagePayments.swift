//
//  ManagePayments.swift
//  CollegeHub
//
//  Created by Sierra 4 on 30/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import EZSwiftExtensions

enum ManagePaymentsKeys : String {
    
    case success = "success"
    case message = "message"
    case is_default = "is_default"
    case last4 = "last4"
    case brand = "brand"
    case card_id = "card_id"
    case all_cards = "all_cards"
    
}


class ManagePaymentModal : NSObject, JSONDecodable{
    var success : String?
    var message : String?
    
    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        success = ManagePaymentsKeys.success.rawValue => attributes
        message = ManagePaymentsKeys.message.rawValue => attributes
    }
        override init() {
            super.init()
        }
        
        class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
            
            var arrayCardMessage : [ManagePaymentModal] = []
            guard let arrayData = attributes else {return arrayCardMessage as AnyObject?}
            
            
            for dict in arrayData {
                do {
                    let modal =  try ManagePaymentModal(withAttributes: dict.dictionaryValue )
                    arrayCardMessage.append(modal)
                } catch _ {
                }
                
            }
            return arrayCardMessage as AnyObject?
        }
}


//class CreateStripeAccountModal : NSObject, JSONDecodable{
//    var success : String?
//    var message : String?
//    
//    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
//        super.init()
//        
//        success = ManagePaymentsKeys.success.rawValue => attributes
//        message = ManagePaymentsKeys.message.rawValue => attributes
//    }
//    override init() {
//        super.init()
//    }
//    
//    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
//        
//        var arrayCardMessage : [CreateStripeAccountModal] = []
//        guard let arrayData = attributes else {return arrayCardMessage as AnyObject?}
//        
//        
//        for dict in arrayData {
//            do {
//                let modal =  try CreateStripeAccountModal(withAttributes: dict.dictionaryValue )
//                arrayCardMessage.append(modal)
//            } catch _ {
//            }
//            
//        }
//        return arrayCardMessage as AnyObject?
//    }
//}

class ViewAllCardModal: NSObject, JSONDecodable{
    var is_default: String?
    var last4: String?
    var brand: String?
    var card_id: String?
    
    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
         is_default = ManagePaymentsKeys.is_default.rawValue => attributes
         last4 = ManagePaymentsKeys.last4.rawValue => attributes
         brand = ManagePaymentsKeys.brand.rawValue => attributes
         card_id = ManagePaymentsKeys.card_id.rawValue => attributes
    }
    override init() {
        super.init()
    }
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayCardDetails : [ViewAllCardModal] = []
        guard let arrayData = attributes else {return arrayCardDetails as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try ViewAllCardModal(withAttributes: dict.dictionaryValue )
                arrayCardDetails.append(modal)
            } catch _ {
            }
            
        }
        print("arrayCardDetails\(arrayCardDetails)")
        return arrayCardDetails as AnyObject?
    }

    
}
//class RemoveCardsModal : NSObject, JSONDecodable{
//    var success : String?
//    var message : String?
//    
//    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
//        super.init()
//        
//        success = ManagePaymentsKeys.success.rawValue => attributes
//        message = ManagePaymentsKeys.message.rawValue => attributes
//    }
//    override init() {
//        super.init()
//    }
//    
//    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
//        
//        var arrayCardMessage : [RemoveCardsModal] = []
//        guard let arrayData = attributes else {return arrayCardMessage as AnyObject?}
//        
//        
//        for dict in arrayData {
//            do {
//                let modal =  try RemoveCardsModal(withAttributes: dict.dictionaryValue )
//                arrayCardMessage.append(modal)
//            } catch _ {
//            }
//            
//        }
//        return arrayCardMessage as AnyObject?
//    }
//}
//class MakeCardDefaultModal : NSObject, JSONDecodable{
//    var success : String?
//    var message : String?
//    
//    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
//        super.init()
//        
//        success = ManagePaymentsKeys.success.rawValue => attributes
//        message = ManagePaymentsKeys.message.rawValue => attributes
//    }
//    override init() {
//        super.init()
//    }
//    
//    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
//        
//        var arrayCardMessage : [MakeCardDefaultModal] = []
//        guard let arrayData = attributes else {return arrayCardMessage as AnyObject?}
//        
//        
//        for dict in arrayData {
//            do {
//                let modal =  try MakeCardDefaultModal(withAttributes: dict.dictionaryValue )
//                arrayCardMessage.append(modal)
//            } catch _ {
//            }
//            
//        }
//        return arrayCardMessage as AnyObject?
//    }
//}
//



