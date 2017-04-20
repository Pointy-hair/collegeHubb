//
//  HeaderViewController.swift
//  CollegeHub
//
//  Created by Sierra 4 on 14/04/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController {
    
var temp = ""
    
    @IBOutlet weak var txtSearchBar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearchBar.delegate = self
    }
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
//        filteredMessages = arrayMessages.filter { MessageModel in
//            let categoryMatch = (scope == "All") || (MessageModel.firstname == scope)
//            // return  categoryMatch && ((MessageModel.firstname?.lowercased().contains(searchText.lowercased()))! || (MessageModel.lastname?.lowercased().contains(searchText.lowercased()))!)
//            return  categoryMatch && ( ((MessageModel.firstname?.lowercased().contains(searchText.lowercased()))! && (MessageModel.firstname?.lowercased().characters.first == searchText.lowercased().characters.first)) || ((MessageModel.lastname?.lowercased().contains(searchText.lowercased()))! && (MessageModel.lastname?.lowercased().characters.first == searchText.lowercased().characters.first)))
//            
//            //  }
//        }
//        
//        tblView.reloadData()
    }


  }
extension HeaderViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(string != ""){
            temp = (textField.text).unwrap() + string
        }
        else {
            temp = String(textField.text.unwrap().characters.dropLast())
        }
        
        if(temp == ""){
            //tblView.reloadData()
        }
        filterContentForSearchText(searchText: temp)
        
        return true
    }
}
