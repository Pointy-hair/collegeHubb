//
//  CardDetailViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
}
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var btnHeart: UIButton!
//    @IBOutlet weak var btnCross: UIButton!
//    @IBAction func btnCrossAction(_ sender: Any) {
//    }
//    
//    @IBAction func btnHeartAction(_ sender: Any) {
//    }
//    
////    @IBAction func btnBack(_ sender: Any) {
////        _ = self.navigationController?.popViewController(animated: true)
////        
////    }
//    var cardIndex: Int!
//    var currentPage:String?
//    var currentData:AnyObject?
//    var collectionViewVisible = false
//    var emptyCells = [IndexPath]()
//    
//    typealias CellToIdentifier = (cell: UITableViewCell, identifier: String)
//    
//    let arrayRideCells : [CellToIdentifier] = [(CardRideTableViewCell(),"CardRideTableViewCell"),
//                                               (CardOwnerTableViewCell(),"CardOwnerTableViewCell"),
//                                               (CardSegmentTableViewCell(),"CardSegmentTableViewCell"),
//                                               (CardStopsTableViewCell(),"CardStopsTableViewCell"),
//                                               (CardPriceTableViewCell(),"CardPriceTableViewCell"),
//                                               (CardAboutTableViewCell(),"CardAboutTableViewCell")
//                                                ]
//    
//    let arrayItemCells : [CellToIdentifier] = [(CardCollectionTableViewCell(),"CardCollectionTableViewCell"),
//                                               (CardTitleTableViewCell(),"CardTitleTableViewCell"),
//                                               (CardOwnerTableViewCell(),"CardOwnerTableViewCell"),
//                                               (CardPriceTableViewCell(),"CardPriceTableViewCell"),
//                                               (CardSegmentTableViewCell(),"CardSegmentTableViewCell"),
//                                               //(CardLocationTableViewCell(),"CardLocationTableViewCell"),
//                                               (CardAboutTableViewCell(),"CardAboutTableViewCell")
//                                                ]
//    
//    let arrayServiceCells : [CellToIdentifier] = [(CardTitleTableViewCell(),"CardTitleTableViewCell"),
//                                                  (CardOwnerTableViewCell(),"CardOwnerTableViewCell"),
//                                                  (CardSegmentTableViewCell(),"CardSegmentTableViewCell"),
//                                                  //(CardLocationTableViewCell(),"CardLocationTableViewCell"),
//                                                  (CardPriceTableViewCell(),"CardPriceTableViewCell"),
//                                                  (CardAboutTableViewCell(),"CardAboutTableViewCell")
//                                                    ]
//    
//// MARK:- View LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.navBar?.isHidden = false
//        self.navBar?.tintColor = UIColor.white
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
//        self.navigationController?.navigationBar.topItem?.title = ""
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        
//        btnCross.layer.cornerRadius = btnCross.frame.width/2
//        btnHeart.layer.cornerRadius = btnHeart.frame.width/2
//        
//        tableView?.rowHeight = UITableViewAutomaticDimension;
//        tableView?.estimatedRowHeight = 1000;//(Maximum Height that should be assigned to your cell)
//
//        print(cardIndex ?? "")
//        print(currentPage ?? "")
//        setupData()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//
//        self.navigationController?.setNavigationBarHidden(false, animated: true);
//        self.navBar?.tintColor = UIColor.white
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
//
////MARK: - Setup TableView
//extension CardDetailViewController: UITableViewDelegate, UITableViewDataSource{
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let page = currentPage{
//            switch page{
//            case  pageName.item.rawValue:
//                return arrayItemCells.count
//            case  pageName.ride.rawValue:
//                return arrayRideCells.count
//            case  pageName.service.rawValue:
//                return arrayServiceCells.count
//            default: return 0
//            }
//        }
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if let page = currentPage{
//            switch page{
//            case  pageName.item.rawValue:
//                let cell = setUpCell(tableView: tableView, indexPath: indexPath, identifier: arrayItemCells[indexPath.row].identifier, cellType: arrayItemCells[indexPath.row].cell)
//                return cell
//            case  pageName.ride.rawValue:
//                let cell = setUpCell(tableView: tableView, indexPath: indexPath, identifier: arrayRideCells[indexPath.row].identifier, cellType: arrayRideCells[indexPath.row].cell)
//                return cell
//            case  pageName.service.rawValue:
//                let cell = setUpCell(tableView: tableView, indexPath: indexPath, identifier: arrayServiceCells[indexPath.row].identifier, cellType: arrayServiceCells[indexPath.row].cell)
//                return cell
//            default: break
//            }
//        }
//        
//        return UITableViewCell()
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        if emptyCells.count == 1{
//            if emptyCells[0] == indexPath{
//                return 0
//            }else{
//                return UITableViewAutomaticDimension
//            }
//        }else if emptyCells.count == 2{
//            if emptyCells[1] == indexPath{
//                return 0
//            }else{
//                return UITableViewAutomaticDimension
//            }
//        }else{
//            if collectionViewVisible == true{
//                collectionViewVisible = false
//                return 250
//            }else{
//                return UITableViewAutomaticDimension
//            }
//        }
//        
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
//}
//
//extension CardDetailViewController{
//
//    func setUpCell(tableView: UITableView, indexPath: IndexPath, identifier: String, cellType: UITableViewCell) -> UITableViewCell{
//        
////MARK:- Price Cell
//            if ((cellType as? CardPriceTableViewCell) != nil) {
//                
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardPriceTableViewCell  else {return UITableViewCell()}
//                cell.currentData = currentData
//                
//                if ((currentData as? RidePostViewModel) != nil){
//                    let data = currentData as! RidePostViewModel
//                    cell.lblPriceValue.text = "$ " + data.price!
//                }else if((currentData as? ServicePostViewModel) != nil){
//                    let data = currentData as! ServicePostViewModel
//                    cell.lblPriceValue.text = "$ " + data.price!
//                }else if((currentData as? BookPostViewModel) != nil){
//                    let data = currentData as! BookPostViewModel
//                    cell.lblPriceValue.text = "$ " + data.price!
//                }else if((currentData as? TicketPostViewModel) != nil){
//                    let data = currentData as! TicketPostViewModel
//                    cell.lblPriceValue.text = "$ " + data.price!
//                }else if((currentData as? OtherPostViewModel) != nil){
//                    let data = currentData as! OtherPostViewModel
//                    cell.lblPriceValue.text = "$ " + data.price!
//                }
//                
//                return cell
//
////MARK:- Title Cell
//
//            }else if ((cellType as? CardTitleTableViewCell) != nil) {
//                
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardTitleTableViewCell  else {return UITableViewCell()}
//                
//                if((currentData as? ServicePostViewModel) != nil){
//                    let data = currentData as! ServicePostViewModel
//                    cell.lblTitle.text = data.name
//                    
//                    if let des = data.Description, des != ""{
//                        cell.lblTitleDescription.text = data.Description
//                    }else{
//                        cell.lblTitleDescription.isHidden = true
//                    }
//                }else if((currentData as? BookPostViewModel) != nil){
//                    let data = currentData as! BookPostViewModel
//                    cell.lblTitle.text = data.name
//                    cell.lblTitleDescription.isHidden = true
//
//                    
//                }else if((currentData as? TicketPostViewModel) != nil){
//                    let data = currentData as! TicketPostViewModel
//                    cell.lblTitle.text = data.name
//                    cell.lblTitleDescription.isHidden = true
//
//
//                }else if((currentData as? OtherPostViewModel) != nil){
//                    let data = currentData as! OtherPostViewModel
//                    cell.lblTitle.text = data.name
//                    cell.lblTitleDescription.isHidden = true
//
//                }
//                
//                return cell
//
////MARK:- Owner Cell
//
//            }else if ((cellType as? CardOwnerTableViewCell) != nil) {
//                
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardOwnerTableViewCell  else {return UITableViewCell()}
//                
//                
//                if ((currentData as? RidePostViewModel) != nil){
//                    let data = currentData as! RidePostViewModel
//                    cell.lblOwner.text = "Ride Offered By:"
//                    cell.lblOwnerValue.text = data.firstname! + " " + data.lastname!
//                    if let img = data.image100 {
//                        cell.imgView.sd_setImage(with: NSURL.init(string: img) as URL!,placeholderImage: UIImage.init(named: "ic_profile_placeholder"))
//                    }
//                    
//                }else if((currentData as? ServicePostViewModel) != nil){
//                    
//                    let data = currentData as! ServicePostViewModel
//                    cell.lblOwner.text = "Service Offered By:"
//                    cell.lblOwnerValue.text = data.firstname! + " " + data.lastname!
//                    if let img = data.image100 {
//                        cell.imgView.sd_setImage(with: NSURL.init(string: img) as URL!,placeholderImage: UIImage.init(named: "ic_profile_placeholder"))
//                    }
//                
//                }else if((currentData as? BookPostViewModel) != nil){
//                        
//                    let data = currentData as! BookPostViewModel
//                    cell.lblOwner.text = "Onwer"
//                    cell.lblOwnerValue.text = data.firstname! + " " + data.lastname!
//                    if let img = data.image100 {
//                        cell.imgView.sd_setImage(with: NSURL.init(string: img) as URL!,placeholderImage: UIImage.init(named: "ic_profile_placeholder"))
//                        }
//                        
//                }else if((currentData as? TicketPostViewModel) != nil){
//                    let data = currentData as! TicketPostViewModel
//                        cell.lblOwner.text = "Sold By"
//                        cell.lblOwnerValue.text = data.firstname! + " " + data.lastname!
//                        if let img = data.image100 {
//                            cell.imgView.sd_setImage(with: NSURL.init(string: img) as URL!,placeholderImage: UIImage.init(named: "ic_profile_placeholder"))
//                        }
//                }else if((currentData as? OtherPostViewModel) != nil){
//                    let data = currentData as! OtherPostViewModel
//                        cell.lblOwner.text = "Onwer"
//                        cell.lblOwnerValue.text = data.firstname! + " " + data.lastname!
//                        if let img = data.image100 {
//                            cell.imgView.sd_setImage(with: NSURL.init(string: img) as URL!,placeholderImage: UIImage.init(named: "ic_profile_placeholder"))
//                }
//            }
//                return cell
//            
////MARK:- Ride Cell
//            }else if((cellType as? CardRideTableViewCell) != nil) {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardRideTableViewCell  else {return UITableViewCell()}
//
//                if ((currentData as? RidePostViewModel) != nil){
//                    let data = currentData as! RidePostViewModel
//                    cell.lblDeparture.text = data.departure
//                    cell.lblDestination.text = data.destination
//                    cell.viewBottom.addDashedLine()
//                    cell.viewTop.addDashedLine()
//                }
//                
//                return cell
//
////MARK:- Segment Cell
//            }else if((cellType as? CardSegmentTableViewCell) != nil) {
//                
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardSegmentTableViewCell  else {return UITableViewCell()}
//
//                
//                if ((currentData as? RidePostViewModel) != nil){
//                    let data = currentData as! RidePostViewModel
//                    cell.lblSegment1.text = "Leaving On"
//                    cell.lblSegment1Value.text = data.leaving_on
//                    cell.lblSegment2.text = "Departure Time"
//                    cell.lblSegment2Value.text = data.departure_time
//                }else if((currentData as? ServicePostViewModel) != nil){
//                    let data = currentData as! ServicePostViewModel
//                    cell.lblSegment1.text = "Session Length"
//                    cell.lblSegment1Value.text = data.duration! + " mins"
//                    cell.lblSegment2.text = "Availability"
//                    cell.lblSegment2Value.text = "By Appointment"
//                }else if((currentData as? BookPostViewModel) != nil){
//                    let data = currentData as! BookPostViewModel
//                    cell.lblSegment1.text = "Edition"
//                    cell.lblSegment1Value.text = data.remaining_duration
//                    cell.lblSegment2.text = "Condition"
//                    
//                    //0 new_look, 1 good, 2 acceptable, 3 poor
//                    //let condition = data.condition?.toInt()
//                    let con = (data.condition_status)
////                    switch condition!{
////                    case 0: con = "new_look"
////                    case 1: con = "good"
////                    case 2: con = "acceptable"
////                    case 3: con = "poor"
////                    default: break
////                    }
//                    cell.lblSegment2Value.text = con
//                }else if((currentData as? TicketPostViewModel) != nil){
//                    let data = currentData as! TicketPostViewModel
//                    cell.lblSegment1.text = "Date"
//                    cell.lblSegment1Value.text = data.date
//                    cell.lblSegment2.text = "Time"
//                    cell.lblSegment2Value.text = data.date
//                }else if((currentData as? OtherPostViewModel) != nil){
//                    let data = currentData as! OtherPostViewModel
//                    emptyCells.append(indexPath)
//                }
//                
//                return cell
//
////MARK:- Stops Cell
//                
//            }else if((cellType as? CardStopsTableViewCell) != nil) {
//                
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardStopsTableViewCell  else {return UITableViewCell()}
//
//                
//                if ((currentData as? RidePostViewModel) != nil){
//                    let data = currentData as! RidePostViewModel
//                    if let stop1 = data.stop1, stop1 != ""{
//                        cell.lblStops.isHidden = false
//                        cell.lblStopsValue1.isHidden = false
//                        cell.lblStops.text = "Stops during the trip"
//                        cell.lblStopsValue1.text = "1. " + stop1
//                        if let stop2 = data.stop2, stop2 != ""{
//                            cell.lblStopsValue2.isHidden = false
//                            cell.lblStopsValue2.text = "2. " + stop2
//                            if let stop3 = data.stop3, stop3 != ""{
//                                cell.lblStopsValue3.isHidden = false
//                                cell.lblStopsValue3.text = "3. " + stop3
//                            }
//                        }
//                    }else{
//                        emptyCells.append(indexPath)
//                        print(emptyCells)
//                    }
//                }
//                
//                return cell
//
////MARK:- Collection Cell
//
//            }else if((cellType as? CardCollectionTableViewCell) != nil) {
//                
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardCollectionTableViewCell  else {return UITableViewCell()}
//
//                if((currentData as? BookPostViewModel) != nil){
//                    let data = currentData as! BookPostViewModel
//                    if let count = data.arrayImages?.count, count > 0{
//                        cell.arrayImages = data.arrayImages!
//                        collectionViewVisible = true
//                    }
//                }else if((currentData as? TicketPostViewModel) != nil){
//                    let data = currentData as! TicketPostViewModel
//                    if let count = data.arrayImages?.count, count > 0{
//                        cell.arrayImages = data.arrayImages!
//                        collectionViewVisible = true
//                    }
//                }else if((currentData as? OtherPostViewModel) != nil){
//                    let data = currentData as! OtherPostViewModel
//                    if let count = data.arrayImages?.count, count > 0{
//                        cell.arrayImages = data.arrayImages!
//                        collectionViewVisible = true
//                    }
//                }
//                
//                return cell
//                
////MARK:- About Cell
//            }else if((cellType as? CardAboutTableViewCell) != nil) {
//                
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardAboutTableViewCell  else {return UITableViewCell()}
//
////                if((currentData as? ServicePostViewModel) != nil){
////                    let data = currentData as! ServicePostViewModel
////                }else if((currentData as? BookPostViewModel) != nil){
////                    let data = currentData as! BookPostViewModel
////                }else if((currentData as? TicketPostViewModel) != nil){
////                    let data = currentData as! TicketPostViewModel
////                }else if((currentData as? OtherPostViewModel) != nil){
////                    let data = currentData as! OtherPostViewModel
////                }
//                
//                cell.stackView.isHidden = true
//                cell.isHidden = true
//                return cell
//             
////MARK:- Location Cell
//            }else if((cellType as? CardLocationTableViewCell) != nil) {
//                
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as? CardLocationTableViewCell  else {return UITableViewCell()}
//
//                if((currentData as? BookPostViewModel) != nil){
//                    let data = currentData as! BookPostViewModel
//                    cell.lblLocation.text = "Meetup At"
//                }else if((currentData as? TicketPostViewModel) != nil){
//                    let data = currentData as! TicketPostViewModel
//                }else if((currentData as? OtherPostViewModel) != nil){
//                    let data = currentData as! OtherPostViewModel
//                }
//                
//                return cell
//        }
//        
//        return UITableViewCell()
//    }
//    
//    
//    
//    func setupData(){
//        if let page = currentPage{
//            switch page{
//            case  pageName.item.rawValue:
//                
//                if ((UserDefaults.standard.value(forKey: userPrefrences.currentTabForItem.rawValue) as! String) == itemSubCategory.books.rawValue){
//                    
//                    currentData = UserDataSingleton.sharedInstance.booksData?[cardIndex]
//                    
//                }else if((UserDefaults.standard.value(forKey: userPrefrences.currentTabForItem.rawValue) as! String) == itemSubCategory.tickets.rawValue){
//                    
//                    currentData = UserDataSingleton.sharedInstance.ticketsData?[cardIndex]
//                    
//                }else{
//                    
//                    currentData = UserDataSingleton.sharedInstance.othersData?[cardIndex]
//                }
//                
//            case pageName.ride.rawValue:
//                
//                let result = UserDefaults.standard.value(forKey: userPrefrences.currentTabForRide.rawValue) as! String
//                if (result == rideSubCategory.lookForRide.rawValue){
//                    currentData = UserDataSingleton.sharedInstance.rideDataLookingForRide?[cardIndex]
//                    
//                }else if(result == rideSubCategory.lookForPassenger.rawValue){
//                    currentData = UserDataSingleton.sharedInstance.rideDataLookingForPassenger?[cardIndex]
//                    
//                }
//                
//            case pageName.service.rawValue:
//                
//                if ((UserDefaults.standard.value(forKey: userPrefrences.currentTabForService.rawValue) as! String) == serviceSubCategory.lookForService.rawValue){
//                    currentData = UserDataSingleton.sharedInstance.serviceDataLookforService?[cardIndex]
//                    
//                }else if((UserDefaults.standard.value(forKey: userPrefrences.currentTabForService.rawValue) as! String) == serviceSubCategory.offerAService.rawValue){
//                    currentData = UserDataSingleton.sharedInstance.serviceDataOfferAService?[cardIndex]
//                }
//            default: return
//            }
//        }
//    }
//
//}
//
//
