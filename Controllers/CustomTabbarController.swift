//
//  CustomTabbarController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 03/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class CustomTabbarController: UITabBarController {

//MARK:- VARIABLES
    var menuButton:UIButton! = nil

//MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiddleButton()
        
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.6)
        } else {
           
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showMenuButton), name: NSNotification.Name(rawValue: "showMenuButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenuButton), name: NSNotification.Name(rawValue: "hideMenuButton"), object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
//MARK:- FUNCTIONS
    func showMenuButton(){
        menuButton.isHidden = false
    }
    
    func hideMenuButton(){
        menuButton.isHidden = true
    }
    
    func setupMiddleButton() {
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 5
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor.white
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(UIImage(named: "ic_add"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
// MARK: - BTN ACTIONS
    // plus button action in the tabBar
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
    }
    
  
}
