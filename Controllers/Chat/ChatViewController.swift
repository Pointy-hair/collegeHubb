//
//  ChatViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 13/03/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    //Fetched vars from previous screen
    var lastMessageId:String?
    var user_id2:String?
    
    //Arrays
    var arrayMessages = [MessageModel]()
    var arraySections = [String]()
    var arraySectionValues = [[MessageModel]]()
    var previousRow:Int?
    var previousSection:Int?

    //Variables
    var timer = Timer()
    let threshold:CGFloat = 100.0 // threshold from bottom of tableView
    var isLoadingMore = false // flag for paging
    var isLoadedOnce = false
    
    //Outlets
    @IBOutlet weak var viewTextView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    @IBAction func btnSend(_ sender: Any) {
        if (txtView.text.length > 0){
            sendMessage(message: txtView.text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(lastMessageId ?? "")
        print(user_id2 ?? "")

        //Initial Functions
        addNotifications()
        initialiseTableView()
        self.navBar?.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        //Run for first Time
        getConversation()

        //Initiate Timer
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(getConversation), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navBar?.tintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addNotifications(){
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "hideMenuButton"),
            object: nil,
            userInfo:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    func initialiseTableView(){
        self.tblView.estimatedRowHeight = 999
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }
    
    func sortSectionsByDate(){
        
        var arrTemp = [MessageModel]()
        
        var arrSectionsTemp = [String]()
        var arrSectionValuesTemp = [[MessageModel]]()
        var index = 0

        for message in self.arrayMessages{
            if arrSectionsTemp.contains(message.date!){
                arrTemp.append(message)
                arrSectionValuesTemp.insert(arrTemp, at: index - 1)
            }else{
                arrTemp = []
                arrTemp.append(message)
                arrSectionsTemp.append(message.date!)
                index += 1
            }
        }
        
        arrTemp = []
        var arr = [[MessageModel]]()
        if arrSectionsTemp.count > 0{
            for index in 0...arrSectionsTemp.count - 1{
                print(index)
                arr.append(arrSectionValuesTemp[index])
            }
            arrSectionValuesTemp = arr
        }
        
        arraySections = arrSectionsTemp
        arraySectionValues = arrSectionValuesTemp
        arrSectionsTemp = []
        arrSectionValuesTemp = []
        
    }
    
    func getAttributedString(message : String, time: String) -> NSMutableAttributedString{
        let attStringMsg = NSMutableAttributedString(string:"\(message)")
        let stringAttributes = [
            NSFontAttributeName : UIFont(name: "Gotham-Book", size: 12.0)!,
            NSForegroundColorAttributeName : UIColor.init(hexString: "9E9E9E"),
            ]
        let attStringTime = NSMutableAttributedString(string:"\n\n\(time)", attributes:stringAttributes)
        attStringMsg.append(attStringTime)
        return attStringMsg
    }
    
    func scrollToBottomOfTableView(animation: Bool, middleIndexPathPosition: Bool){
        if arraySections.count > 0{
            if arraySectionValues.count > 0{
                var indexPath:IndexPath!
                if middleIndexPathPosition{
                    indexPath = IndexPath(row: arraySectionValues[arraySectionValues.count - 1].count-1 - previousRow!, section: arraySections.count - 1 - previousSection!)
                    tblView.scrollToRow(at: indexPath, at: .middle, animated: animation)

                }else{
                    indexPath = IndexPath(row: arraySectionValues[arraySectionValues.count - 1].count-1, section: arraySections.count - 1)
                    tblView.scrollToRow(at: indexPath, at: .bottom, animated: animation)

                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChatViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        return
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text.length > 0){
            sendMessage(message: textView.text)
        }
    }
}

extension ChatViewController{
    
    func getConversation(){
        
        var messageID = ""
        if arrayMessages.count > 0{
            messageID = arrayMessages[arrayMessages.count - 1].message_id!
        }else{
            messageID = "0"
        }
        
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.getConversation(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, timezone: APIConstants.timezone, users_id2: user_id2, last_message_id: messageID)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                
                
                if self.arrayMessages.count > 0{
                    
                    let arrayData = data as? [MessageModel]
                    if (arrayData?.count)! > 0{
                        var index = 0
                        for message in arrayData!{
                            self.arrayMessages.insert(message, at: index)
                            index += 1
                        }
                        
                        //Sort Sections by Date
                        self.sortSectionsByDate()
                        //Reload Table
                        self.tblView.reloadData()
                        self.scrollToBottomOfTableView(animation: false,middleIndexPathPosition: false)

                    }
                    
                }else{
                    self.arrayMessages = data as! [MessageModel]
                    
                    //Sort Sections by Date
                    self.sortSectionsByDate()
                    //Reload Table
                    self.tblView.reloadData()
                    //Take to bottom only if initial data is empty
                    self.scrollToBottomOfTableView(animation: true,middleIndexPathPosition: false)
                    self.isLoadedOnce = true
                }
                

            case .failureMessage(let message):
                print("failure")
                UtilityFunctions.showAlert(message: message, controller: self)
            default : break
                
                
            }
        })
    }
    
    func getPreviousMessages(){
        if arrayMessages.count > 0{
            
            var messageID = ""
            if isLoadingMore{
                messageID  = arrayMessages[0].message_id!
            }
            
            APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.getPreviousMessages(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, timezone: APIConstants.timezone, users_id2: user_id2, last_message_id: messageID)), completion: { (response) in
                
                switch response{
                    
                case .success(let data) :
                    
                    print(data ?? "")
                    let arrayData = data as? [MessageModel]
                    if (arrayData?.count)! > 0{
                        
                        self.previousRow = self.arraySectionValues[self.arraySectionValues.count - 1].count-1
                        self.previousSection = self.arraySections.count - 1
                        
                        var index = 0
                        for message in arrayData!{
                            self.arrayMessages.insert(message, at: index)
                            index += 1
                        }
                        
                        //Sort Sections by Date
                        self.sortSectionsByDate()
                        //Reload Table
                        self.tblView.reloadData()
                        self.scrollToBottomOfTableView(animation: false,middleIndexPathPosition: true)

                    }
                    
                case .failureMessage(let message):
                    print("failure")
                    UtilityFunctions.showAlert(message: message, controller: self)
                default : break
                    
                }
            })
        }
    }
    
    func sendMessage(message: String){
        
        if arrayMessages.count > 0{
            
            let lastMessageID = arrayMessages[arrayMessages.count - 1].message_id
            
            APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.sendMessage(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, timezone: APIConstants.timezone, users_id2: user_id2, message: message, last_message_id: lastMessageID)), completion: { (response) in
                
                switch response{
                    
                case .success(let data) :
                    
                    print(data ?? "")
                    let message = data as? MessageModel
                    self.arrayMessages.append(message!)
                    self.tblView.reloadData()
                    
                    //Take to bottom only if initial data is empty
                    self.scrollToBottomOfTableView(animation: false,middleIndexPathPosition: false)
                    
                case .failureMessage(let message):
                    print("failure")
                    UtilityFunctions.showAlert(message: message, controller: self)
                default : break
                    
                }
            })
            
        }
    }
}

extension ChatViewController: UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if arraySections.count > 0{
            return arraySections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if arraySections.count > 0{
            return arraySections[section]
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arraySections.count > 0{
            if arraySectionValues.count > 0{
                return arraySectionValues[section].count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userID = UserDataSingleton.sharedInstance.loggedInUser?.user_id
        let currentArray = arraySectionValues[indexPath.section]
        let currentMessage = currentArray[indexPath.row]
        let string = getAttributedString(message: currentMessage.message!, time: currentMessage.time!)
        
        if currentMessage.users_id1 == userID {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostAdRightTextTableViewCell" , for: indexPath) as? PostAdRightTextTableViewCell  else {return UITableViewCell() }
            cell.lblRightText.attributedText = string
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostAdLeftTextTableViewCell" , for: indexPath) as? PostAdLeftTextTableViewCell  else {return UITableViewCell() }
            cell.lblLeftText.attributedText = string
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if isLoadedOnce{
            if !isLoadingMore && (contentOffset == 0) {
                // Get more data - API call
                self.isLoadingMore = true
                getPreviousMessages()
                
                // Update UI
                DispatchQueue.main.async {
                    self.isLoadingMore = false
                }
            }
        }
    }

}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

