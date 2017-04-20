//
//  Constants.swift
//  CollegeHub
//
//  Created by Sumanpreet on 30/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import Foundation

var btnRadius: CGFloat = 30
let appColor: UIColor = UIColor.init(colorLiteralRed: 0/255, green: 218/255, blue: 194/255, alpha: 1)
let placeHolderImage = UIImage(named: "ic_profile_placeholder")

enum userPrefrences : String{
    case UserProfile = "UserProfile"
    case LookingForRidePostViewData = "LookingForRidePostViewData"
    case LookingForPassengerPostViewData = "LookingForPassengerPostViewData"
    case LookingForServicePostViewData = "LookingForServicePostViewData"
    case OfferAServicePostViewData = "OfferAServicePostViewData"
    case BooksPostViewData = "BooksPostViewData"
    case OthersPostViewData = "OthersPostViewData"
    case TicketsPostViewData = "TicketsPostViewData"
    case currentTabForItem = "currentTabForItem"
    case currentTabForRide = "currentTabForRide"
    case currentTabForService = "currentTabForService"
    case successForLogin = "successForLogin"
}

enum itemSubCategory: String{
    case books = "Books"
    case tickets = "Tickets"
    case others = "Others"
}

enum rideSubCategory: String{
    case lookForRide = "Ride Mode"
    case lookForPassenger = "Driver Mode"
}

enum serviceSubCategory: String{
    case lookForService = "Boss Mode"
    case offerAService = "Freelance Mode"
}

enum pageName: String{
    case item = "Items"
    case ride = "Rides"
    case service = "Services"
}
enum IdentifierTableCell:String {
//profile tab's table cell
    //current listing
    case currentListingTripCell = "CurrentListingTripCell"
    case currentListingBookCell = "CurrentListingBookCell"
    //past order
    case pastOrderTripCell = "PastOrderTripCell"
    case pastOrderItemCell = "PastOrderItemCell"
    //manage payment
    case managePaymentSavedCards = "ManagePaymentSavedCards"
    //approve payment
    case approvePaymentTripCell = "ApprovePaymentTripCell"
    case approvePaymentBookCell = "ApprovePaymentBookCell"
    //bidding
    case biddingCell = "BiddingCell"
    //favourite
    case favouriteBooksCell = "FavouriteBooksCell"
    case favouriteServiceCell = "FavouriteServiceCell"
    case favouriteCarpoolCell = "FavouriteCarpoolCell"
    case favouriteTicketsCell = "FavouriteTicketCell"
    //home screen
    case sellAItemCell = "SellAItemCell"
    case sellABookCell = "SellABookCell"
    case sellATicketCell = "SellATicketCell"
    case offerARideCell = "OfferARideCell"
    case offerAServiceCell = "OfferAServiceCell"
    //popular nearby
    case carpoolPopularNearbyCell = "CarpoolPopularNearbyCell"
    case servicePopularNearbyCell = "ServicePopularNearbyCell"
    case ticketsPopularNearbyCell = "TicketsPopularNearbyCell"
    case booksPopularNearbyCell = "BooksPopularNearbyCell"
    case itemsPopularNearbyCell = "ItemsPopularNearbyCell"
   
}
enum IdentifierViewController : String {
    case mmx = ""
}
