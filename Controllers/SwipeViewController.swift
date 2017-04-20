//
//  SwipeViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

private var numberOfCards: Int = 6

class SwipeViewController: UIViewController {
}
////MARK: - Enums & Structs
//    
//    enum position: String{
//        case left = "left"
//        case center = "center"
//        case right = "right"
//    }
//    
//    struct btnPlacement{
//        var item : position
//        var ride : position
//        var service : position
//        
//        init(item: position, ride: position, service: position){
//            self.item = item
//            self.ride = ride
//            self.service = service
//        }
//    }
//    
////MARK: - Variables
//    let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//    var pageViewController: UIPageViewController?
//    var structPlacement: btnPlacement?
//    var CardVC : CardViewController?
//    let cornerRadius: CGFloat = 24
//    let animationDuration :TimeInterval = 0.4
//    let animationDelay :TimeInterval = 0
//    var controllers : [CardViewController] {
//        get {
//            return [
//            
//                self.storyboard!.instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
//            ]
//        }
//    }
//    
////MARK: - Outlets
//    @IBOutlet weak var btnItem: UIButton!
//    @IBOutlet weak var btnRide: UIButton!
//    @IBOutlet weak var btnService: UIButton!
//    @IBOutlet weak var stackView: UIStackView!
//
//    
////MARK:- Button Actions
//    @IBAction func btnItemAction(_ sender: UIButton) {
//        CardVC =  self.storyboard!.instantiateViewController(withIdentifier:  "CardViewController") as? CardViewController
//        CardVC?.currentPage = pageName.item.rawValue
//        let titleService = pageName.service
//        let titleRide = pageName.ride
//        
//        let position = structPlacement?.item
//        switch position {
//        case .left?:
//            
//            self.btnService.setTitle("", for: UIControlState.normal)
//
//            pageViewController!.setViewControllers([CardVC!], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
//
//            UIView.animate(withDuration: animationDuration, delay: animationDelay, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                
//                //Animate Position
//                let temp = self.btnItem.x
//                self.btnItem.x = self.btnRide.x
//                self.btnRide.x = self.btnService.x
//                self.btnService.x = temp
//                
//                //Change buttons UI
//                self.btnItem.layer.cornerRadius = self.cornerRadius
//                self.btnItem.backgroundColor = UIColor.white
//                self.btnItem.setTitleColor(appColor, for: UIControlState.normal)
//                
//                self.btnRide.backgroundColor = UIColor.clear
//                self.btnRide.setTitleColor(UIColor.white, for: UIControlState.normal)
//                
//                self.view.layoutIfNeeded()
//            }, completion: {finished in
//                self.btnService.setTitle(titleService.rawValue, for: UIControlState.normal)}
//            );
//            
//            let tempStruct = btnPlacement(item: .center, ride: .right, service: .left)
//            structPlacement = tempStruct
//            
//        case .center?:
//            return
//            
//        case .right?:
//            
//            self.btnRide.setTitle("", for: UIControlState.normal)
//
//            pageViewController!.setViewControllers([CardVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
//
//            
//            UIView.animate(withDuration: animationDuration, delay: animationDelay, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                
//                //Animate Position
//                let temp = self.btnItem.x
//                self.btnItem.x = self.btnService.x
//                self.btnService.x = self.btnRide.x
//                self.btnRide.x = temp
//                
//                //Change buttons UI
//                self.btnItem.layer.cornerRadius = self.cornerRadius
//                self.btnItem.backgroundColor = UIColor.white
//                self.btnItem.setTitleColor(appColor, for: UIControlState.normal)
//                
//                self.btnService.backgroundColor = UIColor.clear
//                self.btnService.setTitleColor(UIColor.white, for: UIControlState.normal)
//                
//                self.view.layoutIfNeeded()
//            }, completion: {finished in
//                self.btnRide.setTitle(titleRide.rawValue, for: UIControlState.normal)}
//            );
//            
//            let tempStruct = btnPlacement(item: .center, ride: .right, service: .left)
//            structPlacement = tempStruct
//            
//        default:
//            return
//        }
//    }
//    
//    @IBAction func btnRideAction(_ sender: UIButton) {
//        CardVC =  self.storyboard!.instantiateViewController(withIdentifier:  "CardViewController") as? CardViewController
//        CardVC?.currentPage = pageName.ride.rawValue
//        let titleService = pageName.service
//        let titleItem = pageName.item
//
//        let position = structPlacement?.ride
//        switch position {
//        case .left?:
//            
//            self.btnItem.setTitle("", for: UIControlState.normal)
//            
//            pageViewController!.setViewControllers([CardVC!], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
//            
//            
//            UIView.animate(withDuration: animationDuration, delay: animationDelay, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                
//                //Animate Position
//                let temp = self.btnRide.x
//                self.btnRide.x = self.btnService.x
//                self.btnService.x = self.btnItem.x
//                self.btnItem.x = temp
//                
//                //Change buttons UI
//                self.btnRide.layer.cornerRadius = self.cornerRadius
//                self.btnRide.backgroundColor = UIColor.white
//                self.btnRide.setTitleColor(appColor, for: UIControlState.normal)
//                
//                self.btnService.backgroundColor = UIColor.clear
//                self.btnService.setTitleColor(UIColor.white, for: UIControlState.normal)
//                
//                self.view.layoutIfNeeded()
//            }, completion: {finished in
//                self.btnItem.setTitle(titleItem.rawValue, for: UIControlState.normal)}
//            );
//            
//            let tempStruct = btnPlacement(item: .left, ride: .center, service: .right)
//            structPlacement = tempStruct
//            
//        case .center?:
//            return
//            
//        case .right?:
//            
//            self.btnService.setTitle("", for: UIControlState.normal)
//            
//            pageViewController!.setViewControllers([CardVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
//            
//            
//            UIView.animate(withDuration: animationDuration, delay: animationDelay, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                
//                //Animate Position
//                let temp = self.btnRide.x
//                self.btnRide.x = self.btnItem.x
//                self.btnItem.x = self.btnService.x
//                self.btnService.x = temp
//                
//                //Change buttons UI
//                self.btnRide.layer.cornerRadius = self.cornerRadius
//                self.btnRide.backgroundColor = UIColor.white
//                self.btnRide.setTitleColor(appColor, for: UIControlState.normal)
//                
//                self.btnItem.backgroundColor = UIColor.clear
//                self.btnItem.setTitleColor(UIColor.white, for: UIControlState.normal)
//                
//                self.view.layoutIfNeeded()
//            }, completion: {finished in
//                self.btnService.setTitle(titleService.rawValue, for: UIControlState.normal)}
//            );
//            
//            let tempStruct = btnPlacement(item: .left, ride: .center, service: .right)
//            structPlacement = tempStruct
//         
//        default:
//            return
//        }
//
//    }
//    
//    @IBAction func btnServiceAction(_ sender: UIButton) {
//        CardVC =  self.storyboard!.instantiateViewController(withIdentifier:  "CardViewController") as? CardViewController
//        CardVC?.currentPage = pageName.service.rawValue
//        let titleRide = pageName.ride
//        let titleItem = pageName.item
//
//        let position = structPlacement?.service
//        switch position {
//        case .left?:
//            
//            self.btnRide.setTitle("", for: UIControlState.normal)
//            
//            pageViewController!.setViewControllers([CardVC!], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
//            
//            
//            UIView.animate(withDuration: animationDuration, delay: animationDelay, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                
//                //Animate Position
//                let temp = self.btnService.x
//                self.btnService.x = self.btnItem.x
//                self.btnItem.x = self.btnRide.x
//                self.btnRide.x = temp
//                
//                //Change buttons UI
//                self.btnService.layer.cornerRadius = self.cornerRadius
//                self.btnService.backgroundColor = UIColor.white
//                self.btnService.setTitleColor(appColor, for: UIControlState.normal)
//                
//                self.btnItem.backgroundColor = UIColor.clear
//                self.btnItem.setTitleColor(UIColor.white, for: UIControlState.normal)
//                
//                self.view.layoutIfNeeded()
//            }, completion: {finished in
//                self.btnRide.setTitle(titleRide.rawValue, for: UIControlState.normal)}
//            );
//            
//            let tempStruct = btnPlacement(item: .right, ride: .left, service: .center)
//            structPlacement = tempStruct
//            
//        case .center?:
//            return
//            
//        case .right?:
//            
//            self.btnItem.setTitle("", for: UIControlState.normal)
//            
//            pageViewController!.setViewControllers([CardVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
//            
//            UIView.animate(withDuration: animationDuration, delay: animationDelay, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                
//                let temp = self.btnService.x
//                self.btnService.x = self.btnRide.x
//                self.btnRide.x = self.btnItem.x
//                self.btnItem.x = temp
//                
//                //Change buttons UI
//                self.btnService.layer.cornerRadius = self.cornerRadius
//                self.btnService.backgroundColor = UIColor.white
//                self.btnService.setTitleColor(appColor, for: UIControlState.normal)
//                
//                self.btnRide.backgroundColor = UIColor.clear
//                self.btnRide.setTitleColor(UIColor.white, for: UIControlState.normal)
//                
//                self.view.layoutIfNeeded()
//            }, completion: {finished in
//                self.btnItem.setTitle(titleItem.rawValue, for: UIControlState.normal)}
//            );
//            
//            let tempStruct = btnPlacement(item: .right, ride: .left, service: .center)
//            structPlacement = tempStruct
//            
//        default:
//            return
//        }
//    }
//    
////MARK: - View Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.navBar?.isHidden = true
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        
//        UserDefaults.standard.set(itemSubCategory.books.rawValue, forKey: userPrefrences.currentTabForItem.rawValue)
//        UserDefaults.standard.set(rideSubCategory.lookForRide.rawValue, forKey: userPrefrences.currentTabForRide.rawValue)
//        UserDefaults.standard.set(serviceSubCategory.lookForService.rawValue, forKey: userPrefrences.currentTabForService.rawValue)
//        
////        NotificationCenter.default.addObserver(self,
////                                               selector: #selector(SwipeViewController.receiveFromKoloda(_:)),
////                                               name: NSNotification.Name(rawValue: "BringKolodaViewToFront"),
////                                               object: nil)
//                
//        let result = UserDefaults.standard.value(forKey: userPrefrences.currentTabForRide.rawValue) as! String
//        
//        if result == rideSubCategory.lookForRide.rawValue{
//            print("x")
//        }else{
//            print("y")
//        }
//        print(result)
//
//        setupPageViewController()
//        self.view.bringSubview(toFront:stackView)
//
//    }
//    
////    @objc func receiveFromKoloda(_ notification: NSNotification) {
////        if notification.name.rawValue == "BringKolodaViewToFront" {
//////            self.view.bringSubview(toFront: (CardVC?.kolodaView)!)
////        }
////    }
//
//    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true);
//    }
////MARK:- FUNCTIONS    
//    func setupPageViewController(){
//        CardVC =  self.storyboard!.instantiateViewController(withIdentifier: "CardViewController") as? CardViewController
//        structPlacement = btnPlacement(item: .left, ride: .center, service: .right)
//        CardVC?.currentPage = pageName.ride.rawValue
//        
//        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
//        pageController.setViewControllers([CardVC!], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
//        pageViewController = pageController
//        addChildViewController(pageViewController!)
//        self.view.addSubview(pageViewController!.view)
//        pageViewController!.didMove(toParentViewController: self)
//    }
//    
//    // MARK: - Memory Management
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}


