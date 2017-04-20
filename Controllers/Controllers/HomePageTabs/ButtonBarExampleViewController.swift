//  ButtonBarExampleViewController.swift
//  XLPagerTabStrip ( https://github.com/xmartlabs/XLPagerTabStrip )
//
//  Copyright (c) 2017 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import SJSegmentedScrollView

class ButtonBarExampleViewController :  SJSegmentedViewController {
    
    
    //MARK:- PROPERTIES
    var selectedSegment: SJSegmentTab?
    let headerHeight : CGFloat = 60
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        segmentView()
        super.viewDidLoad()
    }
}

//MARK:- SEGMENTED VIEW
extension ButtonBarExampleViewController {
    
    func segmentView(){
       guard let headerVC = self.storyboard?.instantiateViewController(withIdentifier: "HeaderViewController") as? HeaderViewController else { return }
        let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        guard let child_1 = self.storyboard?.instantiateViewController(withIdentifier: "PopularNearbyViewController") as? PopularNearbyViewController else{ return  }
        child_1.title = "Popular Nearby"
        guard let child_2 = homeStoryboard.instantiateViewController(withIdentifier: "HomePageCarpoolViewController") as? HomePageCarpoolViewController else{ return  }
         child_2.title = "Carpool"
        guard let child_3 = homeStoryboard.instantiateViewController(withIdentifier: "HomePageServiceViewController") as? HomePageServiceViewController else{ return }
         child_3.title = "Service"
        guard let child_4 = homeStoryboard.instantiateViewController(withIdentifier: "HomePageTicketViewController") as? HomePageTicketViewController else{ return }
        child_4.title = "Tickets"
        guard let child_5 = homeStoryboard.instantiateViewController(withIdentifier: "HomePageBookViewController") as? HomePageBookViewController else{ return }
         child_5.title = "Books"
        guard let child_6 = homeStoryboard.instantiateViewController(withIdentifier: "HomePageItemViewController") as? HomePageItemViewController else{ return }
         child_6.title = "Items"
        headerViewController = headerVC
        segmentControllers = [child_1,child_2,child_3,child_4,child_5,child_6]
        headerViewHeight = headerHeight
        segmentViewHeight = 40.0
        selectedSegmentViewHeight = 2.0
        segmentTitleColor = UIColor(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1.0)
        selectedSegmentViewColor = appColor
        segmentShadow = SJShadow.light()
        delegate = self
    }
}

//MARK:- SEGMENTED VIEW DELEGATE
extension ButtonBarExampleViewController: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        switch index {
        case 0:
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "PopularData"),
                object: nil,
                userInfo:nil)
        case 1:
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "CarpoolData"),
                object: nil,
                userInfo:nil)
        case 2:
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ServicesData"),
                object: nil,
                userInfo:nil)
        case 4:
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "BooksData"),
                object: nil,
                userInfo:nil)
        case 3:
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "TicketsData"),
                object: nil,
                userInfo:nil)
        case 5:
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ItemsData"),
                object: nil,
                userInfo:nil)
        default:
            return
        }
        
        if selectedSegment != nil {
            selectedSegment?.titleColor(UIColor(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1.0))
            selectedSegment?.titleFont(UIFont(name: "Gotham-Book", size: 14.0)!)
        }
        if segments.count > 0 {
            selectedSegment = segments[index]
            selectedSegment?.titleColor(appColor)
            selectedSegment?.titleFont(UIFont(name: "Gotham-Bold", size: 14.0)!)
        }
}
}

