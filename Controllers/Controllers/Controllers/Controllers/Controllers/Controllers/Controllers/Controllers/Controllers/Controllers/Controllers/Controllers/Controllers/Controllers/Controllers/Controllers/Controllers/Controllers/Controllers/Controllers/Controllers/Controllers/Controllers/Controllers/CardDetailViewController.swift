//
//  CardDetailViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {

    enum tableViewTypes{
        case bookDetail
        case ticketDetail
        case otherDetail
        case rideDetail
        case serviceDetail
    }
    
    enum cellTypes: String{
        case titleCell = "CardTitleTableViewCell"
        case locationCell = "CardLocationTableViewCell"
        case segmentCell = "CardSegmentTableViewCell"
        case ownerCell = "CardOwnerTableViewCell"
        case priceCell = "CardPriceTableViewCell"
        case aboutCell = "CardAboutTableViewCell"
        
        //Ride Specific
        case stopsCell = "CardStopsTableViewCell"
        case rideCell = "CardRideTableViewCell"
        
        //Item Specific
        case collectionCell = "CardCollectionTableViewCell"
    }
    
    struct cellOrder{
        var bookDetail : [cellTypes] = [.collectionCell,
                                        .titleCell,
                                        .ownerCell,
                                        .priceCell,
                                        .segmentCell,
                                        .locationCell,
                                        .aboutCell]
        //Similar for ticket and Other Item detail
        
        var rideDetail : [cellTypes] = [.rideCell,
                                        .ownerCell,
                                        .segmentCell,
                                        //.locationCell, //May be used here if required
                                        .stopsCell,
                                        .priceCell,
                                        .aboutCell]
        
        var serviceDetail : [cellTypes] = [.titleCell,
                                           .ownerCell,
                                           .segmentCell,
                                           .locationCell,
                                           .priceCell,
                                           .aboutCell]

    }
    
    func cellCountAndOrder(){
        // Calculate the cell count and order based on the data received
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - Setup TableView
extension CardDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardPriceTableViewCell" , for: indexPath) as? CardPriceTableViewCell  else {return UITableViewCell() }
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardOwnerTableViewCell" , for: indexPath) as? CardOwnerTableViewCell  else {return UITableViewCell() }
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardOwnerTableViewCell" , for: indexPath) as? CardOwnerTableViewCell  else {return UITableViewCell() }
                return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section no \(section)"
    }
    
}
