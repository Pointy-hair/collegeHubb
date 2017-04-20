//
//  PastOrdersViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 15/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import PullToRefreshKit

class PastOrdersViewController: UIViewController {
    
    //MARK::- VC VARIABLES
    var arrayPastOrder = [ProfileTabSubMenus]()
    var page = 1
    
//MARK:- VC OUTLETS
    @IBOutlet var tblView: UITableView!
    
    
//MARK:- VC LIFE CYCLE
     override func viewDidLoad() {
        super.viewDidLoad()
        fetchPastOrder ()
        pullToRefresh()
        self.tblView?.rowHeight = UITableViewAutomaticDimension;
        self.tblView?.estimatedRowHeight = 212;//(Maximum Height that should be assigned to your cell)
        tblView.delegate = self
        tblView.dataSource = self
      
    }

//MARK:- BUTTON ACTIONS

}

//MARK:- TABLE VIEW DELEGATES
extension PastOrdersViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayPastOrder.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPastOrder[section].details.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        let headerView = nib.instantiate(withOwner: nil, options: nil)[0] as? HeaderView
        headerView?.lblFormattedDate.text = (arrayPastOrder[section].formatted_date)
        headerView?.lblTimeSince.text = (arrayPastOrder[section].time_since)
        return headerView
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modal = (arrayPastOrder[indexPath.section].details[indexPath.row])
        if let type = modal.type?.toInt(){
            switch type {
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.pastOrderTripCell.rawValue , for: indexPath) as? PastOrdersTableViewCell  else {return UITableViewCell() }
                cell.imgProgileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                cell.lblTitlePayed.text = "Payed"//modal.price
                cell.lblDate.text = modal.date
                cell.lblDestinationFrom.text = modal.departure
                cell.lblDestinationTo.text = modal.destination
                cell.lblTitleTripDetails.text = "Trip Details"
                cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                cell.lblPayed.text = "$" +  modal.price.unwrap()
                return cell
            case 3,5,6,7:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.pastOrderItemCell.rawValue , for: indexPath) as? PastOrderItemOrServiceCellTableViewCell  else {return UITableViewCell() }
                cell.imgProfileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                cell.lblDate.text = modal.date
                cell.lblItemOrServiceProvided.text = modal.name
                cell.lblAmountPayedOrEarned.text = "$" + modal.price.unwrap()
                cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                cell.lblTitlePayedOrEarned.text = "Payed"
                cell.lblTitleDate.text = "Date"
                switch type {
                case 3:
                    cell.lblTitleItemOrservice.text = "Service Title"
                case 5:
                    cell.lblTitleItemOrservice.text = "Book Title"
                case 6:
                    cell.lblTitleItemOrservice.text = "Ticket Title"
                case 7:
                    cell.lblTitleItemOrservice.text = "Item Title"
                    cell.lblTitlePayedOrEarned.text = "Earned"
                    cell.lblTitleDate.text = "Pay Out Date"
                default:
                    break
                }
                
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.approvePaymentBookCell.rawValue , for: indexPath) as? ApprovePaymentsBooksTableViewCell  else {return UITableViewCell() }
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
            self?.fetchPastOrder()
        }
    }

}

//MARK:- API CALLS
extension PastOrdersViewController {
    func fetchPastOrder() {
        
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.viewProfileData(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page : page.toString,data_for: "5")), completion: { (response) in
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                guard let map = data as? [ProfileTabSubMenus] else { return }
                self.arrayPastOrder.append(contentsOf: map)
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

    
