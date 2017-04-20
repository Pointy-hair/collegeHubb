//
//  PopularNearbyCarpoolTableViewCell.swift
//  CollegeHub
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PopularNearbyCarpoolTableViewCell: UITableViewCell {
    
    //MARK::- CELL VARIABLES
    var carpool =  [RidePostViewModel]()

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
extension PopularNearbyCarpoolTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return carpool.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  UIScreen.main.bounds.width/1.7
        let height = collectionView.bounds.height
        return CGSize(width : cellWidth,height : height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularNearbyCarpoolCollectionViewCell", for: indexPath) as? PopularNearbyCarpoolCollectionViewCell else {return UICollectionViewCell()}
            cell.lblDestinationName.text = (carpool[indexPath.row].departure).unwrap() + " to " + (carpool[indexPath.row].destination).unwrap()
            cell.lblPrice.text = "$" + (carpool[indexPath.row].price).unwrap()
            let  dateIs = (carpool[indexPath.row].leaving_on)
            let dateString = dateIs?.toDateTime()
            cell.lblDayAndDate.text = dateString.unwrap()
//        let url = URL(string: (carpool[indexPath.row].image100).unwrap())
//        cell.imgProfileImage?.sd_setImage(with:url, placeholderImage: placeHolderImage)
            cell.imgProfileImage?.sd_setImage(with: URL(string: (carpool[indexPath.row].image100).unwrap()))
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let HomeStoryBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//        switch indexPath.row{
//        //Carpool
//        case 1:
//            let myHomeVC = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageCarpoolViewController") as! HomePageCarpoolViewController
//             UIApplication.shared.keyWindow?.rootViewController?.presentVC(myHomeVC)
//           // self.navigationController?.pushViewController(myHomeVC, animated: true)
//            //edited
//            
//        //Services
//        case 2:
//            let myHomeVC  = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageServiceViewController") as! HomePageServiceViewController
//             UIApplication.shared.keyWindow?.rootViewController?.presentVC(myHomeVC)
//            //self.navigationController?.pushViewController(myHomeVC , animated: true)
//            
//        //Ticket
//        case 3:
//            let myHomeVC  = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageTicketViewController") as! HomePageTicketViewController
//             UIApplication.shared.keyWindow?.rootViewController?.presentVC(myHomeVC)
//            //self.navigationController?.pushViewController(myHomeVC , animated: true)
//            
//        //Book
//        case 4:
//            let myHomeVC  = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageBookViewController") as! HomePageBookViewController
//             UIApplication.shared.keyWindow?.rootViewController?.presentVC(myHomeVC)
//            //self.navigationController?.pushViewController(myHomeVC , animated: true)
//            
//        //Item
//        case 5:
//            let myHomeVC  = HomeStoryBoard.instantiateViewController(withIdentifier: "HomePageItemViewController") as! HomePageItemViewController
//             UIApplication.shared.keyWindow?.rootViewController?.presentVC(myHomeVC)
//            //self.navigationController?.pushViewController(myHomeVC , animated: true)
//            
//        default:
//            return
//        }
//
//    }
//    
}
