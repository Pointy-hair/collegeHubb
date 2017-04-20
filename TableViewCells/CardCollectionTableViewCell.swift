//
//  CardCollectionTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 11/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CardCollectionTableViewCell: UITableViewCell {
    
    var arrayImages = [imageModal]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CardCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(arrayImages )
        return (arrayImages.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardDetailImageCollectionViewCell", for: indexPath as IndexPath) as! CardDetailImageCollectionViewCell
        
        print(arrayImages)
        cell.imgView?.sd_setImage(with: URL(string: (arrayImages[indexPath.row].image100).unwrap()
))
        //imageView2.sd_setImage(with : URL(string:arrayOfFruits[indexPath.row]))
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
}
