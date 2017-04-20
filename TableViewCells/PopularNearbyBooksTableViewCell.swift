//
//  PopularNearbyBooksTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PopularNearbyBooksTableViewCell: UITableViewCell {

    
    //MARK::- CELL VARIABLES
    var books  =  [BookPostViewModel]()
    
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
extension PopularNearbyBooksTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (books.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  UIScreen.main.bounds.width/1.7
        let height = collectionView.bounds.height
        return CGSize(width : cellWidth,height : height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularNearbyBooksCollectionViewCell", for: indexPath) as? PopularNearbyBooksCollectionViewCell else {return UICollectionViewCell()}
        cell.lblPrice.text = "$" + (books[indexPath.row].price).unwrap()
        cell.lblBookName.text = (books[indexPath.row].name).unwrap()
//        cell.imgProfileImage?.sd_setImage(with:URL(string: (books[indexPath.row].image100).unwrap()), placeholderImage: UIImage(imageLiteralResourceName: "ic_profile"))
        cell.imgProfileImage?.sd_setImage(with: URL(string: (books[indexPath.row].image100).unwrap()))
        cell.lblTimeLeft.text = (books[indexPath.row].duration).unwrap() + "Hour Left"
        return cell
    }
    
}
