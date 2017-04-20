//
//  HomeScreenItemTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 06/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class HomeScreenItemTableViewCell: UITableViewCell {
    
    var productImages = [String?](){
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }
    }
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var lblItemTitle: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblUserName: UILabel!
    
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
extension HomeScreenItemTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =    UIScreen.main.bounds.width/5
        let height = cellWidth
        return CGSize(width : cellWidth,height : height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeScreenItemCollectionViewCell", for: indexPath) as? HomeScreenItemCollectionViewCell else {return UICollectionViewCell()}
       cell.imgItemImages?.sd_setImage(with: URL(string: (productImages[indexPath.row]).unwrap()))
        if(indexPath.item == 3) {
            cell.lblImagesCount.backgroundColor = UIColor.black.withAlphaComponent(0.50)
            cell.lblImagesCount.isOpaque = true
            cell.lblImagesCount.text = "\((productImages.count) - 4)"
        }
        else {
            cell.lblImagesCount.isOpaque = false
        }
        
        return cell
    }
    
}
