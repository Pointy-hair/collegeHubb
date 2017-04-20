//
//  ManagingPaymentsViewController.swift
//  CollegeHub
//
//  Created by Sierra 4 on 22/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import Stripe


class ManagingPaymentsViewController: UIViewController{
    
//MARK::- VC VARIABLES
    var code : String = ""
    var isCode = ""
    
//MARK::- VC OUTLETS
    
    @IBOutlet var webView: UIWebView!{
        didSet{
            webView.delegate = self
        }
    }
//MARK::- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_AFvnodjTd6kCG0S2Jx9E4RlvuGLKwrja&scope=read_write")! as URL))

    }
//MARK::- BTN ACTIONS
    @IBAction func btnStopLoading(_ sender: Any) {
         webView.stopLoading()
    }
 
    @IBAction func btnManagePayments(_ sender: Any) {
//        webView.loadRequest(URLRequest(url: URL(string: "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_AFvnodjTd6kCG0S2Jx9E4RlvuGLKwrja&scope=read_write")! as URL))
        
    }
   
}
//MARK::- WEB VIEW DELEGATES
extension ManagingPaymentsViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let str = String(describing: request.url)
        
        isCode = String(describing:str.contains("code=") ? "true" : "false")
        
        if let range = str.range(of: "code=") {
            let endPos = str.characters.distance(from: str.characters.startIndex, to: range.upperBound)
            print(endPos)
            let startIndex = str.index(str.startIndex, offsetBy: endPos)
            let endIndex = str.index(str.endIndex, offsetBy: -1)
            let range = startIndex..<endIndex
            
        code = str.substring(with: range)
        //code = str.substring(from: startIndex)
            print("code is \(code)....")
        }
        print(request.url ?? "")
        return true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
         if(isCode == "true"){
        fetchUserAccountData(code: code)
        }
    }
}
//MARK::- API CALLS
extension ManagingPaymentsViewController {
    
    func fetchUserAccountData(code: String){
    
    APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.updateStripeAccId(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, code: code)), completion: { (response) in
    
        switch response{
        
        case .success(let data) :
        
            print(data ?? "")
            let x = data as? ManagePaymentModal
            UserDataSingleton.sharedInstance.loggedInUser = data as? User
            let alert = UIAlertController(title: "", message: x?.message, preferredStyle: .alert)
            alert.view.tintColor = appColor
            alert.view.backgroundColor = UIColor.white
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
               _ = self.navigationController?.popViewController(animated: true)  
            }))
        
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
             UtilityFunctions.showAlert(message: x?.message, controller: self)
            
        case .failureMessage(let message):
            
            print("failure")
            UtilityFunctions.showAlert(message: message, controller: self)
            
        default : break

            }
        })
    }
}
