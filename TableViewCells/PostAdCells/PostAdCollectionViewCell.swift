//
//  PostAdCollectionViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 22/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PostAdCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var lbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 2
        btn.layer.borderColor = appColor.cgColor
        btn.isHidden = true

        lbl.layer.cornerRadius = 20
        lbl.layer.borderWidth = 2
        lbl.layer.borderColor = appColor.cgColor
    }
    
}
