//
//  OnBoardingViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 24/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var pendingIndex: Int?
    var pageControlIndex: Int = 0
    
    @IBOutlet weak var pageControl: UIPageControl!
    var pageViewController: UIPageViewController?
    let onboardingImages = ["img_onboard_1",
                            "img_onboard_2",
                            "img_onboard_3",
                            "img_onboard_4"]
    let onboardingTexts = ["Go Places.\nShareRides.\nMeet other\ncollege students.",
                           "Exchange time & skill with other college students.",
                           "Buy & sell\nwith other\ncollege students.",
                           "Match with commitment"]
    
    @IBOutlet weak var btnSignInRegister: UIButton!
    @IBAction func btnSignRegisterAction(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController()
        setupPageControl()
        initialise()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navBar?.isHidden = true
    }
    
    func initialise(){
        self.navBar?.isHidden = true

        btnSignInRegister.layer.cornerRadius = btnRadius
        self.view.bringSubview(toFront: btnSignInRegister)
        self.view.bringSubview(toFront: pageControl)

    }
    
    func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        pageController.dataSource = self
//        pageController.isDoubleSided = true
        
        if onboardingImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
    }
    
    func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.clear
    }
    
    func getItemController(_ itemIndex: Int) -> OnBoardingPageItemViewController? {
        
        if itemIndex < onboardingImages.count {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "ItemController") as! OnBoardingPageItemViewController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = onboardingImages[itemIndex]
            pageItemController.labelText = onboardingTexts[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: PageView Datasource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        pageControlIndex -= 1
        pageControl.currentPage = pageControlIndex
        let itemController = viewController as! OnBoardingPageItemViewController
        if itemController.itemIndex > 0 {
            
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        pageControlIndex += 1
        pageControl.currentPage = pageControlIndex
        let itemController = viewController as! OnBoardingPageItemViewController
        if itemController.itemIndex+1 < onboardingImages.count {
            
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }

    
    // MARK: - Page Indicator
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return onboardingImages.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
    // MARK: - Additions
    
    func currentControllerIndex() -> Int {
        
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? OnBoardingPageItemViewController {
            return controller.itemIndex
        }
        
        return -1
    }
    
    func currentController() -> UIViewController? {
        
        if (self.pageViewController?.viewControllers?.count)! > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        return nil
    }
    
    //MARK: Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
