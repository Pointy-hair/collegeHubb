//
//  CurrentListingBooksTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 29/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CurrentListingBooksTableViewCell: UITableViewCell {

//MARK::- CELL VARIABLES
    var myBookTableViewController: CurrentListingViewController?
    var delegate: DelegateUpdateCurrentListing?
    var posts_id = ""
    
//MARK::- CELL OUTLETS
    
    @IBOutlet var lblBooktTitle: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnRemoveOutlet: UIButton!
    @IBOutlet var btnEditOutlet: UIButton!

//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
    super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
//MARK::- CELL BTN ACTIONS
    @IBAction func btnRemoveAction(_ sender: Any) {
    //    posts_id = ""
       deletePost(posts_id: posts_id)
    }
    
    
    @IBAction func btnApproveAction(_ sender: Any) {
    }

}
//MARK:- API CALLS
extension CurrentListingBooksTableViewCell {
    func deletePost(posts_id:String?)
    {
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.deletePost(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, posts_id: posts_id)), completion: { (response) in
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                let message = data as? ManagePaymentModal
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message:(message?.message ?? ""), preferredStyle: .alert)
                    print(message?.message ?? "")
                    alert.view.tintColor = appColor
                    alert.view.backgroundColor = UIColor.white
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
                         self.delegate?.UpdateCurrentListing()
                    }))
                    
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                
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
