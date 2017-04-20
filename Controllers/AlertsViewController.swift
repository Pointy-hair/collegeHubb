//
//  AlertsViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import PullToRefreshKit

class AlertsViewController: UIViewController{

//MARK::- VC VARIABLES
    var arrayNotification = [NotificationModal]()
    var page = 1
    
    
//MARK::- VC OUTLETS
    @IBOutlet var tblView: UITableView!

//MARK::- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        pullToRefresh()
        fetchNotifications()
        self.tblView?.rowHeight = UITableViewAutomaticDimension;
        self.tblView?.estimatedRowHeight = 140;//(Maximum Height that should be assigned to your cell)
        
    }

}
//MARK::- TABLE VIEW DELEGATES
extension AlertsViewController:UITableViewDelegate,UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayNotification.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNotification[section].details.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        let headerView = nib.instantiate(withOwner: nil, options: nil)[0] as? HeaderView
        headerView?.lblFormattedDate.text = (arrayNotification[section].formatted_date)
        headerView?.lblTimeSince.text = (arrayNotification[section].time_since)
        return headerView
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell" , for: indexPath) as? AlertTableViewCell  else {return UITableViewCell() }
         let modal = (arrayNotification[indexPath.section].details[indexPath.row])
        //cell.imgUserProfileImage?.sd_setImage(with: URL(string: (modal.image100).unwrap()))
        cell.imgUserProfileImage?.sd_setImage(with: URL(string: (modal.image100).unwrap()), placeholderImage: UIImage(imageLiteralResourceName: "ic_profile"))
        cell.lblNotificationDate.text = (modal.time)
        cell.lblNotification.text = ((modal.firstname).unwrap() + " " + (modal.lastname).unwrap())
        return cell
        
    }
    func pullToRefresh(){
        _ = tblView.setUpFooterRefresh { [weak self] in
            if var value = self?.page{
                value = value + 1
                self?.page = value
            }
            self?.fetchNotifications ()
        }
    }
    
}
//MARK::- API CALLS
extension AlertsViewController {
    func fetchNotifications () {
        
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.notification(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, timezone : APIConstants.timezone,page: page.toString)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                guard let map = data as? [NotificationModal] else { return }
                self.arrayNotification.append(contentsOf: map)
                self.tblView?.delegate = self
                self.tblView?.dataSource = self
                self.tblView?.reloadData()
                self.tblView.endFooterRefreshing()
            case .failureMessage(let message):
                
                print("failure")
                UtilityFunctions.showAlert(message: message, controller: self)
                self.tblView.endFooterRefreshing()
            default : break
                
            }
        })
  
    }
}
