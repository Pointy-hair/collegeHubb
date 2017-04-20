//
//  ApprovePaymentsViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 23/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import PullToRefreshKit
    

class ApprovePaymentsViewController: UIViewController {
    //MARK::- VC VARIABLES
    var arrayApprovePayments = [ProfileTabSubMenus]()
    var page = 1


//MARK:- VC OUTLETS
    @IBOutlet var tblView: UITableView!
    
//MARK:- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApprovePayments ()
        pullToRefresh()
        self.tblView?.rowHeight = UITableViewAutomaticDimension;
        self.tblView?.estimatedRowHeight = 212;//(Maximum Height that should be assigned to your cell)
        
    }
//MARK:- BUTTON ACTIONS

}
//MARK:- TABLE VIEW DELEGATES
extension ApprovePaymentsViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayApprovePayments.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        return "Today"
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayApprovePayments[section].details.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        let headerView = nib.instantiate(withOwner: nil, options: nil)[0] as? HeaderView
        headerView?.lblFormattedDate.text = (arrayApprovePayments[section].formatted_date)
        headerView?.lblTimeSince.text = (arrayApprovePayments[section].time_since)
        return headerView
        
    }
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let header = view as? UITableViewHeaderFooterView else { return }
//        header.textLabel?.textColor = UIColor(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1.0)
//        header.textLabel?.font = UIFont(name: "Gotham-Book", size: 14.0)
//        header.textLabel?.frame = header.frame
//        header.textLabel?.textAlignment = .left
//        let headerDate:UILabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width-216, y: 0, width: 200, height: 30))
//        headerDate.text = "Tue, 20 Dec"
//        headerDate.font = UIFont(name: "Gotham-Book", size: 14.0)
//        headerDate.textColor = UIColor(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1.0)
//        headerDate.textAlignment = .right
//        header.addSubview(headerDate)
//    }
//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modal = (arrayApprovePayments[indexPath.section].details[indexPath.row])
        if let type = modal.type?.toInt(){
            switch type {
                case 1:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.approvePaymentTripCell.rawValue , for: indexPath) as? ApprovePaymentTableViewCell  else {return UITableViewCell() }
                    cell.imgProgileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                    cell.lblAmmountToBePaid.text = modal.price
                    cell.lblDestinationFrom.text = modal.departure
                    cell.lblDestinationTo.text = modal.destination
                    cell.lblTitleTripDetails.text = "Trip Details"
                    cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                    return cell
                case 3,5,6,7:
                   guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.approvePaymentBookCell.rawValue , for: indexPath) as? ApprovePaymentsBooksTableViewCell  else {return UITableViewCell() }
                   cell.imgProgileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                   cell.lblAmmountToBePaid.text = modal.price
                   cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                   cell.lblProductTitle.text = modal.name
                   switch type {
                   case 3:
                    cell.lblTitle.text = "Service Title"
                    cell.lblProductTitle.text = modal.service_name
                   case 5:
                    cell.lblTitle.text = "Book Title"
                   case 6:
                    cell.lblTitle.text = "Ticket Title"
                   case 7:
                    cell.lblTitle.text = "Item Title"
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
            self?.fetchApprovePayments()
        }
    }
    
}
//MARK:- API CALLS
extension ApprovePaymentsViewController {
    func fetchApprovePayments() {
        
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.viewProfileData(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page : page.toString,data_for: "4")), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                guard let map = data as? [ProfileTabSubMenus] else { return }
                self.arrayApprovePayments.append(contentsOf: map)
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

