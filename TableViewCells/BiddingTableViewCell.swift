//
//  BiddingTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 27/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class BiddingTableViewCell: UITableViewCell {

//MARK::- CELL OUTLETS
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imgUserProfileImgage: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblTitleTopBid: UILabel!
    @IBOutlet var lblTopBidAmount: UILabel!
    @IBOutlet var lblRating: UILabel!

//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
//MARK::- CELL BTN ACTIONS
    @IBAction func btnIncreaseBidAction(_ sender: Any) {
        
    }
}
//MARK::- COLLECTION VIEW DELEGATES
extension BiddingTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 4
}
    
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth =  self.collectionView.bounds.width/5
    let height = collectionView.bounds.height
    return CGSize(width : cellWidth,height : height)
    
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BiddingProductimageCell", for: indexPath) as? BiddingProductImagesCollectionViewCell else {return UICollectionViewCell()}
    
    if(indexPath.item == 3) {
        cell.lblImagesLeft.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        cell.lblImagesLeft.isOpaque = true
        cell.lblImagesLeft.text = "+2"
    }
    else {
        cell.lblImagesLeft.isOpaque = false
    }
    
    return cell
}

}
