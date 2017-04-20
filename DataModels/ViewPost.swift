//
//  ViewPost.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import SwiftyJSON

enum PostViewKeys : String {
    
    //Common
    case posts_id = "posts_id"
    case users_id = "users_id"
    case firstname = "firstname"
    case lastname = "lastname"
    case image100 = "image100"
//    case image200 = "image200"
//    case image400 = "image400"
    case created_by = "created_by"
    case type = "type"
    case is_fixed = "is_fixed" //0 or 1
    case price = "price"
    case name = "name"
    case duration = "duration"
    case is_favourite = "is_favourite"
    case avg_rating = "avg_rating"

    //Ride
    //case is_card_added = "is_card_added"
    case departure = "departure"
    case destination = "destination"
    case departure_time = "departure_time"
    case leaving_on = "leaving_on"
    case stops = "stops"
//    case stop2 = "stop2"
//    case stop3 = "stop3"
    case num_of_seats = "num_of_seats"
    
    //Service
    case description = "description"
    case offer_1_time = "offer_1_time"
    case service_name = "service_name"
    
    //Item Common
    case condition_status = "condition_status"
    case remaining_duration = "remaining_duration"
    case highest_bid = "highest_bid"
    case is_bidded = "is_bidded"
    
    //Book
    //case condition = "condition"
    //Item images array
    case image = "image"
    case edition = "edition"
    case post_images_id = "post_images_id"
    
    //Ticket
    case date = "date"  //"date": "2016-01-24 00:00:00",
    case num_of_tickets = "num_of_tickets"
    case is_stu_section = "is_stu_section"
    case row_section = "row_section"
    //case row = "row"
    
    //Other
    case time_since = "time_since"
    case time = "time"
    case formatted_date = "formatted_date"
    case details = "details"
    
}

//MARK: - Book Model
class BookPostViewModel : NSObject, JSONDecodable{
    
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
    
    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
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
        image = (PostViewKeys.image.rawValue => attributes)?.parseJSONArrayString

    }
    
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [BookPostViewModel] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try BookPostViewModel(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
}

//MARK: - Ticket Model
class TicketPostViewModel : NSObject, JSONDecodable{
    var posts_id : String?
    var users_id : String?
    var firstname : String?
    var lastname : String?
    var image100 : String?
    var type : String?
    var name : String?
    var is_fixed : String?
    var price : String?
    var duration : String?
    var date: String?
    var num_of_tickets: String?
    var is_stu_section: String?
    var row_section: String?
    var is_favourite : String?
    var avg_rating : String?
    var created_by : String?
    
    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
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
        row_section = (PostViewKeys.row_section.rawValue => attributes)?.parseJSONString
        is_stu_section = PostViewKeys.is_stu_section.rawValue => attributes
        num_of_tickets = (PostViewKeys.num_of_tickets.rawValue => attributes)?.parseJSONString
        date = (PostViewKeys.date.rawValue => attributes)?.parseJSONString
        is_favourite = PostViewKeys.is_favourite.rawValue => attributes
        avg_rating = PostViewKeys.avg_rating.rawValue => attributes
        created_by = PostViewKeys.created_by.rawValue => attributes
    }
    
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [TicketPostViewModel] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try TicketPostViewModel(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
}

//MARK: - Other Model
class OtherPostViewModel : NSObject, JSONDecodable{
    var posts_id : String?
    var users_id : String?
    var firstname : String?
    var lastname : String?
    var image100 : String?
    var name : String?
    var type : String?
    var is_fixed : String?
    var duration : String?
    var condition_status : String?
    var price : String?
    var image : [String?]?
    var is_favourite : String?
    var avg_rating : String?
    var created_by : String?
    
    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        posts_id = PostViewKeys.posts_id.rawValue => attributes
        users_id = PostViewKeys.users_id.rawValue => attributes
        firstname = PostViewKeys.firstname.rawValue => attributes
        lastname = PostViewKeys.lastname.rawValue => attributes
        image100 = PostViewKeys.image100.rawValue => attributes
        name = (PostViewKeys.name.rawValue => attributes)?.parseJSONString
        is_fixed = PostViewKeys.is_fixed.rawValue => attributes
        duration = (PostViewKeys.duration.rawValue => attributes)?.parseJSONString
        price = (PostViewKeys.price.rawValue => attributes)?.parseJSONString
        condition_status = (PostViewKeys.condition_status.rawValue => attributes)?.parseJSONString
        is_favourite = PostViewKeys.is_favourite.rawValue => attributes
        avg_rating = PostViewKeys.avg_rating.rawValue => attributes
        type = PostViewKeys.type.rawValue => attributes
        created_by = PostViewKeys.created_by.rawValue => attributes
        image = (PostViewKeys.image.rawValue => attributes)?.parseJSONArrayString
    }
    
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [OtherPostViewModel] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try OtherPostViewModel(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
}

//MARK: - Ride Model
class RidePostViewModel : NSObject, JSONDecodable{
    
    var posts_id : String?
    var users_id : String?
    var type : String?
    var firstname : String?
    var lastname : String?
    var image100 : String?
    var departure : String?
    var destination : String?
    var price : String?
    var departure_time : String?
    var leaving_on : String?
    var stops : [String?]?
    var num_of_seats : String?
    var is_favourite : String?
    var avg_rating : String?
    var created_by : String?

    
    required init( withAttributes  attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        posts_id = PostViewKeys.posts_id.rawValue => attributes
        users_id = PostViewKeys.users_id.rawValue => attributes
        type = PostViewKeys.type.rawValue => attributes
        firstname = PostViewKeys.firstname.rawValue => attributes
        lastname = PostViewKeys.lastname.rawValue => attributes
        image100 = PostViewKeys.image100.rawValue => attributes
        departure = (PostViewKeys.departure.rawValue => attributes)?.parseJSONString
        destination = (PostViewKeys.destination.rawValue => attributes)?.parseJSONString
        price = (PostViewKeys.price.rawValue => attributes)?.parseJSONString
        departure_time = (PostViewKeys.departure_time.rawValue => attributes)?.parseJSONString
        leaving_on = (PostViewKeys.leaving_on.rawValue => attributes)?.parseJSONString
        num_of_seats = (PostViewKeys.num_of_seats.rawValue => attributes)?.parseJSONString
        is_favourite = PostViewKeys.is_favourite.rawValue => attributes
        avg_rating = PostViewKeys.avg_rating.rawValue => attributes
        created_by = PostViewKeys.created_by.rawValue => attributes
        stops = ((PostViewKeys.stops.rawValue => attributes)?.parseJSONArrayString)
        
        
    }
    
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [RidePostViewModel] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try RidePostViewModel(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
}

//MARK: - Service Model
class ServicePostViewModel : NSObject, JSONDecodable{
    
    var posts_id : String?
    var users_id : String?
    var firstname : String?
    var lastname : String?
    var image100 : String?
    var type : String?
    var duration : String?
    var price : String?
    var is_favourite : String?
    var avg_rating : String?
    var created_by : String?
    var Description : String?
    var offer_1_time : String?
    var service_name : String?
    //
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        
        posts_id = (PostViewKeys.posts_id.rawValue => attributes)
        users_id = (PostViewKeys.users_id.rawValue => attributes)
        firstname = (PostViewKeys.firstname.rawValue => attributes)
        lastname = (PostViewKeys.lastname.rawValue => attributes)
        image100 = PostViewKeys.image100.rawValue => attributes
        type = PostViewKeys.type.rawValue => attributes
        duration = (PostViewKeys.duration.rawValue => attributes)?.parseJSONString
        price = (PostViewKeys.price.rawValue => attributes)?.parseJSONString
        is_favourite = PostViewKeys.is_favourite.rawValue => attributes
        avg_rating = PostViewKeys.avg_rating.rawValue => attributes
        created_by = PostViewKeys.created_by.rawValue => attributes
        Description = (PostViewKeys.description.rawValue => attributes)?.parseJSONString
        service_name = (PostViewKeys.service_name.rawValue => attributes)?.parseJSONString
        offer_1_time = (PostViewKeys.offer_1_time.rawValue => attributes)?.parseJSONString
    }
    
    override init() {
        super.init()
    }
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var arrayVendor : [ServicePostViewModel] = []
        guard let arrayData = attributes else {return arrayVendor as AnyObject?}
        
        
        for dict in arrayData {
            do {
                let modal =  try ServicePostViewModel(withAttributes: dict.dictionaryValue )
                arrayVendor.append(modal)
            } catch _ {
            }
            
        }
        return arrayVendor as AnyObject?
    }
}

//MARK: - Image Model
class imageModal : NSObject{
    
    var image100 : String?
    var image200 : String?
    var image400 : String?
    var post_images_id : String?
    
    required init(withAttributes attributes: OptionalSwiftJSONParameters) throws {
        super.init()
        image100 = PostViewKeys.image100.rawValue => attributes
        post_images_id = PostViewKeys.post_images_id.rawValue => attributes
    }
    
    override init() {
        super.init()
    }
    
}


extension String {
    
        var parseJSONString: String? {
            let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
            guard let jsonData = data else { return nil }
            do {
                let obj =  try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let arr = obj as? [String], arr.count > 0{
                    return arr.first
                }
                else{return nil}
            }
            catch { return nil }
        }
    var parseJSONArrayString: [String?] {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        guard let jsonData = data else { return [] }
        do {
            let obj =  try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
            if let arr = obj as? [String], arr.count > 0{
                return arr
            }
            else{return []}
        }
        catch { return [] }
    }
    
        func toDateTime() -> String?
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let ourDate = dateFormatter.date(from: self) else { return nil}
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "EE , MMMM dd"
            let dateString = dateFormatter1.string(from:ourDate)
            return dateString

        }
    }

