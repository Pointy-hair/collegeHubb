//
//  HomePageItemViewController.swift
//  CollegeHub
//
//  Created by Sierra 4 on 06/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import PullToRefreshKit
import SJSegmentedScrollView

class HomePageItemViewController: UIViewController {
    //MARK::- VC OUTLETS
    @IBOutlet var tblView: UITableView!
    
    //MARK::- VC VARIABLS
    var posts_id = ""
    var page = 1
    var arrayItems = [OtherPostViewModel]()
    var searchKey = ""
    
    //MARK::- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(HomePageItemViewController.initialise),
                                               name: NSNotification.Name(rawValue: "ItemsData"),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: "ItemsData"),
                                                  object: nil)
    }
    
    func initialise(){
        pullToRefresh()
        tblView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0)
        tblView?.rowHeight = UITableViewAutomaticDimension;
        tblView?.estimatedRowHeight = 400;//(Maximum Height that should be assigned to your cell)
        fetchViewPostItem()
    }
        
    //MARK::- BTN ACTIONS
    
    @IBAction func btnSellAItemAction(_ sender: Any) {
       
    }
}

extension HomePageItemViewController: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        print("sadsa")
    }
}

//MARK::- TABLE VIEW DELEGATES
extension HomePageItemViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItems.count
    }
    
    func tableView(_ tableView: UITableView, commiteditingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        posts_id = (UserDataSingleton.sharedInstance.othersData?[indexPath.row].posts_id).unwrap()
        let favouriteAction = UITableViewRowAction(style: .normal, title: "Add to Favourites") { (action:UITableViewRowAction! , indexPath:IndexPath! ) -> Void in
            self.addingPostToFavourite(posts_id: self.posts_id) 
        }
        
        favouriteAction.backgroundColor = appColor
        favouriteAction.title = "♥️Add to Favourites"
        return [favouriteAction]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.sellAItemCell.rawValue , for: indexPath) as? HomeScreenItemTableViewCell  else {return UITableViewCell() }
        if let arrModal = arrayItems as [OtherPostViewModel]?{
            let modal = arrModal[indexPath.row] as OtherPostViewModel
        cell.lblItemTitle.text = modal.name.unwrap()
        cell.lblUserName.text = modal.firstname.unwrap() + " " + modal.lastname.unwrap()
        cell.lblPrice.text = modal.price.unwrap()
        cell.imgProfileImage?.sd_setImage(with: URL(string: modal.image100.unwrap()))
        cell.lblRating.text = modal.avg_rating.unwrap()
        cell.productImages = modal.image ?? []
        }
            
        return cell
        
        }
    func pullToRefresh(){
        _ = tblView.setUpFooterRefresh { [weak self] in
            if var value = self?.page{
                value = value + 1
                self?.page = value
            }
            self?.fetchViewPostItem()
        }
        
    }
        
    }
//MARK:- API CALLS
extension HomePageItemViewController {
    func addingPostToFavourite(posts_id:String?)
    {
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.addToFavourite(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, posts_id: posts_id)), completion: { (response) in
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
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
            case .failureMessage( _):
                print("failure")
                UtilityFunctions.showAlert(message: "Failed!! Retry", controller: self)
            default : break
            }
        })
       
    }
    func fetchViewPostItem(){
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.viewPosts(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page: page.toString, type: "7", search_key: "")), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                print(data ?? "")
                guard let map = data as? [OtherPostViewModel] else { return }
                self.arrayItems.append(contentsOf: map)
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

    
