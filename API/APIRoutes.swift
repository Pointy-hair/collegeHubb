//
//  APIRoutes.swift
//  Glam360
//
//  Created by Night Reaper on 29/06/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import EZSwiftExtensions
import ObjectMapper


protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var parameters : OptionalDictionary { get }
    var method : Alamofire.HTTPMethod { get }
}

enum api {
    
    static func mapKeysAndValues(_ keys : [String]?,values : [String]?) -> [String : String]?{
        guard let tempValues = values,let tempKeys = keys else { return nil}
        var params = [String : String]()
        for (key,value) in zip(tempKeys,tempValues) {
            params[key] = ¿value
        }
        return params
    }
        
    enum userApiEnum{
        
        //User API's
        case login(email : String? , password : String?)
        case socialAccountLogin(account_type : String? , fb_id : String?,google_id:String? , firstname: String?, lastname: String?, image: String?, email: String?,gender: String? ,dob: String?)
        case signup(email : String? , password : String?, firstname: String?, lastname: String?,gender: String? ,dob: String?)
        case sendEmailToEduId(access_token: String?, edu_email: String?)
        case resendCode(access_token: String?)
        case verifyEduId(access_token: String?, verification_code: String?)
        case forgotPassword(email : String?)
        case logout(access_token: String?)
        case editProfile(access_token: String?,firstname: String?, lastname: String?,gender: String? ,dob: String?)

        //View Post API's
        case ridePosts_View(access_token: String?, page: String?, type : String?)
        case servicePosts_View(access_token: String?, page: String?, type : String?)
        case bookPosts_View(access_token: String?, page: String?)
        case ticketPosts_View(access_token: String?, page: String?)
        case otherPosts_View(access_token: String?, page: String?)
        case viewPosts(access_token: String?, page: String?, type : String?, search_key: String?)
        case viewPopular(access_token: String?)
        
        //Chat API's
        case getConversationList(access_token: String?, timezone: String?)
        case sendMessage(access_token: String?, timezone: String?, users_id2: String?, message: String?, last_message_id: String?)
        case getConversation(access_token: String?, timezone: String?, users_id2: String?, last_message_id: String?)
        case getPreviousMessages(access_token: String?, timezone: String?, users_id2: String?, last_message_id: String?)
        
        //edited
        //Managing Stripe
        case updateStripeAccId(access_token: String?, code: String?)
        case addCard(access_token: String?,card_token: String?)
        case viewCards(access_token: String?)
        case makeCardDefault(access_token: String?, card_id: String?)
        case removeCard(access_token: String?, card_id: String?)
        //view profile
        case viewProfileData(access_token: String?, page: String?,data_for: String?)
        //approve payments
       // case viewApprovePayments(access_token: String?, page: String?)
        
        //current Listing
       // case viewCurrentListing(access_token: String?, page: String?)
        
        //deletePost
        case deletePost(access_token: String?, posts_id: String?)
        
        //favourite
        case addToFavourite(access_token: String?, posts_id: String?)
        //case viewFavourites(access_token: String?, page: String?)
        
        //notification
        case notification(access_token: String?, timezone: String,page : String?)
        
        //complete
        
        func formatParameters() -> OptionalDictionary {
            
            switch self {
            
            //User API's
            case .login(let email , let password):
                    return api.mapKeysAndValues(APIParameterConstants.userParam.login , values: [¿email , ¿password,APIConstants.device_token_ios,APIConstants.ios_version])
                
            case .socialAccountLogin(let account_type , let fb_id ,let google_id, let firstname, let lastname , let image, let email , let gender, let dob):
                return api.mapKeysAndValues(APIParameterConstants.userParam.socialAccountLogin , values: [¿account_type , ¿fb_id , ¿google_id , ¿firstname,¿lastname , ¿image,¿email, ¿gender , ¿dob,APIConstants.device_token_ios,APIConstants.ios_version])
                
            case .signup(let email, let password, let firstname,let lastname,let gender,let dob):
                return api.mapKeysAndValues(APIParameterConstants.userParam.signup, values: [ ¿email, ¿password, ¿firstname,¿lastname, ¿gender , ¿dob,APIConstants.device_token_ios,APIConstants.ios_version])
                
            case .sendEmailToEduId(let accesse_token, let edu_email):
                return api.mapKeysAndValues(APIParameterConstants.userParam.sendEmailToEduId, values: [¿accesse_token , ¿edu_email])
                
            case .resendCode(let access_token):
                return api.mapKeysAndValues(APIParameterConstants.userParam.resendCode, values: [¿access_token])
                
            case .verifyEduId(let access_token,let  verification_code):
                return api.mapKeysAndValues(APIParameterConstants.userParam.verifyEduId, values: [¿access_token, ¿verification_code])
                
            case .forgotPassword(let email):
                return api.mapKeysAndValues(APIParameterConstants.userParam.forgotPassword, values: [¿email])
                
            case .logout(let access_token):
                return api.mapKeysAndValues(APIParameterConstants.userParam.logout, values: [¿access_token])
                
            case .editProfile(let access_token, let firstname, let lastname,let gender ,let dob):
                return api.mapKeysAndValues(APIParameterConstants.userParam.editProfile, values: [¿access_token, ¿firstname,¿lastname, ¿gender , ¿dob])

                
            //View Post API's
            case .ridePosts_View(let accesse_token, let page, let type):
                return api.mapKeysAndValues(APIParameterConstants.userParam.ridePosts_View, values: [¿accesse_token , ¿page , ¿type])
                
            case .servicePosts_View(let accesse_token, let page, let type):
                return api.mapKeysAndValues(APIParameterConstants.userParam.servicePosts_View, values: [¿accesse_token , ¿page , ¿type])
                
            case .bookPosts_View(let accesse_token, let page):
                return api.mapKeysAndValues(APIParameterConstants.userParam.bookPosts_View, values: [¿accesse_token , ¿page])
                
            case .ticketPosts_View(let accesse_token, let page):
                return api.mapKeysAndValues(APIParameterConstants.userParam.ticketPosts_View, values: [¿accesse_token , ¿page])
                
            case .otherPosts_View(let accesse_token, let page):
                return api.mapKeysAndValues(APIParameterConstants.userParam.othersPosts_View, values: [¿accesse_token , ¿page])
                
            case .viewPosts(let access_token, let page, let type, let search_key):
                return api.mapKeysAndValues(APIParameterConstants.userParam.viewPosts, values: [¿access_token, ¿page , ¿type, ¿search_key])
            //view popular
            case .viewPopular(let access_token):
                return api.mapKeysAndValues(APIParameterConstants.userParam.viewPopular, values: [¿access_token])
                
            //Chat API's
            case .getConversationList(let accesse_token, let timezone):
                return api.mapKeysAndValues(APIParameterConstants.userParam.getConversationList, values: [¿accesse_token , ¿timezone])
                
            case .sendMessage(let accesse_token, let timezone, let users_id2, let message, let last_message_id):
                return api.mapKeysAndValues(APIParameterConstants.userParam.sendMessage, values: [¿accesse_token , ¿timezone, ¿users_id2 , ¿message, ¿last_message_id])
                
            case .getConversation(let accesse_token, let timezone, let users_id2, let last_message_id):
                return api.mapKeysAndValues(APIParameterConstants.userParam.getConversation, values: [¿accesse_token , ¿timezone, ¿users_id2, ¿last_message_id])
                
            case .getPreviousMessages(let accesse_token, let timezone, let users_id2, let last_message_id):
                return api.mapKeysAndValues(APIParameterConstants.userParam.getPreviousMessages, values: [¿accesse_token , ¿timezone, ¿users_id2, ¿last_message_id])
                
            //edited
            //Managing Stripe Account
            case .updateStripeAccId(let access_token ,let code):
                return api.mapKeysAndValues(APIParameterConstants.userParam.updateStripeAccId, values: [¿access_token,¿code])
            case .addCard(let access_token, let card_token):
                return api.mapKeysAndValues(APIParameterConstants.userParam.addCard, values: [¿access_token,¿card_token])
            case .viewCards(let access_token):
                return api.mapKeysAndValues(APIParameterConstants.userParam.viewCards, values: [¿access_token])
            case .makeCardDefault(let access_token,let  card_id):
                return api.mapKeysAndValues(APIParameterConstants.userParam.makeCardDefault, values: [¿access_token,¿card_id])
            case .removeCard(let access_token,let  card_id):
                return api.mapKeysAndValues(APIParameterConstants.userParam.removeCard, values: [¿access_token,¿card_id])
             //view profile
            case .viewProfileData(let access_token, let page,let data_for):
                return api.mapKeysAndValues(APIParameterConstants.userParam.viewProfileData, values: [¿access_token , ¿page,¿data_for])
            //currentListing
           // case .viewCurrentListing(let access_token, let page):
                //return api.mapKeysAndValues(APIParameterConstants.userParam.viewCurrentListing, values: [¿access_token , ¿page])
        
            //delete post
            case .deletePost(let access_token,let  posts_id):
                return api.mapKeysAndValues(APIParameterConstants.userParam.addToFavourite, values: [¿access_token,¿posts_id])
            //approve payments
           // case .viewApprovePayments(let access_token, let page):
               // return api.mapKeysAndValues(APIParameterConstants.userParam.viewApprovePayments, values: [¿access_token , ¿page])
                
            //favourite
            case .addToFavourite(let access_token,let  posts_id):
                return api.mapKeysAndValues(APIParameterConstants.userParam.addToFavourite, values: [¿access_token,¿posts_id])
           // case .viewFavourites(let access_token, let page):
                //return api.mapKeysAndValues(APIParameterConstants.userParam.viewFavourite, values: [¿access_token , ¿page])
            //notification
            case .notification(let access_token, let timezone,let page):
                return api.mapKeysAndValues(APIParameterConstants.userParam.notification, values: [¿access_token,¿timezone,¿page])            //complete
            }
        }
    }
    
    case userApi(ApiEnum : userApiEnum)
    
    func handleParameters(_ parameters : JSON?) -> AnyObject? {
        
        let user_details = parameters?[APIConstants.user_details].dictionaryValue
        
        switch self {
        case .userApi(let value):
            switch value {
                
            //User API's
            case .login(_),.socialAccountLogin(_),.signup(_),.editProfile(_) :
                
                do {
                    return  try User(withAttributes:user_details)
                } catch _ {
                    return nil
                }
                
            case .forgotPassword(_),.verifyEduId(_),.logout(_),.resendCode(_),.sendEmailToEduId(_):
               return parameters?[APIConstants.message] as AnyObject?
                
            
                
                //View Posts
            case .viewPosts(_, _, let type, _):

                switch (type?.toInt())! {
                case 1:
                    return RidePostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
                case 3:
                    return ServicePostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
                case 5:
                    return BookPostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
                case 6:
                    return TicketPostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
                case 7:
                    return OtherPostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
                default:
                    return nil
                }
           //view Popular
            case .viewPopular(_):
                do {
                    return  try PopularNearbyModal(withAttributes:parameters?.dictionaryValue)
                } catch _ {
                    return nil
                }
            //View Rides
            case .ridePosts_View(_):
                return RidePostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
            //View Services
            case .servicePosts_View(_):
                return ServicePostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
            //View Items
            case .bookPosts_View(_):
                return BookPostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
            case .ticketPosts_View(_):
                return TicketPostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
            case .otherPosts_View(_):
                return OtherPostViewModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
            
            //Chat
            case .getConversationList(_):
                let dictionary = [APIConstants.messages: MessageModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.messages].arrayValue), APIConstants.matches: MessageModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.matches].arrayValue)]
                return dictionary as AnyObject?
                
            case .getConversation(_),.getPreviousMessages(_):
                return MessageModel.parseArrayinToModal(withAttributes: parameters?[APIConstants.messages].arrayValue)
                
            case .sendMessage(_):
                do {
                    return  try MessageModel(withAttributes:parameters?[APIConstants.messages].dictionaryValue)
                } catch _ {
                    return nil
                }
            
            case .notification(_):
                return  NotificationModal.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
                
            //edited
            //Managing Stripe//attention required
//            case .updateStripeAccId(_):
//                do {
//                    return  try CreateStripeAccountModal(withAttributes:parameters?.dictionaryValue)
//                } catch _ {
//                    return nil
//                }
            case .addCard(_),.removeCard(_),.makeCardDefault(_),.updateStripeAccId(_):
                do {
                    return  try ManagePaymentModal(withAttributes:parameters?.dictionaryValue)
                } catch _ {
                    return nil
                }
            case .viewCards(_):
                let dictionary = [APIConstants.all_cards:ViewAllCardModal.parseArrayinToModal(withAttributes: parameters?[APIConstants.all_cards].arrayValue)]
                return dictionary as AnyObject?
                //deletePost
            case .deletePost(_):
                do {
                    return  try ManagePaymentModal(withAttributes:parameters?.dictionaryValue)
                } catch _ {
                    return nil
                }
                
                
                //add to favourite
            case .addToFavourite(_):
                do {
                    return  try ManagePaymentModal(withAttributes:parameters?.dictionaryValue)
                } catch _ {
                    return nil
                }
            case .viewProfileData(_):
                return ProfileTabSubMenus.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
//            //favourite/view
//            case .viewFavourites(_):
//                return ProfileTabSubMenus.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
//            //currentListingView
//            case .viewCurrentListing(_):
//                return ProfileTabSubMenus.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
//            //approve payments
//            case .viewApprovePayments(_):
//                return ProfileTabSubMenus.parseArrayinToModal(withAttributes: parameters?[APIConstants.data].arrayValue)
            }
        }
    }
}

extension api : Router {
    
    var route : String  {
        
        switch self {
            
        case .userApi(let value):
            switch value {
                
            //User
            case .login(_): return APIConstants.login
            case .socialAccountLogin(_): return APIConstants.socialAccountLogin
            case .signup(_): return APIConstants.signup
            case .forgotPassword(_): return APIConstants.forgotPassword
            case .verifyEduId(_): return APIConstants.verifyEduId
            case .logout(_): return APIConstants.logout
            case .resendCode(_): return APIConstants.resendCode
            case .sendEmailToEduId(_): return APIConstants.sendEmailToEduId
            case .editProfile(_): return APIConstants.editProfile
                
            //View Posts
            case .ridePosts_View(_) : return APIConstants.viewRidePosts
            case .servicePosts_View(_) : return APIConstants.viewServicePosts
            case .bookPosts_View(_) : return APIConstants.viewBookPosts
            case .ticketPosts_View(_) : return APIConstants.viewTicketPosts
            case .otherPosts_View(_) : return APIConstants.viewOtherPosts
            case .viewPosts(_): return APIConstants.viewPosts
            case .viewPopular(_): return APIConstants.viewPopular
                
            //Chat
            case .getConversationList(_) : return APIConstants.getConversationList
            case .getConversation(_) : return APIConstants.getConversation
            case .getPreviousMessages(_) : return APIConstants.getPreviousMessages
            case .sendMessage(_) : return APIConstants.sendMessage
            
            //edited
            //Managing Stripe
            case .updateStripeAccId(_) : return APIConstants.updateStripeAccId
            case .addCard(_) : return APIConstants.addCard
            case .viewCards(_) : return APIConstants.viewCards
            case .makeCardDefault(_) : return APIConstants.makeCardDefault
            case .removeCard(_) : return APIConstants.removeCard
            case .viewProfileData(_): return APIConstants.viewProfileData
            //current Listing
           // case .viewCurrentListing(_): return APIConstants.viewCurrentListing
            //approve payments
            //case .viewApprovePayments(_): return APIConstants.viewApprovePayments
            //delete post
            case .deletePost(_) : return APIConstants.deletePost
                
            //favourite
            case .addToFavourite(_) : return APIConstants.addToFavourite
            //case .viewFavourites(_): return APIConstants.viewFavourites
            //notification
            case .notification(_) : return APIConstants.notification
            //complete
            }
        }
        
        
    }
    
    var header : [String:String]  {
        
        switch self {
            
        case .userApi(let value):
            switch value {
                
//            case .updateUserInfo(_),.addBookmark(_) : return [ FormatParameterKeys.authorization:FormatParameterKeys.bearer + ¿UserDataSingleton.sharedInstance.loggedInUser?.accessToken]
                
            default : return [FormatParameterKeys.authorization:""]
                
            }
        }
    }
    
    var parameters: OptionalDictionary{
        switch self {
        case .userApi(let value): return value.formatParameters()
            
        }
    }
    
    var method : Alamofire.HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    
    
    var baseURL: String{
        return APIConstants.basePath
    }
    
    
    func url() -> String {
        return baseURL + route
    }
}

