//
//  ProfileViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileViewController: UIViewController {
    
//MARK:- OUTLETS
    @IBOutlet var tableView : UITableView?

//MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.rowHeight = UITableViewAutomaticDimension;
        tableView?.estimatedRowHeight = 212;//(Maximum Height that should be assigned to your cell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navBar?.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}
//MARK:- TABLE VIEW DELEGATES
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileTableViewCell" , for: indexPath) as? MyProfileTableViewCell  else {return UITableViewCell() }

        
        switch indexPath.row{
        case 0:
            guard let cellHeader = tableView.dequeueReusableCell(withIdentifier: "MyProfileHederTableViewCell" , for: indexPath) as? MyProfileHederTableViewCell else {return UITableViewCell() }
            
            if let firstname = UserDataSingleton.sharedInstance.loggedInUser?.firstname{
                cellHeader.lblName.text = "Hi " + firstname
            }
            
            if let image = UserDataSingleton.sharedInstance.loggedInUser?.image100{
                cellHeader.imgView.sd_setImage(with: NSURL.init(string: image) as URL!, placeholderImage: UIImage.init(named: "ic_profile_placeholder"))
            }
            
            return cellHeader

        case 1:
            cell.lblText.text = "My Profile"
            cell.imgView.image = UIImage.init(named: "ic_profile_info")
        case 2:
            cell.lblText.text = "Favourites"
            cell.imgView.image = UIImage.init(named: "ic_heart")
        case 3:
            cell.lblText.text = "Bidding"
            cell.imgView.image = UIImage.init(named: "ic_bid")
        case 4:
            cell.lblText.text = "Current Listing"
            cell.imgView.image = UIImage.init(named: "ic_listing")
        case 5:
            cell.lblText.text = "Approve Payments"
            cell.imgView.image = UIImage.init(named: "ic_payreceipt")
        case 6:
            cell.lblText.text = "Past Orders"
            cell.imgView.image = UIImage.init(named: "ic_past_orders")
        case 7:
            cell.lblText.text = "Manage Payments"
            cell.imgView.image = UIImage.init(named: "ic_payment")
        case 8:
            cell.lblText.text = "Sign Out"
            cell.imgView.image = UIImage.init(named: "ic_settings")
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileStoryboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        switch indexPath.row{
        
        //My Profile
        case 1:
            let myProfileVC = profileStoryboard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
            self.navigationController?.pushViewController(myProfileVC, animated: true)
        //edited
            
        //Favourite
        case 2:
            let myProfileVC = profileStoryboard.instantiateViewController(withIdentifier: "FavouriteViewController") as! FavouriteViewController
            self.navigationController?.pushViewController(myProfileVC, animated: true)
         
        //Bidding
        case 3:
            let myProfileVC = profileStoryboard.instantiateViewController(withIdentifier: "BiddingViewController") as! BiddingViewController
            self.navigationController?.pushViewController(myProfileVC, animated: true)
            
        //Current Listing
        case 4:
            let myCurrentListingVC = profileStoryboard.instantiateViewController(withIdentifier: "CurrentListingViewController") as! CurrentListingViewController
            self.navigationController?.pushViewController(myCurrentListingVC, animated: true)
        
        //Approve payments
        case 5:
            let myApprovePaymentVC = profileStoryboard.instantiateViewController(withIdentifier: "ApprovePaymentsViewController") as! ApprovePaymentsViewController
            self.navigationController?.pushViewController(myApprovePaymentVC, animated: true)
            
        //Past Orders
        case 6:
            let myPastOrderVC = profileStoryboard.instantiateViewController(withIdentifier: "PastOrdersViewController") as! PastOrdersViewController
            self.navigationController?.pushViewController(myPastOrderVC, animated: true)
        
        //Manage Payments
        case 7:
            let myPaymentVC = profileStoryboard.instantiateViewController(withIdentifier: "ManagePaymentsViewController") as! ManagePaymentsViewController
            self.navigationController?.pushViewController(myPaymentVC, animated: true)
        //complete
        //SignOut
        case 8:
            let alert = UIAlertController(title: "", message: "Are you sure you want to sign out?", preferredStyle: .alert)
            alert.view.tintColor = appColor
            alert.view.backgroundColor = UIColor.white
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
                self.callLogoutAPI()
            }))
            self.present(alert, animated: true, completion: {
            })
        default:
            return
        }
    }
//MARK:- API CALL
    func callLogoutAPI(){
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.logout(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                let message = data as! JSON
                print(message.stringValue)
                
                UserDataSingleton.sharedInstance.loggedInUser?.access_token = nil
                let navController = self.storyboard?.instantiateInitialViewController()
                self.presentVC(navController!)
                
            case .failureMessage(let message):
                print("failure")
                UtilityFunctions.showAlert(message: message, controller: self)
            default : break
                
                
            }
        })
    }

}

