//
//  HomeScreenBookTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 06/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class HomeScreenBookTableViewCell: UITableViewCell {
    
//MARK::- CELL VARIABLE
    var productImages = [String?](){
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }
    }
    
    //MARK::- CELL OUTLETS
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imgProfileImage: UIImageView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var lblTitleOfBook: UILabel!
    
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
extension HomeScreenBookTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
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
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeScreenBookCollectionViewCell", for: indexPath) as? HomeScreenBookCollectionViewCell else {return UICollectionViewCell()}
        cell.imgBookImages?.sd_setImage(with: URL(string: (productImages[indexPath.row]).unwrap()))
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
