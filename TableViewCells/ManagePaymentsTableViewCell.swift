//
//  ManagePaymentsTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 27/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class ManagePaymentsTableViewCell: UITableViewCell {
    
//MARK::- VARIABLES
    var card_id = ""
    var myTableViewController: ManagePaymentsViewController?

//MARK::- OUTLETS
    @IBOutlet var btnCardIcon: UIButton!
    @IBOutlet var lblAccountNumber: UILabel!
    @IBOutlet var lblSavedAccountNumber: UILabel!
    @IBOutlet var btnRemoveOutlet: UIButton!
    
//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//MARK::- CELL BTN ACTIONS
    @IBAction func btnRemoveAction(_ sender: Any) {
        removeCardFromAccount(card_id :card_id)
               
    }
}

//MARK::- API CALLS
extension ManagePaymentsTableViewCell {
    func removeCardFromAccount(card_id :String) {
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.removeCard (access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, card_id: card_id)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                let message = data as? ManagePaymentModal
                
                let alert = UIAlertController(title: "", message:(message?.message ?? ""), preferredStyle: .alert)
                print(message?.message ?? "")
                alert.view.tintColor = appColor
                alert.view.backgroundColor = UIColor.white
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
                 self.myTableViewController?.viewAllCards()
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
                
                
            case .failureMessage(let message):
                print("failure")
                
                let alert = UIAlertController(title: "", message:message ?? "", preferredStyle: .alert)
                alert.view.tintColor = appColor
                alert.view.backgroundColor = UIColor.white
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
                    
                }))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)

                
            default : break
            }
        })

    }
    
}
