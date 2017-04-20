//
//  MessagesViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {
    
//MARK:- VARIABLE
    var arrayMatches = [MessageModel]()
    var arrayMessages = [MessageModel]()
    var filteredMessages = [MessageModel]()//edited
    var temp = ""//edited
    let searchController = UISearchController(searchResultsController: nil)//edited
    
//MARK:- VC OUTLETS
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    
//MARK:- VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar?.isHidden = true
          txtFieldSearch.delegate = self
//        searchController.searchResultsUpdater = self//edited
//        searchController.dimsBackgroundDuringPresentation = false//edited
//        definesPresentationContext = true//edited
//        tblView.tableHeaderView = searchController.searchBar//edited

    }
    
    override func viewWillAppear(_ animated: Bool) {
       // txtFieldSearch.addTarget(self, action:#selector(MessagesViewController.myTargetFunction(textField:)), for: UIControlEvents.touchDown)
        self.navBar?.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "showMenuButton"),
            object: nil,
            userInfo:nil)
        getConversationList()
        
    }
//MARK:- FUNCTIONS    
    //edited
    func filterContentForSearchText(searchText: String, scope: String = "All") {
            
        filteredMessages = arrayMessages.filter { MessageModel in
            let categoryMatch = (scope == "All") || (MessageModel.firstname == scope)
       // return  categoryMatch && ((MessageModel.firstname?.lowercased().contains(searchText.lowercased()))! || (MessageModel.lastname?.lowercased().contains(searchText.lowercased()))!)
         return  categoryMatch && ( ((MessageModel.firstname?.lowercased().contains(searchText.lowercased()))! && (MessageModel.firstname?.lowercased().characters.first == searchText.lowercased().characters.first)) || ((MessageModel.lastname?.lowercased().contains(searchText.lowercased()))! && (MessageModel.lastname?.lowercased().characters.first == searchText.lowercased().characters.first)))
       
      //  }
        }
        
        tblView.reloadData()
    }
   
}
//MARK:- API CALLS
extension MessagesViewController{
    func getConversationList(){
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.getConversationList(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, timezone: APIConstants.timezone)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                
                let arrayOfDicts = data as? [String:AnyObject]
                
                self.arrayMatches = arrayOfDicts?[APIConstants.matches] as! [MessageModel]
                self.arrayMessages = arrayOfDicts?[APIConstants.messages] as! [MessageModel]
                
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
                
            case .failureMessage(let message):
                print("failure")
                UtilityFunctions.showAlert(message: message, controller: self)
            default : break
                
                
            }
        })
    }
    
   
}
//MARK:- TABLE VIEW DELEGATES
extension MessagesViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "New Matches"
        }else{
            return "Conversations"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 1
        }else{
            //edited
           // if searchController.isActive && searchController.searchBar.text != "" {
            if temp != ""  {
                return filteredMessages.count
            }
            return arrayMessages.count
            //
           // return arrayMessages.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return 90
        }else{
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cellMatches = tableView.dequeueReusableCell(withIdentifier: "MatchesTableViewCell", for: indexPath) as! MatchesTableViewCell
            
            cellMatches.arrayMatches = arrayMatches
            cellMatches.collectionView.reloadData()
            
            return cellMatches
        }else{
            let cellMessages = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath) as! MessagesTableViewCell
            
            var model = arrayMessages[indexPath.row]
            //edited
       // if searchController.isActive && searchController.searchBar.text != "" {
          if temp != ""  {
           
                model = filteredMessages[indexPath.row]
            } else {
                model = arrayMessages[indexPath.row]
            }
            //
            cellMessages.lblUsername.text = model.firstname! + " " + model.lastname!
            cellMessages.lblLastMsg.text = model.message
            cellMessages.lblUnreadCount.text = model.unread_count
            cellMessages.imgView?.sd_setImage(with: NSURL.init(string: (model.image100)!)! as URL!)

            return cellMessages
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            let ChatVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
            ChatVC?.lastMessageId = arrayMessages[indexPath.row].message_id
            ChatVC?.user_id2 = arrayMessages[indexPath.row].users_id2
            self.navigationController?.pushViewController(ChatVC!, animated: true)
        }
    }
}
//edited
//extension MessagesViewController : UISearchResultsUpdating {
//   
//    func updateSearchResults(for searchController: UISearchController) {
//         print("bar")
//      filterContentForSearchText(searchText: searchController.searchBar.text!)
//       print("bar2")
//    }
//}

//MARK:- TEXT FIELD DELEGATES
extension MessagesViewController : UITextFieldDelegate {
//    func myTargetFunction(textField: UITextField) {
//        print("bar1")
//        filterContentForSearchText(searchText: txtFieldSearch.text!)
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        filterContentForSearchText(searchText: txtFieldSearch.text!)
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(string != ""){
        temp = textField.text! + string
        }
        else {
          temp = String(textField.text!.characters.dropLast())
        }
        
        if(temp == ""){
            tblView.reloadData()
        }
           filterContentForSearchText(searchText: temp)
        
    return true
    }
}



