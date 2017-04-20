//
//  CardViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 27/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: Int = 4

/*
Things to manage
1) Current Tab for each Category type
2) Data fetching for each tab done or not
3) Page Value of API for each tab
*/
 
class CardViewController: UIViewController {
}
//// MARK: - Variables Declaration
//    var currentPage:String?
//    fileprivate var dataSource: [UIView]?
//    
//    var viewType: [UIView]{
//        get{
//            return[
//                (Bundle.main.loadNibNamed("ItemCardView", owner: self, options: nil)?[0] as? ItemCardView)!,
//                (Bundle.main.loadNibNamed("RideCardView", owner: self, options: nil)?[0] as? RideCardView)!,
//                (Bundle.main.loadNibNamed("ServiceCardView", owner: self, options: nil)?[0] as? ServiceCardView)!
//            ]
//        }
//    }
//    
//// MARK: - Outlets
//    @IBOutlet weak var kolodaView: KolodaView!
//    @IBOutlet weak var btnYes: UIButton!
//    @IBOutlet weak var btnNo: UIButton!
//    @IBOutlet weak var btnFilter: UIButton!
//
//    @IBOutlet weak var btnSubcategoryLeft: UIButton!
//    @IBOutlet weak var btnSubcategoryCenter: UIButton!
//    @IBOutlet weak var btnSubcategoryRight: UIButton!
//
//
//// MARK: - View LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(currentPage ?? "")
//        
////        dataSource = {
////            var array: [UIView] = []
////            return array
////        }()
//        
//        btnYes.layer.cornerRadius = btnYes.frame.width/2
//        btnNo.layer.cornerRadius = btnYes.frame.width/2
//        btnFilter.layer.cornerRadius = btnFilter.frame.width/2
//        btnSubcategoryCenter.isHidden = true
//        btnFilter.isHidden = true
//
//        updateDatasourceFirstTime()
//    }
//    
//// MARK: - Koloda Delegate and datasource initiation
//    func initialise(){
//        kolodaView.dataSource = self
//        kolodaView.delegate = self
//        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
//    }
//    
//// MARK: - Koloda DataSource Initiation Method
//    func updateDatasourceFirstTime(){
//        
//        //Empty DataSource
//        dataSource = {
//            let array: [UIView] = []
//            return array
//        }()
//        kolodaView.reloadData()
//        initialise()
//        
//        if let page = currentPage{
//            switch page{
//            case  pageName.item.rawValue:
//                btnSubcategoryLeft.setTitle(itemSubCategory.books.rawValue, for: UIControlState.normal)
//                btnSubcategoryCenter.setTitle(itemSubCategory.tickets.rawValue, for: UIControlState.normal)
//                btnSubcategoryRight.setTitle(itemSubCategory.others.rawValue, for: UIControlState.normal)
//                btnSubcategoryCenter.isHidden = false
//                
//                distinguishBetweenItemTabs()
//
//            case  pageName.ride.rawValue:
//                btnSubcategoryLeft.setTitle(rideSubCategory.lookForRide.rawValue, for: UIControlState.normal)
//                btnSubcategoryCenter.isHidden = true
//                btnSubcategoryRight.setTitle(rideSubCategory.lookForPassenger.rawValue, for: UIControlState.normal)
//                
//                print(UserDefaults.standard.value(forKey: userPrefrences.currentTabForRide.rawValue) ?? "")
//
//                distinguishBetweenRideTabs()
//
//            case  pageName.service.rawValue:
//                btnSubcategoryLeft.setTitle(serviceSubCategory.lookForService.rawValue, for: UIControlState.normal)
//                btnSubcategoryCenter.isHidden = true
//                btnSubcategoryRight.setTitle(serviceSubCategory.offerAService.rawValue, for: UIControlState.normal)
//                
//                distinguishBetweenServiceTabs()
//
//            default: return
//            }
//        }
//    }
//    
//// MARK: - Subcategory Tab Distinction & API calls
//    func distinguishBetweenRideTabs(){
//        let result = UserDefaults.standard.value(forKey: userPrefrences.currentTabForRide.rawValue) as! String
//        
//        if (result == rideSubCategory.lookForRide.rawValue){
//            leftTabClicked()
//            
//            //-------
//          //  fetchViewPosts(type: "1",page: "1")
//            //--------
////            fetchRidesData(page: "1",type: "0")
//            
//        }else if(result == rideSubCategory.lookForPassenger.rawValue){
//            RightTabClicked()
//            
//            //-------
//            fetchViewPosts(type: "1",page: "1")
//            //--------
////            fetchRidesData(page: "1",type: "1")
//        }
//    }
//    
//    func distinguishBetweenItemTabs(){
//        if ((UserDefaults.standard.value(forKey: userPrefrences.currentTabForItem.rawValue) as! String) == itemSubCategory.books.rawValue){
//            leftTabClicked()
//            
//            //-------
//            fetchViewPosts(type: "5",page: "1")
//            //--------
////            fetchBooksData(page: "1")
//        }else if((UserDefaults.standard.value(forKey: userPrefrences.currentTabForItem.rawValue) as! String) == itemSubCategory.tickets.rawValue){
//            centerTabClicked()
//            
//            //-------
//            fetchViewPosts(type: "6",page: "1")
//            //--------
////            fetchTicketsData(page: "1")
//        }else{
//            RightTabClicked()
//            
//            //-------
//            fetchViewPosts(type: "7",page: "1")
//            //--------
////            fetchOthersData(page: "1")
//        }
//    }
//    
//    func distinguishBetweenServiceTabs(){
//        if ((UserDefaults.standard.value(forKey: userPrefrences.currentTabForService.rawValue) as! String) == serviceSubCategory.lookForService.rawValue){
//            
//            leftTabClicked()
//            
//            //-------
//            fetchViewPosts(type: "3",page: "1")
//            //--------
////            fetchServicesData(page: "1",type: "2")
//            
//        }else if((UserDefaults.standard.value(forKey: userPrefrences.currentTabForService.rawValue) as! String) == serviceSubCategory.offerAService.rawValue){
//            
//            RightTabClicked()
//            
//            //-------
//            fetchViewPosts(type: "3",page: "1")
//            //--------
////            fetchServicesData(page: "1",type: "3")
//        }
//    }
//    
//// MARK: - SubCategory Tab Click Actions
//    func leftTabClicked(){
//        btnSubcategoryLeft.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 16)
//        btnSubcategoryLeft.setTitleColor(UIColor.white.withAlphaComponent(1), for: UIControlState.normal)
//        btnSubcategoryRight.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 12)
//        btnSubcategoryRight.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: UIControlState.normal)
//        btnSubcategoryCenter.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 12)
//        btnSubcategoryCenter.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: UIControlState.normal)
//    }
//    
//    func centerTabClicked(){
//        btnSubcategoryLeft.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 12)
//        btnSubcategoryLeft.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: UIControlState.normal)
//        btnSubcategoryCenter.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 16)
//        btnSubcategoryCenter.setTitleColor(UIColor.white.withAlphaComponent(1), for: UIControlState.normal)
//        btnSubcategoryRight.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 12)
//        btnSubcategoryRight.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: UIControlState.normal)
//    }
//    
//    func RightTabClicked(){
//        btnSubcategoryLeft.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 12)
//        btnSubcategoryLeft.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: UIControlState.normal)
//        btnSubcategoryRight.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 16)
//        btnSubcategoryRight.setTitleColor(UIColor.white.withAlphaComponent(1), for: UIControlState.normal)
//        btnSubcategoryCenter.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 12)
//        btnSubcategoryCenter.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: UIControlState.normal)
//    }
//    
//    
//    
//    func appendDatasource(){
//        
//    }
//    
//// MARK: - IBActions
//    @IBAction func btnNoAction() {
//        kolodaView?.swipe(.left)
//    }
//    
//    @IBAction func btnYesAction() {
//        kolodaView?.swipe(.right)
//    }
//    
//    @IBAction func undoButtonTapped() {
//        kolodaView?.revertAction()
//    }
//    
//    @IBAction func btnFilterTapped() {
//        
//    }
//    
//    @IBAction func btnSubcategoryLeftAction(_ sender: Any) {
//        if let page = currentPage{
//            switch page{
//            case  pageName.item.rawValue:
//                UserDefaults.standard.set(itemSubCategory.books.rawValue, forKey: userPrefrences.currentTabForItem.rawValue)
//                updateDatasourceFirstTime()
//
//            case  pageName.ride.rawValue:
//                
//                UserDefaults.standard.set(rideSubCategory.lookForRide.rawValue, forKey: userPrefrences.currentTabForRide.rawValue)
//                updateDatasourceFirstTime()
//
//            case  pageName.service.rawValue:
//                
//                UserDefaults.standard.set(serviceSubCategory.lookForService.rawValue, forKey: userPrefrences.currentTabForService.rawValue)
//                updateDatasourceFirstTime()
//
//            default: return
//            }
//        }
//    }
//    
//    @IBAction func btnSubcategoryCenterAction(_ sender: Any) {
//        if let page = currentPage{
//            switch page{
//            case  pageName.item.rawValue:
//                UserDefaults.standard.set(itemSubCategory.tickets.rawValue, forKey: userPrefrences.currentTabForItem.rawValue)
//                updateDatasourceFirstTime()
//
//            default: return
//            }
//        }
//    }
//    
//    @IBAction func btnSubcategoryRightAction(_ sender: Any) {
//        if let page = currentPage{
//            switch page{
//            case  pageName.item.rawValue:
//                UserDefaults.standard.set(itemSubCategory.others.rawValue, forKey: userPrefrences.currentTabForItem.rawValue)
//                updateDatasourceFirstTime()
//
//            case  pageName.ride.rawValue:
//                
//                UserDefaults.standard.set(rideSubCategory.lookForPassenger.rawValue, forKey: userPrefrences.currentTabForRide.rawValue)
//                updateDatasourceFirstTime()
//
//            case  pageName.service.rawValue:
//                
//                UserDefaults.standard.set(serviceSubCategory.offerAService.rawValue, forKey: userPrefrences.currentTabForService.rawValue)
//                updateDatasourceFirstTime()
//
//            default: return
//            }
//        }
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
//
//// MARK: - KolodaViewDelegate
//
//extension CardViewController: KolodaViewDelegate {
//    
//    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        
//        updateDatasourceFirstTime()
////        let position = kolodaView.currentCardIndex
////
////        if let page = currentPage{
////            switch page{
////            case  pageName.item.rawValue:
////                for _ in 1...4 {
////                    dataSource!.append(viewType[0])
////                }
////            case  pageName.ride.rawValue:
////                for _ in 1...4 {
////                    dataSource!.append(viewType[1])
////                }
////            case  pageName.service.rawValue:
////                for _ in 1...4 {
////                    dataSource!.append(viewType[2])
////                }
////            default: return
////            }
////        }
////        
////        kolodaView.insertCardAtIndexRange(position..<position + 4, animated: true)
//    }
//    
//    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//            print(index)
//        let cardDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "CardDetailViewController") as? CardDetailViewController
//        cardDetailVC?.cardIndex = index
//        cardDetailVC?.currentPage = currentPage
//        self.navigationController?.pushViewController(cardDetailVC!, animated: true)
//    }
//}
//
//// MARK: - KolodaViewDataSource
//
//extension CardViewController: KolodaViewDataSource {
//    
//    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
//        return dataSource!.count
//    }
//    
//    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
//        
//        let view = dataSource![Int(index)]
//
//        if view is RideCardView{
//            let rideView = view as? RideCardView
//
//            let result = UserDefaults.standard.value(forKey: userPrefrences.currentTabForRide.rawValue) as! String
//            if (result == rideSubCategory.lookForRide.rawValue){
//
//                let rideCardModel =  UserDataSingleton.sharedInstance.rideDataLookingForRide?[index]
//                rideView?.updateLookingForRideUI(rideModel: rideCardModel!)
//            }else if(result == rideSubCategory.lookForPassenger.rawValue){
//                let count:Int = ((UserDataSingleton.sharedInstance.rideDataLookingForPassenger?.count))!
//                print(count)
//                print(index)
//                let rideCardModel =  UserDataSingleton.sharedInstance.rideDataLookingForPassenger?[index]
//                rideView?.updateLookingForPassengerUI(rideModel: rideCardModel!)
//            }
//            
//        }else if view is ItemCardView{
//            let itemView = view as? ItemCardView
//
//            if ((UserDefaults.standard.value(forKey: userPrefrences.currentTabForItem.rawValue) as! String) == itemSubCategory.books.rawValue){
//                print("Books")
//                let booksModel =  UserDataSingleton.sharedInstance.booksData?[index]
//                itemView?.updateBooksUI(bookModel: booksModel!)
//            }else if((UserDefaults.standard.value(forKey: userPrefrences.currentTabForItem.rawValue) as! String) == itemSubCategory.tickets.rawValue){
//                print("Tickets")
//                let ticketsModel =  UserDataSingleton.sharedInstance.ticketsData?[index]
//                itemView?.updateTicketsUI(ticketModel: ticketsModel!)
//            }else{
//                print("Others")
//                let othersModel =  UserDataSingleton.sharedInstance.othersData?[index]
//                itemView?.updateOthersUI(OtherModel: othersModel!)
//            }
//            
//        }else{
//            let serviceView = view as? ServiceCardView
//            
//            if ((UserDefaults.standard.value(forKey: userPrefrences.currentTabForService.rawValue) as! String) == serviceSubCategory.lookForService.rawValue){
//                
//                let serviceCardModel =  UserDataSingleton.sharedInstance.serviceDataLookforService?[index]
//                serviceView?.updateLookingForServiceUI(serviceModel: serviceCardModel!)
//                
//            }else if((UserDefaults.standard.value(forKey: userPrefrences.currentTabForService.rawValue) as! String) == serviceSubCategory.offerAService.rawValue){
//                
//                let serviceCardModel =  UserDataSingleton.sharedInstance.serviceDataOfferAService?[index]
//                serviceView?.updateOfferAServiceUI(serviceModel: serviceCardModel!)
//            }
//            
//
//
////            serviceView?.lblPrice.text = "400"
//        }
//        return dataSource![Int(index)]
//    }
//    
//    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
//    }
//}
//
//// MARK: - API Calls for all Tabs
//extension CardViewController{
//    
//    func fetchViewPosts(type: String, page: String){
//        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.viewPosts(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page: page, type: type, search_key: "")), completion: { (response) in
//            
//            switch response{
//                
//            case .success(let data) :
//                
//                print(data ?? "")
//                let x = data as? [RidePostViewModel]
//                print(x?[0].departure ?? "")
//                
//                switch (type.toInt())!{
//                    case 1:
//                        UserDataSingleton.sharedInstance.rideDataLookingForPassenger = data as? [RidePostViewModel]
//                    case 3:
//                        UserDataSingleton.sharedInstance.serviceDataOfferAService = data as? [ServicePostViewModel]
//                    print(UserDataSingleton.sharedInstance.serviceDataOfferAService?[0].service_name)
//                    case 5:
//                        UserDataSingleton.sharedInstance.booksData = data as? [BookPostViewModel]
//                    case 6:
//                        UserDataSingleton.sharedInstance.ticketsData = data as? [TicketPostViewModel]
//                    case 7:
//                        UserDataSingleton.sharedInstance.othersData = data as? [OtherPostViewModel]
//                    default:
//                        break
//                }
//                
//               // UserDataSingleton.sharedInstance.rideDataLookingForPassenger = data as? [RidePostViewModel]
////                self.dataSource = {
////                    var array: [UIView] = []
////                    
////                    let count:Int = ((UserDataSingleton.sharedInstance.rideDataLookingForPassenger?.count))!
////                    if count != 0{
////                        for _ in 1...count {
////                            array.append(self.viewType[0])
////                        }
////                    }
////                    
////                    return array
////                }()
//                
//            case .failureMessage(let message):
//                print("failure")
//                UtilityFunctions.showAlert(message: message, controller: self)
//            default : break
//                
//                
//            }
//        })
//    }
//    
//    func fetchBooksData(page: String){
//
//        print(UserDataSingleton.sharedInstance.loggedInUser?.access_token ?? "")
//        
//        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.bookPosts_View(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page: page)), completion: { (response) in
//            
//            switch response{
//                
//            case .success(let data) :
//                
//                print(data ?? "")
//                let x = data as? [BookPostViewModel]
//                print(x?[0].name ?? "")
//                
//                UserDataSingleton.sharedInstance.booksData = data as? [BookPostViewModel]
//                self.dataSource = {
//                    var array: [UIView] = []
//                    
//                    let count:Int = ((UserDataSingleton.sharedInstance.booksData?.count))!
//                    if count != 0{
//                        for _ in 1...count {
//                            array.append(self.viewType[0])
//                        }
//                    }
//                    
//                    return array
//                }()
//                self.initialise()
//                
//                
//            case .failureMessage(let message):
//                print("failure")
//                UtilityFunctions.showAlert(message: message, controller: self)
//            default : break
//                
//                
//            }
//        })
//    }
//    
//    func fetchTicketsData(page: String){
//        
//        print(UserDataSingleton.sharedInstance.loggedInUser?.access_token ?? "")
//        
//        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.ticketPosts_View(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page: page)), completion: { (response) in
//            
//            switch response{
//                
//            case .success(let data) :
//                
//                print(data ?? "")
//                let x = data as? [TicketPostViewModel]
//                print(x?[0].name ?? "")
//                
//                UserDataSingleton.sharedInstance.ticketsData = data as? [TicketPostViewModel]
//                self.dataSource = {
//                    var array: [UIView] = []
//                    
//                    let count:Int = ((UserDataSingleton.sharedInstance.ticketsData?.count))!
//                    if count != 0{
//                        for _ in 1...count {
//                            array.append(self.viewType[0])
//                        }
//                    }
//                    
//                    return array
//                }()
//                self.initialise()
//                
//            case .failureMessage(let message):
//                print("failure")
//                UtilityFunctions.showAlert(message: message, controller: self)
//            default : break
//                
//            }
//        })
//    }
//    
//    func fetchOthersData(page: String){
//        
//        print(UserDataSingleton.sharedInstance.loggedInUser?.access_token ?? "")
//        
//        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.otherPosts_View(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page: page)), completion: { (response) in
//            
//            switch response{
//                
//            case .success(let data) :
//                
//                print(data ?? "")
//                let x = data as? [OtherPostViewModel]
//                print(x?[0].name ?? "")
//                
//                UserDataSingleton.sharedInstance.othersData = data as? [OtherPostViewModel]
//                self.dataSource = {
//                    var array: [UIView] = []
//                    
//                    let count:Int = ((UserDataSingleton.sharedInstance.othersData?.count))!
//                    if count != 0{
//                        for _ in 1...count {
//                            array.append(self.viewType[0])
//                        }
//                    }
//                    
//                    return array
//                }()
//                self.initialise()
//                
//            case .failureMessage(let message):
//                print("failure")
//                UtilityFunctions.showAlert(message: message, controller: self)
//            default : break
//                
//            }
//        })
//    }
//    
//    func fetchRidesData(page:String, type: String){
//        
//        print(UserDataSingleton.sharedInstance.loggedInUser?.access_token ?? "")
//        
//        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.ridePosts_View(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page: type, type: page)), completion: { (response) in
//            
//            switch response{
//                
//            case .success(let data) :
//                
//                print(data ?? "")
//                let x = data as? [RidePostViewModel]
//                print(x?[0].firstname ?? "")
//                
//                if(type == "0"){
//                    UserDataSingleton.sharedInstance.rideDataLookingForRide = data as? [RidePostViewModel]
//                    self.dataSource = {
//                        var array: [UIView] = []
//                        
//                        let count:Int = ((UserDataSingleton.sharedInstance.rideDataLookingForRide?.count))!
//                        if count != 0{
//                            for _ in 1...count {
//                                array.append(self.viewType[1])
//                            }
//                        }
//                        
//                        return array
//                    }()
//                    self.initialise()
//
//                }else{
//                    UserDataSingleton.sharedInstance.rideDataLookingForPassenger = data as? [RidePostViewModel]
//                    self.dataSource = {
//                        var array: [UIView] = []
//                        
//                        let count:Int = ((UserDataSingleton.sharedInstance.rideDataLookingForPassenger?.count))!
//                        if count != 0{
//                                for _ in 1...count {
//                                array.append(self.viewType[1])
//                            }
//                        }
//                        return array
//
//                    }()
//                    self.initialise()
//
//                }
//                
//                
//                
//            case .failureMessage(let message):
//                print("failure")
//                UtilityFunctions.showAlert(message: message, controller: self)
//            default : break
//                
//                
//            }
//        })
//    }
//    
//    func fetchServicesData(page:String, type: String){
//        
//        print(page,type)
//        print(UserDataSingleton.sharedInstance.loggedInUser?.access_token ?? "")
//        
//        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.servicePosts_View(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, page: type, type: page)), completion: { (response) in
//            
//            switch response{
//                
//            case .success(let data) :
//                
//                print(data ?? "")
//                let x = data as? [ServicePostViewModel]
//                print(x?[0].name ?? "")
//                
//                if(type == "2"){
//                    UserDataSingleton.sharedInstance.serviceDataLookforService = data as? [ServicePostViewModel]
//                    self.dataSource = {
//                        var array: [UIView] = []
//                        
//                        let count:Int = ((UserDataSingleton.sharedInstance.serviceDataLookforService?.count))!
//                        if count != 0{
//                            for _ in 1...count {
//                                array.append(self.viewType[2])
//                            }
//                        }
//                        
//                        return array
//                    }()
//                    self.initialise()
//                }else{
//                    UserDataSingleton.sharedInstance.serviceDataOfferAService = data as? [ServicePostViewModel]
//                    self.dataSource = {
//                        var array: [UIView] = []
//                        
//                        let count:Int = ((UserDataSingleton.sharedInstance.serviceDataOfferAService?.count))!
//                        if count != 0{
//                            for _ in 1...count {
//                                array.append(self.viewType[2])
//                            }
//                        }
//                        
//                        return array
//                    }()
//                    self.initialise()
//                }
//                
//            case .failureMessage(let message):
//                print("failure")
//                UtilityFunctions.showAlert(message: message, controller: self)
//            default : break
//                
//                
//            }
//        })
//    }
//}
