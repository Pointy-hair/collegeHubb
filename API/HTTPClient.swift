//
//  APIClient.swift
//  Clikat
//
//  Created by cbl73 on 4/22/16.
//  Copyright © 2016 Gagan. All rights reserved.
//

import Foundation
import Alamofire

typealias HttpClientSuccess = (AnyObject?,DataResponse<Any>) -> ()
typealias HttpClientFailure = (String) -> ()

class HTTPClient {
    
    //MARK:- Post Request
    func postRequest(withApi api : api  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure )  {
        
        var header : AnyObject? = nil
        if api.header[FormatParameterKeys.authorization]  != "" {
            header = api.header as AnyObject?
        }
        
        print(api.url(),api.method,api.parameters ?? "",api.header)
        
        Alamofire.request(api.url(), method: api.method, parameters: api.parameters, encoding: JSONEncoding.default,headers: header == nil ? nil : api.header ).responseJSON { response in // 1
            print(response)
            switch response.result {
            case .success(let data):
                let statusCode = response.response?.statusCode
                print(statusCode ?? "")
                success(data as AnyObject?, response)
            case .failure(let error):
                let statusCode = response.response?.statusCode
                print(statusCode ?? "")
                failure(error.localizedDescription)
            }
        }
    }
    
    //MARK:- Post Multipart Single Images
    
    func postRequest(withApi api : api  ,image : UIImage? , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure )  {
        
        var header : AnyObject? = nil
        if api.header[FormatParameterKeys.authorization]  != "" {
            header = api.header as AnyObject?
        }
        
        print(api.url(),api.method,api.parameters ?? "",api.header)
        
        let URL = try! URLRequest(url: api.url(), method: api.method, headers: api.header)

        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let pic = image,let data = UIImageJPEGRepresentation(pic, 1.0){
                multipartFormData.append(data, withName:"image" , fileName:"image" , mimeType: "image/jpeg")
            }
            
            for (key, value) in api.parameters! {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, with: URL, encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    print(response.request ?? "")  // original URL request
                    print(response.response ?? "") // URL response
                    print(response.data ?? "")     // server data
                    print(response.result)   // result of response serialization
                    
                    switch response.result {
                    case .success(let data):
                        let statusCode = response.response?.statusCode
                        print(statusCode ?? "")
                        success(data as AnyObject?, response)
                    case .failure(let error):
                        let statusCode = response.response?.statusCode
                        print(statusCode ?? "")
                        failure(error.localizedDescription)
                    }
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                    
                    
                    
                }
                
            case .failure(let encodingError):

                print(encodingError)
            }
            
        })
    }
    
    //MARK:- Post Multipart Multiple Images
    
    func postRequest(withApi api : api  ,image : [UIImage?] , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure )  {
        
        var header : AnyObject? = nil
        if api.header[FormatParameterKeys.authorization]  != "" {
            header = api.header as AnyObject?
        }
        
        print(api.url(),api.method,api.parameters ?? "",api.header)
        
        let URL = try! URLRequest(url: api.url(), method: api.method, headers: api.header)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for img in image{
                if let pic = img,let data = UIImageJPEGRepresentation(pic, 1.0){
                    multipartFormData.append(data, withName:"image" , fileName:"image" , mimeType: "image/jpeg")
                    }
            }
            
            for (key, value) in api.parameters! {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, with: URL, encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    print(response.request ?? "")  // original URL request
                    print(response.response ?? "") // URL response
                    print(response.data ?? "")     // server data
                    print(response.result)   // result of response serialization
                    
                    switch response.result {
                    case .success(let data):
                        let statusCode = response.response?.statusCode
                        print(statusCode ?? "")
                        success(data as AnyObject?, response)
                    case .failure(let error):
                        let statusCode = response.response?.statusCode
                        print(statusCode ?? "")
                        failure(error.localizedDescription)
                    }
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                    
                    
                    
                }
                
            case .failure(let encodingError):
                
                print(encodingError)
            }
            
        })
    }

    //MARK:- Get Request

    func getRequest(withApi api : String?  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure )  {
        
        let fullPath = ¿api
        
        Alamofire.request(fullPath, method: .get, parameters: nil, encoding:URLEncoding.default  ,headers:  nil ).responseJSON { response in // 1
            switch response.result {
                
            case .success(let data):
                success(data as AnyObject?,response)
            case .failure(let error):
                failure(error.localizedDescription)
                
            }
        }
    }
}






