//
//  BiddingViewController.swift
//  CollegeHub
//
//  Created by Sierra 4 on 27/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class BiddingViewController: UIViewController {

//MARK::- VC OUTLETS
    @IBOutlet var tblView: UITableView!

//MARK::- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView?.rowHeight = UITableViewAutomaticDimension;
        self.tblView?.estimatedRowHeight = 212;//(Maximum Height that should be assigned to your cell)
        tblView.delegate = self
        tblView.dataSource = self
    }


//MARK::- BTN ACTIONS

}

//MARK::- TABLE VIEW DELEGATES
extension BiddingViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.biddingCell.rawValue , for: indexPath) as? BiddingTableViewCell  else {return UITableViewCell() }
        return cell
        
        
    }
    
    
}

