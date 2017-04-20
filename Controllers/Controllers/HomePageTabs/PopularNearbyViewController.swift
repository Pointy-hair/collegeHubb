//
//  PopularNearbyViewController.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PopularNearbyViewController: UIViewController {
    
     //MARK::- VC VARIABLES
    var arrayCarpool : [RidePostViewModel]?
    var arrayServices : [ServicePostViewModel]?
    var arrayItems : [OtherPostViewModel]?
    var arrayBooks : [BookPostViewModel]?
    var arrayTickets : [TicketPostViewModel]?
    
    //MARK::- VC OUTLETS
    @IBOutlet var tblView: UITableView!
    
    //MARK::- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(HomePageItemViewController.initialise),
                                               name: NSNotification.Name(rawValue: "PopularData"),
                                               object: nil)
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: "PopularData"),
                                                  object: nil)
    }
    
    //MARK::- FUNCTIONS
    func initialise(){
        tblView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0)
        tblView?.rowHeight = UITableViewAutomaticDimension;
        tblView?.estimatedRowHeight = 212;//(Maximum Height that should be assigned to your cell)
        fetchViewPopular()
    }
    
    //MARK::- BTN ACTIONS
    
}

//MARK::- TABLE VIEW DELEGATES
extension PopularNearbyViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0 :
            return "Carpool"
        case 1 :
            return "Service"
        case 2 :
            return "Tickets"
        case 3 :
            return "Book"
        case 4 :
            return "Items"
        default :
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        header.textLabel?.font = UIFont(name: "Gotham-Bold", size: 16.0)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        let headerButton:UIButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width-150, y: 0, width: 200, height: 30))
        headerButton.setTitle("View All", for: .normal)
        headerButton.titleLabel?.textColor = UIColor.purple //UIColor(red: 13/255.0, green: 213/255.0, blue: 178/255.0, alpha: 1.0)
        headerButton.setTitleColor(appColor, for: UIControlState.normal)
        headerButton.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 12.0)
        header.contentView.backgroundColor = UIColor.white
        header.addSubview(headerButton)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
            case 0 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.carpoolPopularNearbyCell.rawValue , for: indexPath) as? PopularNearbyCarpoolTableViewCell  else {return UITableViewCell() }
                cell.carpool = arrayCarpool ?? []
                return cell
            case 1 :
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.servicePopularNearbyCell.rawValue , for: indexPath) as? PopularNearbyServiceTableViewCell  else {return UITableViewCell() }
                cell.services = arrayServices ?? []
                return cell
            case 2 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.ticketsPopularNearbyCell.rawValue , for: indexPath) as? PopularNearbyTicketsTableViewCell  else {return UITableViewCell() }
                cell.tickets = arrayTickets ?? []
                return cell
            case 3 :
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.booksPopularNearbyCell.rawValue , for: indexPath) as? PopularNearbyBooksTableViewCell  else {return UITableViewCell() }
                cell.books = arrayBooks ?? []
                return cell
            case 4 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.itemsPopularNearbyCell.rawValue , for: indexPath) as? PopularNearbyItemTableViewCell  else {return UITableViewCell() }
                cell.items = arrayItems ?? []
                return cell
            default :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.carpoolPopularNearbyCell.rawValue , for: indexPath) as? PopularNearbyCarpoolTableViewCell  else {return UITableViewCell() }
                return cell
        }
        
    }
}
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let HomeStoryBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//        switch indexPath.section{
//        //Carpool
//        case 1:
//            let myHomeVC = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageCarpoolViewController") as! HomePageCarpoolViewController
//            self.navigationController?.pushViewController(myHomeVC, animated: true)
//            //edited
//            
//        //Services
//        case 2:
//            let myHomeVC  = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageServiceViewController") as! HomePageServiceViewController
//            self.navigationController?.pushViewController(myHomeVC , animated: true)
//            
//        //Ticket
//        case 3:
//            let myHomeVC  = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageTicketViewController") as! HomePageTicketViewController
//            self.navigationController?.pushViewController(myHomeVC , animated: true)
//            
//        //Book
//        case 4:
//            let myHomeVC  = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageBookViewController") as! HomePageBookViewController
//            self.navigationController?.pushViewController(myHomeVC , animated: true)
//            
//        //Item
//        case 5:
//            let myHomeVC  = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageItemViewController") as! HomePageItemViewController
//            self.navigationController?.pushViewController(myHomeVC , animated: true)
//            
//        default:
//            return
//        }
//    }

extension PopularNearbyViewController {
    func fetchViewPopular(){
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.viewPopular(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                print(data ?? "")
                let modal = data as? PopularNearbyModal
                self.arrayCarpool =  (modal?.carpool) ?? [] as [RidePostViewModel]
                self.arrayServices = (modal?.services) ?? [] as [ServicePostViewModel]
                self.arrayTickets = (modal?.tickets) ?? [] as [TicketPostViewModel]
                self.arrayBooks = (modal?.books) ?? [] as [BookPostViewModel]
                self.arrayItems = (modal?.items) ?? [] as [OtherPostViewModel]
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
            case .failureMessage(let message):
                print("failure")
                UtilityFunctions.showAlert(message: message, controller: self)
            default : break
                
                
            }
        })
    }
}
    
    

