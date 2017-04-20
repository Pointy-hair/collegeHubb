//
//  MatchesTableViewCell.swift
//  CollegeHub
//
//  Created by Sumanpreet on 09/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {

//MARK:- CELL OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!

//MARK:- CELL VARIABLES
    var arrayMatches = [MessageModel]()
    
//MARK:- CELL LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

//MARK:- COLLECTION VIEW DELEGATES
extension MatchesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMatches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchesCollectionViewCell", for: indexPath as IndexPath) as! MatchesCollectionViewCell
        
        cell.imgView?.sd_setImage(with: URL(string: (arrayMatches[indexPath.row].image100).unwrap()))
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
// MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
}
