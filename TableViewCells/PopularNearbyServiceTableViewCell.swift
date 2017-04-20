//
//  PopularNearbyServiceTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import SDWebImage

class PopularNearbyServiceTableViewCell: UITableViewCell {
    
    //MARK::- CELL VARIABLES
    var services = [ServicePostViewModel]()

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
extension PopularNearbyServiceTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (services.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  UIScreen.main.bounds.width/1.7
        let height = collectionView.bounds.height
        return CGSize(width : cellWidth,height : height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularNearbyServiceCollectionViewCell", for: indexPath) as? PopularNearbyServiceCollectionViewCell else {return UICollectionViewCell()}
        cell.lblPrice.text = "$" +  (services [indexPath.row].price).unwrap()
        cell.lblDurationOfService.text = (services [indexPath.row].duration).unwrap() + "Hours"
        cell.lblServiceName.text = (services [indexPath.row].service_name).unwrap()
        cell.imgProfileImage?.sd_setImage(with: URL(string: (services [indexPath.row].image100).unwrap()))
//        let url = URL(string: (services[indexPath.row].image100).unwrap())
//        cell.imgProfileImage?.sd_setImage(with:url, placeholderImage: placeHolderImage)
        return cell
    }
    
}
