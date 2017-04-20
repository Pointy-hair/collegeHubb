//
//  FavouriteViewController.swift
//  CollegeHub
//
//  Created by Sierra 4 on 27/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import PullToRefreshKit

class FavouriteViewController: UIViewController {
    
//MARK::- VC VARIABLES
    var arrayFavourites = [ProfileTabSubMenus]()
    var page = 1
    
//MARK::- VC OUTLETS
    @IBOutlet var tblView: UITableView!
    
//MARK::- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        pullToRefresh()
        self.tblView?.rowHeight = UITableViewAutomaticDimension;
        self.tblView?.estimatedRowHeight = 400;//(Maximum Height that should be assigned to your cell)
        fetchFavourites ()
    }
    
//MARK::- BTN ACTIONS
    
}

//MARK::- TABLE VIEW DELEGATES
extension FavouriteViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayFavourites.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFavourites[section].details.count
   
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let nib = UINib(nibName: "HeaderView", bundle: nil)
            let headerView = nib.instantiate(withOwner: nil, options: nil)[0] as? HeaderView
            headerView?.lblFormattedDate.text = (arrayFavourites[section].formatted_date)
            headerView?.lblTimeSince.text = (arrayFavourites[section].time_since)
        return headerView

    }

    func tableView(_ tableView: UITableView, commiteditingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favouriteAction = UITableViewRowAction(style: .normal, title: "Add to Favourites") { (action:UITableViewRowAction! , indexPath:IndexPath! ) -> Void in
            
        }
        
        favouriteAction.backgroundColor = appColor
        favouriteAction.title = "♥️Add to Favourites"
        return [favouriteAction]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modal = (arrayFavourites[indexPath.section].details[indexPath.row])
        if let type = modal.type?.toInt(){
            switch type {
            case 1 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.favouriteCarpoolCell.rawValue , for: indexPath) as? FavouriteCarpoolTableViewCell  else {return UITableViewCell() }
                cell.lblDeparture.text = (modal.departure)
                cell.lblDestination.text = (modal.destination)
                cell.lblPrice.text = (modal.price)
                cell.lblRating.text = (modal.avg_rating)
                cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                let  dateIs = (modal.leaving_on)
                let dateString = dateIs?.toDateTime()
                cell.lblDateTime.text = dateString.unwrap()
                cell.imgProfileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                return cell
            case 3 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.favouriteServiceCell.rawValue , for: indexPath) as? FavouriteServiceTableViewCell  else {return UITableViewCell() }
                cell.imgProfileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                cell.lblPrice.text = (modal.price)
                cell.lblRating.text = (modal.avg_rating)
                cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                cell.lblServiceName.text = (modal.service_name)
                cell.lblSessionLength.text = (modal.duration)
                return cell
            case 5 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.favouriteBooksCell.rawValue , for: indexPath) as? FavouriteBooksTableViewCell  else {return UITableViewCell() }
                cell.imgProfileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                cell.lblPrice.text = (modal.price)
                cell.lblRating.text = (modal.avg_rating)
                cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                cell.lblBookTitle.text = (modal.name)
                cell.productImages = (modal.image) ?? []
                return cell
            case 6 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.favouriteTicketsCell.rawValue , for: indexPath) as? FavouriteTicketsTableViewCell  else {return UITableViewCell() }
                cell.imgProfileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                cell.lblPrice.text = (modal.price)
                cell.lblRating.text = (modal.avg_rating)
                cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                cell.lblTitle.text = (modal.name)
                let  dateIs = (modal.date).unwrap()
                let dateString = dateIs.toDateTime()
                cell.lblDateTime.text = dateString.unwrap() + "  " + (modal.time).unwrap()
                return cell
            case 7 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.favouriteBooksCell.rawValue , for: indexPath) as? FavouriteBooksTableViewCell  else {return UITableViewCell() }
                cell.imgProfileImage.sd_setImage(with: URL(string: (modal.image100).unwrap()))
                cell.lblPrice.text = (modal.price)
                cell.lblRating.text = (modal.avg_rating)
                cell.lblUserName.text = (modal.firstname).unwrap() + " " + (modal.lastname).unwrap()
                cell.lblBookTitle.text = (modal.name)
                cell.productImages = (modal.image) ?? []
                return cell
            
            default :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.favouriteCarpoolCell.rawValue , for: indexPath) as? FavouriteCarpoolTableViewCell  else {return UITableViewCell() }
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
            self?.fetchFavourites()
        }
        
    }
    
}

extension FavouriteViewController {
    func fetchFavourites () {
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.viewProfileData(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page : page.toString,data_for: "1")), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                guard let map = data as? [ProfileTabSubMenus] else { return }
                self.arrayFavourites.append(contentsOf: map)
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

