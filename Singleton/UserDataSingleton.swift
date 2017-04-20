//
//  SDataSingleton.swift
//  Glam360
//
//  Created by cbl16 on 7/5/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import UIKit
import RMMapper

class UserDataSingleton {
        
    static let sharedInstance : UserDataSingleton = {
        let instance = UserDataSingleton()
        return instance
    }()

    init() {
        
    }
    
    //user data
    
    var loggedInUser : User?{
            get{
                var user : User?
                if let data = UserDefaults.standard.rm_customObject(forKey: userPrefrences.UserProfile.rawValue) as? User{
                    user = data
                }
                return user
            }
            set{
                let defaults = UserDefaults.standard
                if let value = newValue{
                    defaults.rm_setCustomObject(value, forKey: userPrefrences.UserProfile.rawValue)
                }
                else{
                    defaults.removeObject(forKey: userPrefrences.UserProfile.rawValue)
                }
            }
    }
    
    var rideDataLookingForRide : [RidePostViewModel]?{
        get{
            var rideDataLookingForRide : [RidePostViewModel]?
            if let data = UserDefaults.standard.rm_customObject(forKey: userPrefrences.LookingForRidePostViewData.rawValue) as? [RidePostViewModel]{
                rideDataLookingForRide = data
            }
            return rideDataLookingForRide
        }
        set{
            let defaults = UserDefaults.standard
            if let value = newValue{
                defaults.rm_setCustomObject(value, forKey: userPrefrences.LookingForRidePostViewData.rawValue)
            }
            else{
                defaults.removeObject(forKey: userPrefrences.LookingForRidePostViewData.rawValue)
            }
        }
    }
    
    
    
    var rideDataLookingForPassenger : [RidePostViewModel]?{
        get{
            var rideDataLookingForPassenger : [RidePostViewModel]?
            if let data = UserDefaults.standard.rm_customObject(forKey: userPrefrences.LookingForPassengerPostViewData.rawValue) as? [RidePostViewModel]{
                rideDataLookingForPassenger = data
            }
            return rideDataLookingForPassenger
        }
        set{
            let defaults = UserDefaults.standard
            if let value = newValue{
                defaults.rm_setCustomObject(value, forKey: userPrefrences.LookingForPassengerPostViewData.rawValue)
            }
            else{
                defaults.removeObject(forKey: userPrefrences.LookingForPassengerPostViewData.rawValue)
            }
        }
    }
    
    var serviceDataLookforService : [ServicePostViewModel]?{
        get{
            var serviceDataLookforService : [ServicePostViewModel]?
            if let data = UserDefaults.standard.rm_customObject(forKey: userPrefrences.LookingForServicePostViewData.rawValue) as? [ServicePostViewModel]{
                serviceDataLookforService = data
            }
            return serviceDataLookforService
        }
        set{
            let defaults = UserDefaults.standard
            if let value = newValue{
                defaults.rm_setCustomObject(value, forKey: userPrefrences.LookingForServicePostViewData.rawValue)
            }
            else{
                defaults.removeObject(forKey: userPrefrences.LookingForServicePostViewData.rawValue)
            }
        }
    }
    
    var serviceDataOfferAService : [ServicePostViewModel]?{
        get{
            var serviceDataOfferAService : [ServicePostViewModel]?
            if let data = UserDefaults.standard.rm_customObject(forKey: userPrefrences.OfferAServicePostViewData.rawValue) as? [ServicePostViewModel]{
                serviceDataOfferAService = data
            }
            return serviceDataOfferAService
        }
        set{
            let defaults = UserDefaults.standard
            if let value = newValue{
                defaults.rm_setCustomObject(value, forKey: userPrefrences.OfferAServicePostViewData.rawValue)
            }
            else{
                defaults.removeObject(forKey: userPrefrences.OfferAServicePostViewData.rawValue)
            }
        }
    }
    
    var booksData : [BookPostViewModel]?{
        get{
            var booksData : [BookPostViewModel]?
            if let data = UserDefaults.standard.rm_customObject(forKey: userPrefrences.BooksPostViewData.rawValue) as? [BookPostViewModel]{
                booksData = data
            }
            return booksData
        }
        set{
            let defaults = UserDefaults.standard
            if let value = newValue{
                defaults.rm_setCustomObject(value, forKey: userPrefrences.BooksPostViewData.rawValue)
            }
            else{
                defaults.removeObject(forKey: userPrefrences.BooksPostViewData.rawValue)
            }
        }
    }
    
    var ticketsData : [TicketPostViewModel]?{
        get{
            var ticketsData : [TicketPostViewModel]?
            if let data = UserDefaults.standard.rm_customObject(forKey: userPrefrences.TicketsPostViewData.rawValue) as? [TicketPostViewModel]{
                ticketsData = data
            }
            return ticketsData
        }
        set{
            let defaults = UserDefaults.standard
            if let value = newValue{
                defaults.rm_setCustomObject(value, forKey: userPrefrences.TicketsPostViewData.rawValue)
            }
            else{
                defaults.removeObject(forKey: userPrefrences.TicketsPostViewData.rawValue)
            }
        }
    }
    
    var othersData : [OtherPostViewModel]?{
        get{
            var othersData : [OtherPostViewModel]?
            if let data = UserDefaults.standard.rm_customObject(forKey: userPrefrences.OthersPostViewData.rawValue) as? [OtherPostViewModel]{
                othersData = data
            }
            return othersData
        }
        set{
            let defaults = UserDefaults.standard
            if let value = newValue{
                defaults.rm_setCustomObject(value, forKey: userPrefrences.OthersPostViewData.rawValue)
            }
            else{
                defaults.removeObject(forKey: userPrefrences.OthersPostViewData.rawValue)
            }
        }
    }
    

}

