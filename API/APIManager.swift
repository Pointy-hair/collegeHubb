//
//  APIManager.swift
//  Clikat
//
//  Created by cbl73 on 4/22/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import Foundation
import SwiftyJSON
import NVActivityIndicatorView

typealias APICompletion = (apiResponse) -> ()

class APIManager : NSObject,NVActivityIndicatorViewable  {
    
    
    static let sharedInstance = APIManager()
    fileprivate lazy var httpClient : HTTPClient = HTTPClient()
    var isTokenExpire = false
    var activityIndicatorView: NVActivityIndicatorView?
    
    func opertationWithRequest ( withApi api : api , completion : @escaping APICompletion )  {
        
//        if isLoaderNeeded(api) {
        let activityData = ActivityData(size: CGSize(width:50 , height: 50), message: "", messageFont:nil , type: .ballClipRotate, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//        }
        
        httpClient.postRequest(withApi: api, success: { (data,res) in
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
            let statusCode = res.response?.statusCode.toString
            
            guard let response = data else {
                completion(apiResponse.failure(.none))
                return
            }
            
            let json = JSON(response)
            
            //Previously Used
            print(json["success"].stringValue)
            let responseType = apiValidation(rawValue: statusCode!) ?? .failure
            
            if responseType == apiValidation.success {
                
                if(json["success"]).boolValue{
                    self.isTokenExpire = false
                    UserDefaults.standard.set("1", forKey: userPrefrences.successForLogin.rawValue)

                    let object : AnyObject?
                    object = api.handleParameters(json)
                    completion(apiResponse.success(object))
                    return
                }else if((json["success"]).stringValue == "3"){
                    //Case for Edu ID
                    UserDefaults.standard.set("3", forKey: userPrefrences.successForLogin.rawValue)
                    
                    let object : AnyObject?
                    object = api.handleParameters(json)
                    completion(apiResponse.success(object))
                    return
                }else{
                    print(json["message"])
                    UserDefaults.standard.set("0", forKey: userPrefrences.successForLogin.rawValue)

                    completion(apiResponse.failureMessage(json["message"].stringValue))
                    self.isTokenExpire = false
                }
            }
            else if responseType == apiValidation.failure || responseType == apiValidation.serverError{
                
                completion(apiResponse.failureMessage(json["message"].stringValue))
            }

            else if  responseType == apiValidation.invalidAccessToken {
                
                //invaild token
                 completion(apiResponse.failure(responseType))
                return
            }

        }, failure: { (message) in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            completion(apiResponse.failureMessage(message))
        })
        
    }
    
    func opertationWithRequest ( withApi api : api, image: UIImage? , completion : @escaping APICompletion )  {
        
        //        if isLoaderNeeded(api) {
        let activityData = ActivityData(size: CGSize(width:50 , height: 50), message: "", messageFont:nil , type: .ballClipRotate, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        //        }
        
        httpClient.postRequest(withApi: api, image: image, success: { (data,res) in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()

            let statusCode = res.response?.statusCode.toString
            guard let response = data else {
                completion(apiResponse.failure(.none))
                return
            }
            let json = JSON(response)
            
            //Previously Used
            
            let responseType = apiValidation(rawValue: statusCode!) ?? .failure
            
            if responseType == apiValidation.success {
                
                if(json["success"]).boolValue{
                    self.isTokenExpire = false
                    let object : AnyObject?
                    object = api.handleParameters(json)
                    completion(apiResponse.success(object))
                    return
                }else{
                    print(json["message"])
                    self.isTokenExpire = false
                    //                    return
                }
            }
        }, failure: { (message) in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            completion(apiResponse.failureMessage(message))
        })
        
    }
    
    
    func isLoaderNeeded(_ api : api) -> Bool{
        
        switch api.route {
        default:
            return true
        }
    }
    
}

