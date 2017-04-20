//
//  FavouriteBooksTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 29/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import Foundation

class FavouriteBooksTableViewCell: UITableViewCell {
    
//MARK::- CELL VARIABLES
    var productImages = [String?](){
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }
    }

//MARK::- CELL OUTLETS
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblBookTitle: UILabel!
    
//MARK::- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }

}
//MARK::- COLLECTION VIEW DELEGATES
extension FavouriteBooksTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  UIScreen.main.bounds.width/5
        let height = cellWidth
        return CGSize(width : cellWidth,height : height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteBooksCollectionCell", for: indexPath) as? FavouriteBooksCollectionViewCell else {return UICollectionViewCell()}
        cell.imgFavouriteBookImage.sd_setImage(with: URL(string: productImages[indexPath.item].unwrap()))
        if(indexPath.item == 3) {
            cell.lblRemainingImagesCount.backgroundColor = UIColor.black.withAlphaComponent(0.50)
            cell.lblRemainingImagesCount.isOpaque = true
            var imagesLeft = (productImages.count) - 4
            cell.lblRemainingImagesCount.text = "\(imagesLeft)"
        }
        else {
            cell.lblRemainingImagesCount.isOpaque = false
        }
        
        return cell
    }
    
}
