//
//  PopularNearbyTicketsTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PopularNearbyTicketsTableViewCell: UITableViewCell {

    
    //MARK::- CELL VARIABLES
    var tickets = [TicketPostViewModel]()
    
    
    //MARK::- CELL OUTLETS
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
//MARK::- COLLECTION VIEW DELEGATES
extension PopularNearbyTicketsTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  UIScreen.main.bounds.width/1.7
        let height = collectionView.bounds.height
        return CGSize(width : cellWidth,height : height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularNearbyTicketsCollectionViewCell", for: indexPath) as? PopularNearbyTicketsCollectionViewCell else {return UICollectionViewCell()}
        cell.lblPrice.text = "$" +  (tickets[indexPath.row].price).unwrap()
        cell.lblTicketsTitle.text = (tickets[indexPath.row].name).unwrap()
        cell.imgProfileImage?.sd_setImage(with: URL(string: (tickets[indexPath.row].image100).unwrap()))
        cell.lblTimeLeft.text = (tickets[indexPath.row].duration).unwrap() + "Hour Left"
        let  dateIs = (tickets[indexPath.row].date)
        let dateString = dateIs?.toDateTime()
        cell.lblDateDay.text = dateString.unwrap()
        return cell
    }
    
}
