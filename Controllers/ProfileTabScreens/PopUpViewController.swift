//
//  PopUpViewController.swift
//  CollegeHub
//
//  Created by Sierra 4 on 31/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import Stripe

protocol DelegateUpdatePayments {
    func updatePayments()
}

class PopUpViewController: UIViewController ,STPPaymentCardTextFieldDelegate{
    
//MARK::- OUTLET
    @IBOutlet var btnAddingCardOutlet: UIButton!
    @IBOutlet var txtStripeTextField: STPPaymentCardTextField!
    
//MARK::- VARIABLES
    var delegate: DelegateUpdatePayments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//MARK::- FUNCTION
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        btnAddingCardOutlet.isEnabled = textField.isValid
    }
  
//MARK:- Button Actions
    @IBAction func btnCancelAction(_ sender: Any) {

        (self.presentingViewController as? UINavigationController)?.topViewController?.dim(direction: .out)
        self.dismissVC(completion: nil)
        
    }
   
    @IBAction func btnAddingCardAction(_ sender: Any){

        let cardParams = txtStripeTextField.cardParams
        
        STPAPIClient.shared().createToken(withCard: cardParams) { token, error in
            guard let stripeToken = token else {
                print("Error creating token\(error!.localizedDescription)")
                return
            }
            
            let ourToken = String(describing: stripeToken)
            self.addCardToAccount(ourToken: ourToken)
    }
    }
}
//MARK::- API CALLS
extension PopUpViewController{
    
    func addCardToAccount(ourToken: String) {
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.addCard(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, card_token : ourToken)), completion: { [unowned self] (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                let message = data as? ManagePaymentModal
                let alert = UIAlertController(title: "", message:(message?.message ?? ""), preferredStyle: .alert)
                alert.view.tintColor = appColor
                alert.view.backgroundColor = UIColor.white
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
                    self.delegate?.updatePayments()
                    (self.presentingViewController as? UINavigationController)?.topViewController?.dim(direction: .out)
                    self.dismissVC(completion: nil)

                    }))
                
                
                self.present(alert, animated: true, completion: {
                })
                
                
            case .failureMessage(let message):
                print("failure")
                
                UtilityFunctions.showAlert(message: message, controller: self)
                

            default : break
            }
        })
        
    }
   
}
