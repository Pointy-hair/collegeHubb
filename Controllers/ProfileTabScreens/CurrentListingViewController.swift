//
//  CurrentListingViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 15/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import PullToRefreshKit

class CurrentListingViewController: UIViewController {

    //MARK::- VC VARIABLES
    var arrayCurrentListing = [ProfileTabSubMenus]()
    var page = 1
    
//MARK:- VC OUTLETS
    @IBOutlet var tblView: UITableView!

//MARK:- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        pullToRefresh()
        self.tblView?.rowHeight = UITableViewAutomaticDimension;
        self.tblView?.estimatedRowHeight = 212;//(Maximum Height that should be assigned to your cell)
        fetchCurrentListing()
    }
    
    //MARK:- BTN ACTIONS
    
  
  }
//MARK:- TABLE VIEW DELEGATES
extension CurrentListingViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayCurrentListing.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCurrentListing[section].details.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        let headerView = nib.instantiate(withOwner: nil, options: nil)[0] as? HeaderView
        headerView?.lblFormattedDate.text = (arrayCurrentListing[section].formatted_date)
        headerView?.lblTimeSince.text = (arrayCurrentListing[section].time_since)
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modal = (arrayCurrentListing[indexPath.section].details[indexPath.row])
        if let type = modal.type?.toInt(){
            switch type {
                case 1:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.currentListingTripCell.rawValue , for: indexPath) as? CurrentListingTableViewCell  else {return UITableViewCell() }
                        cell.myTripTableViewController = self
                        cell.lblDeparture.text = (modal.departure).unwrap()
                        cell.lblDestination.text = (modal.destination).unwrap()
                        cell.lblTitle.text = "Offering A Ride"
                        cell.delegate = self
                        cell.posts_id = (modal.posts_id).unwrap()
                        return cell
                case 3,5,6,7:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.currentListingBookCell.rawValue , for: indexPath) as? CurrentListingBooksTableViewCell  else {return UITableViewCell() }
                        cell.myBookTableViewController = self
                        cell.lblBooktTitle.text = (modal.name)
                        cell.delegate = self
                        cell.posts_id = (modal.posts_id).unwrap()
                        switch type {
                        case 3:
                            cell.lblTitle.text = "Offering A Service"
                        case 5:
                            cell.lblTitle.text = "Selling A Book"
                        case 6:
                            cell.lblTitle.text = "Selling A Ticket"
                        case 7:
                            cell.lblTitle.text = "Selling An Item"
                        default:
                            break
                        }
                        return cell
                default:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.currentListingBookCell.rawValue , for: indexPath) as? CurrentListingBooksTableViewCell  else {return UITableViewCell() }
                    cell.myBookTableViewController = self
                    return cell
            }
        
        }
        return UITableViewCell()
    }
    func pullToRefresh(){
        _ = tblView.setUpFooterRefresh { [weak self] in
            if var value = self?.page{
                value = value + 1
                self?.page = value
            }
            self?.fetchCurrentListing()
        }
    }

}
//MARK:- API CALLS
extension CurrentListingViewController {
    func fetchCurrentListing () {
        
       APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.viewProfileData(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page : page.toString,data_for: "3")), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                guard let map = data as? [ProfileTabSubMenus] else { return }
                self.arrayCurrentListing.append(contentsOf: map)
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
extension CurrentListingViewController :  DelegateUpdateCurrentListing{
    func UpdateCurrentListing(){
        fetchCurrentListing ()
    }
}
