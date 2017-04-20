//
//  MatchesCollectionViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 09/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {
    
//MARK:- CELL OUTLETS
    @IBOutlet weak var imgView: UIImageView!

//MARK:- CELL LIFE CYCLE
    override func awakeFromNib() {
        imgView.layer.cornerRadius = imgView.frame.width/2
        imgView.clipsToBounds = true
    }
}
