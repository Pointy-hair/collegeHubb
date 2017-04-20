//
//  ProfileTabSubMenus.swift
//  CollegeHub
//
//  Created by Sierra 4 on 11/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import EZSwiftExtensions


class ProfileTabSubMenus : NSObject,JSONDecodable {
    
    var time_since : String?
    var details = [ProfileTabSubMenus]()
    var posts_id : String?
    var users_id : String?
    var firstname : String?
    var lastname : String?
    var image100 : String?
    var type : String?
    var name : String?
    var is_fixed : String?
    var duration : String?
    var condition_status : String?
    var price : String?
    var image : [String?]?
    var is_favourite : String?
    var avg_rating : String?
    var edition : String?
    var created_by : String?
    var date: String?
    var num_of_tickets: String?
    var is_stu_section: String?
    var row_section: String?
    var departure : String?
    var destination : String?
    var departure_time : String?
    var leaving_on : String?
    var stops : [String?]?
    var num_of_seats : String?
    var Description : String?
    var offer_1_time : String?
    var service_name : String?
    var time : String?
    var formatted_date : String?
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        time_since = (PostViewKeys.time_since.rawValue => attributes)
        formatted_date = (PostViewKeys.formatted_date.rawValue => attributes)
        time = (PostViewKeys.time.rawValue => attributes)
        posts_id = PostViewKeys.posts_id.rawValue => attributes
        users_id = PostViewKeys.users_id.rawValue => attributes
        firstname = PostViewKeys.firstname.rawValue => attributes
        lastname = PostViewKeys.lastname.rawValue => attributes
        image100 = PostViewKeys.image100.rawValue => attributes
        type = PostViewKeys.type.rawValue => attributes
        name = (PostViewKeys.name.rawValue => attributes)?.parseJSONString
        is_fixed = PostViewKeys.is_fixed.rawValue => attributes
        duration = (PostViewKeys.duration.rawValue => attributes)?.parseJSONString
        price = (PostViewKeys.price.rawValue => attributes)?.parseJSONString
        condition_status = (PostViewKeys.condition_status.rawValue => attributes)?.parseJSONString
        is_favourite = PostViewKeys.is_favourite.rawValue => attributes
        avg_rating = PostViewKeys.avg_rating.rawValue => attributes
        edition = (PostViewKeys.edition.rawValue => attributes)?.parseJSONString
        created_by = PostViewKeys.created_by.rawValue => attributes
        row_section = (PostViewKeys.row_section.rawValue => attributes)?.parseJSONString
        is_stu_section = PostViewKeys.is_stu_section.rawValue => attributes
        num_of_tickets = (PostViewKeys.num_of_tickets.rawValue => attributes)?.parseJSONString
        date = (PostViewKeys.date.rawValue => attributes)?.parseJSONString
        departure = (PostViewKeys.departure.rawValue => attributes)?.parseJSONString
        destination = (PostViewKeys.destination.rawValue => attributes)?.parseJSONString
        departure_time = (PostViewKeys.departure_time.rawValue => attributes)?.parseJSONString
        leaving_on = (PostViewKeys.leaving_on.rawValue => attributes)?.parseJSONString
        num_of_seats = (PostViewKeys.num_of_seats.rawValue => attributes)?.parseJSONString
        Description = (PostViewKeys.description.rawValue => attributes)?.parseJSONString
        service_name = (PostViewKeys.service_name.rawValue => attributes)?.parseJSONString
        offer_1_time = (PostViewKeys.offer_1_time.rawValue => attributes)?.parseJSONString
        image = ((PostViewKeys.image.rawValue => attributes)?.parseJSONArrayString)
        stops = ((PostViewKeys.stops.rawValue => attributes)?.parseJSONArrayString)

        if  let detailsTemp = PostViewKeys.details.rawValue =| attributes {
            for dict in detailsTemp {
                details.append(try ProfileTabSubMenus(withAttributes: dict.dictionaryValue))
            }
        }
        
    }
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [ProfileTabSubMenus] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try ProfileTabSubMenus(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
    
}
