//
//  APIConstants.swift
//  Clikat
//
//  Created by cbl73 on 4/22/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import Foundation

internal struct APIConstants {
    //Base Path
    static let basePath = "http://52.25.232.70/api/"
    
    //API Route List
    static let login = "users/login"
    static let socialAccountLogin = "users/socialAccountLogin"
    static let signup = "users/signup"
    static let sendEmailToEduId = "users/sendEmailToEduId"
    static let resendCode = "users/resendCode"
    static let verifyEduId = "users/verifyEduId"
    static let forgotPassword = "users/forgotPassword"
    static let logout = "users/logout"
    static let editProfile = "users/editProfile"
    
    //View ad type and content of cards
    static let viewRidePosts = "rideposts/view"
    static let viewServicePosts = "serviceposts/view"
    static let viewBookPosts = "bookposts/view"
    static let viewTicketPosts = "ticketposts/view"
    static let viewOtherPosts = "otherposts/view"
    static let viewPosts = "posts/view"
    static let viewPopular = "posts/viewPopular"
    
    
    //Get Questions and Create Api's
    static let getQuestions = "questions/view"
    
    //Chat Api's
    static let getConversationList = "chat/getConversationList"
    static let sendMessage = "chat/sendMessage"
    static let getConversation = "chat/getConversation"
    static let getPreviousMessages = "chat/getPreviousMessages"
    
    static let device_token_ios = "abcd"
    static let ios_version = "9.0"
    static let status = "statusCode"
    static let googleStatus = "status"
    static let message = "message"
    static let verification_code = "verification_code"
    static let customMessage = "customMessage"
    
    static let data = "data"
    static let user_details = "user_details"
    static let messages = "messages"
    static let matches = "matches"
    static let timezone = "Asia/Kolkata"
    //edited
    //Managing Stripe Accounts
    static let updateStripeAccId = "users/updateStripeAccId"
    static let addCard = "usercards/addCard"
    static let viewCards = "usercards/viewCards"
    static let makeCardDefault = "usercards/makeCardDefault"
    static let removeCard = "usercards/removeCard"
    static let all_cards = "all_cards"
    
    //notification
    static let notification = "notifications/view"
    
    //delete Post
    static let deletePost = "posts/delete"
    
    
//    static let viewCurrentListing = "posts/viewCurrentListing"
//    static let viewApprovePayments = "posts/viewApprovePayments"
//    static let viewFavourites = "favourites/viewPosts" 
    
    //favourites
    static let addToFavourite = "favourites/addPost"
    
    //profile tab
    static let viewProfileData = "users/viewProfileData"
    
    //view popular
    static let tickets = "tickets"
    static let services = "services"
    static let items = "items"
    static let carpool = "carpool"
    static let books = "books"
    //complete
}

internal struct FormatParameterKeys{
    
    //User Login Keys
    static let email = "email"
    static let password = "password"
    static let device_token_ios = "device_token_ios"
    static let ios_version = "ios_version"
    
    //User SignUp Keys
    static let firstname = "firstname"
    static let lastname = "lastname"
    static let gender = "gender" // 0 for male, 1 for female
    static let dob = "dob" // yyyy-mm-dd
    
    //User SocialAccount Login Keys
    static let account_type = "account_type" // 0 for fbLogin, 1 for googleLogin
    static let fb_id = "fb_id"
    static let google_id = "google_id"
    static let image = "image" // link e.g http://graph.facebook.com/8687657567687/picture?type=square
    
    //User sendEmailToEduId Keys
    static let edu_email = "edu_email"
    
    // User verifyEduId
    static let verification_code = "verification_code"
    
    //RideCard + ServiceCard + ItemsCard
    static let access_token = "access_token"
    static let type = "type"
    static let page = "page"
    static let search_key = "search_key"
    
    //Chat 
    static let timezone = "timezone"
    static let users_id2 = "users_id2"
    static let message = "message"
    static let last_message_id = "last_message_id" // e.g Asia/Kolkata
    static let facebookId = "facebookId"
    static let lang = "lang"
    static let deviceType = "deviceType"
    static let flushPreviousSessions = "flushPreviousSessions"
    static let appVersion = "appVersion"
    static let authorization = "authorization"
    static let fname = "fname"
    static let lname = "lname"
    static let currentLocation = "currentLocation"
    static let location = "location"
    static let facebookUserName = "facebookUserName"
    static let facebookName = "facebookName"
    static let facebookURL = "facebookURL"
    static let isBookmark = "isBookmark"
    static let businessID = "businessID"
    static let businessID2 = "businessId"
    static let bearer = "bearer "
    static let staticLat = "30.13"
    static let staticLng = "76.99"
    static let statusSuccess = "1"
    static let statusFailure = "0"
    static let staticPassword = "12345678"
    static let StaticTrue = "true"
    static let result = "result"
    static let geometry = "geometry"
    static let ok = "OK"
    static let lat = "lat"
    static let lng = "lng"
    static let predictions = "predictions"
    static let category = "category"
    static let searchText = "searchText"
    //edited
    //Managing Stripe Keys
    static let code = "code"
    static let card_id = "card_id"
    static let card_token = "card_token"
    
    //favourites
    static let posts_id = "posts_id"
    static let data_for = "data_for"
    //complete
}

//private struct


enum apiValidation : String {

    case none
    case success = "200"
    case failure = "400"
    case invalidAccessToken = "401"
    case serverError = "500"
    
//     case success = "1"
//     case ClientEndError = "0"
//     case invalidAccessToken = "2"
//     case failure = "400"
//     case serverError = "500"
    
    func mapResponseMessage(_ message : String?) -> String? {
        
        switch self {
        case .success, .failure, .invalidAccessToken ,.serverError:
            return message
        default:
            return nil
        }
    }
}

enum apiResponse {
    case success(AnyObject?)
    case failure(apiValidation)
    case failureMessage(String?)
}

typealias OptionalDictionary = [String : String]?

internal struct APIParameterConstants {
    
    struct userParam {
        
        static let login =
        [
            FormatParameterKeys.email,
            FormatParameterKeys.password,
            FormatParameterKeys.device_token_ios,
            FormatParameterKeys.ios_version
        ]
        
        static let socialAccountLogin =
        [
            FormatParameterKeys.account_type,
            FormatParameterKeys.fb_id,
            FormatParameterKeys.google_id,
            FormatParameterKeys.firstname,
            FormatParameterKeys.lastname,
            FormatParameterKeys.image,
            FormatParameterKeys.email,
            FormatParameterKeys.gender,
            FormatParameterKeys.dob,
            FormatParameterKeys.device_token_ios,
            FormatParameterKeys.ios_version
        ]
        
        static let signup =
        [
            FormatParameterKeys.email,
            FormatParameterKeys.password,
            FormatParameterKeys.firstname,
            FormatParameterKeys.lastname,
            FormatParameterKeys.gender,
            FormatParameterKeys.dob,
            FormatParameterKeys.device_token_ios,
            FormatParameterKeys.ios_version
        ]
        
        static let sendEmailToEduId =
        [
            FormatParameterKeys.access_token,
            FormatParameterKeys.edu_email
        ]
        
        static let resendCode =
        [
            FormatParameterKeys.access_token
        ]
        
        static let verifyEduId =
        [
            FormatParameterKeys.access_token,
            FormatParameterKeys.verification_code
        ]
        
        static let forgotPassword =
        [
            FormatParameterKeys.email
        ]
        
        static let logout =
        [
            FormatParameterKeys.access_token
        ]
        
        static let viewPosts =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.page,
                FormatParameterKeys.type,
                FormatParameterKeys.search_key
        ]
        static let viewPopular =
            [
                FormatParameterKeys.access_token
        ]
        
        static let ridePosts_View =
        [
            FormatParameterKeys.access_token,
            FormatParameterKeys.type,
            FormatParameterKeys.page
        ]
        
        static let servicePosts_View =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.type,
                FormatParameterKeys.page
        ]
        
        static let bookPosts_View =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.page
        ]
        
        static let ticketPosts_View =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.page
        ]
        
        static let othersPosts_View =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.page
        ]
        
        static let editProfile =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.firstname,
                FormatParameterKeys.lastname,
                FormatParameterKeys.gender,
                FormatParameterKeys.dob
        ]
        
        static let getConversationList =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.timezone
        ]
        
        static let sendMessage =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.timezone,
                FormatParameterKeys.users_id2,
                FormatParameterKeys.message,
                FormatParameterKeys.last_message_id
        ]
        
        static let getPreviousMessages =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.timezone,
                FormatParameterKeys.users_id2,
                FormatParameterKeys.last_message_id
        ]
        
        static let getConversation =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.timezone,
                FormatParameterKeys.users_id2,
                FormatParameterKeys.last_message_id
        ]
        
        //notification 
        static let notification =
        [
            FormatParameterKeys.access_token,
            FormatParameterKeys.timezone,
            FormatParameterKeys.page
        ]
        
        //edited
        static let updateStripeAccId =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.code
                
        ]
        static let addCard =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.card_token,
                
        ]
        static let viewCards =
            [
                FormatParameterKeys.access_token,
                
        ]
        static let makeCardDefault =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.card_id
                
        ]
        static let removeCard =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.card_id
                
        ]
        
        static let addToFavourite =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.posts_id
                
        ]
        static let deletePost =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.posts_id
                
        ]
//        static let viewApprovePayments =
//            [
//                FormatParameterKeys.access_token,
//                FormatParameterKeys.page
//        ]
        
//        static let viewFavourite =
//        [
//            FormatParameterKeys.access_token,
//            FormatParameterKeys.page
//        ]
//        static let viewCurrentListing =
//            [
//                FormatParameterKeys.access_token,
//                FormatParameterKeys.page
//        ]
        static let viewProfileData =
            [
                FormatParameterKeys.access_token,
                FormatParameterKeys.page,
                FormatParameterKeys.data_for
        ]
        //complete

    }

}




