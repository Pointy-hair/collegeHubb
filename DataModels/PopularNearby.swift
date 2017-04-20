//
//  PopularNearby.swift
//  CollegeHub
//
//  Created by Sierra 4 on 08/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import Foundation
import SwiftyJSON

enum PopularNearbyKeys : String {
    
    //Common
    case tickets = "tickets"
    case items = "items"
    case carpool = "carpool"
    case books = "books"
    case services = "services"
    
}

class PopularNearbyModal: NSObject, JSONDecodable{
    var tickets = [TicketPostViewModel]()
    var items = [OtherPostViewModel]()
    var carpool = [RidePostViewModel]()
    var books = [BookPostViewModel]()
    var services = [ServicePostViewModel]()
    
    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        if  let carpoolTemp = PopularNearbyKeys.carpool.rawValue =| attributes {
            for dict in carpoolTemp {
                carpool.append(try RidePostViewModel(withAttributes: dict.dictionaryValue))
            }
        }
        if  let servicesTemp = PopularNearbyKeys.services.rawValue =| attributes {
            for dict in servicesTemp {
                services.append(try ServicePostViewModel(withAttributes: dict.dictionaryValue))
            }
        }
        if  let ticketsTemp = PopularNearbyKeys.tickets.rawValue =| attributes {
            for dict in ticketsTemp {
                tickets.append(try TicketPostViewModel(withAttributes: dict.dictionaryValue))
            }
        }
        if  let booksTemp = PopularNearbyKeys.books.rawValue =| attributes {
            for dict in booksTemp {
                books.append(try BookPostViewModel(withAttributes: dict.dictionaryValue))
            }
        }
        if  let itemsTemp = PopularNearbyKeys.items.rawValue =| attributes {
            for dict in itemsTemp {
                items.append(try OtherPostViewModel(withAttributes: dict.dictionaryValue))
            }
        }
    }
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        print("attributes\(attributes)")
        var arrayVendor : [PopularNearbyModal] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try PopularNearbyModal(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }

}
