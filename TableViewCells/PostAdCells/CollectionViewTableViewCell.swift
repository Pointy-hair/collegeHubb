//
//  CollectionViewTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 21/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    var arrayTexts = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


