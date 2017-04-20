//
//  PostAdViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class PostAdViewController: UIViewController {

//MARK:- OUTLETS
    @IBOutlet weak var rideBtn: UIButton!
    @IBOutlet weak var serviceBtn: UIButton!
    @IBOutlet weak var itemsBtn: UIButton!
    
//MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBar?.isHidden = true
        
        rideBtn.layer.cornerRadius = btnRadius
        itemsBtn.layer.cornerRadius = btnRadius
        serviceBtn.layer.cornerRadius = btnRadius
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navBar?.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "showMenuButton"),
            object: nil,
            userInfo:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//MARK:- BTN ACTION    
    @IBAction func rideBtnAction(_ sender: UIButton) {
        let AddAdVc = self.storyboard?.instantiateViewController(withIdentifier: "AddAdViewController") as! AddAdViewController
        self.navigationController?.pushViewController(AddAdVc, animated: true)
    }
    
    @IBAction func serviceBtnAction(_ sender: UIButton) {
    }
    @IBAction func itemsBtnAction(_ sender: UIButton) {
    }


}
