//
//  OnBoardingPageItemViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 24/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class OnBoardingPageItemViewController: UIViewController {

    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        didSet {
            if let imageView = onboardImage {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    var labelText: String = "" {
        didSet{
            if let label = onboardLabel{
                label.text = labelText
            }
        }
    }
    
    @IBOutlet weak var onboardImage: UIImageView?
    @IBOutlet weak var onboardLabel: UILabel?
    @IBOutlet weak var onboardLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardImage!.image = UIImage(named: imageName)
        if itemIndex == 3{
            onboardLabel!.text = labelText
            onboardLabel2.isHidden = false
            onboardLabel2.text = "Secured in-app payments.\nDesigned to lower back out rate."
        }else{
            onboardLabel!.text = labelText
            onboardLabel2.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
