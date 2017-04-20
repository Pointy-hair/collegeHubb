//
//  PopularNearbyItemTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PopularNearbyItemTableViewCell: UITableViewCell {
    
    //MARK::- CELL VARIABLES
    var items = [OtherPostViewModel]()

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
extension PopularNearbyItemTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (items.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  UIScreen.main.bounds.width/1.7
        let height = collectionView.bounds.height
        return CGSize(width : cellWidth,height : height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularNearbyItemsCollectionViewCell", for: indexPath) as? PopularNearbyItemsCollectionViewCell else {return UICollectionViewCell()}
        cell.lblProductName.text = (items[indexPath.row].name).unwrap()
        cell.lblPrice.text = "$" + (items[indexPath.row].price).unwrap()
//        let url = URL(string: (items[indexPath.row].image100).unwrap())
//        cell.imgProfileImage?.sd_setImage(with:url, placeholderImage: placeHolderImage)
        cell.imgProfileImage?.sd_setImage(with: URL(string: (items[indexPath.row].image100).unwrap()))
        cell.lblTimeLeft.text = (items[indexPath.row].duration).unwrap() + "Hour Left"
        return cell
    }
    
}
