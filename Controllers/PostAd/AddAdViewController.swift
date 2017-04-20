//
//  PostAdViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 21/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import SwiftyJSON
import GooglePlaces
import CoreLocation
import NVActivityIndicatorView
import ActionSheetPicker_3_0

class AddAdViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var viewTextView: UIView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!
    
    //MARK:- Variables
    fileprivate lazy var httpClient : HTTPClient = HTTPClient()
    var currentArrayCount:Int?
    var subquestions1Exist: Bool?
    var subquestion1Index = 0
    var subquestions2Exist: Bool?
    var subquestion2Index = 0

    var type14Enabled: Bool?
    var type14Count = 0
    var type6Enabled: Bool?
    var type6Count = 0

    //Selected Values
    var dateSelected = ""
    var googlePlaceSelected = ""
    
    //Location
    var placesClient: GMSPlacesClient!
    let locationManager = CLLocationManager()
    
    //Arrays
    var cellValues = [cellValue]()
    var arrayTexts = [questionValueAndType]()
    var arrayOfCollections = [[questionValueAndType]]()
    var totalData = [[QuestionModel]]()
    var arrayRideValues = [String]()
    var arrayRideQuestions = [QuestionModel]()
    var arrayRideSubQuestions = [QuestionModel]()

    
    //Cell Enums
    enum cellPosition{
        case left
        case right
    }
    
    enum cellType{
        case text
        case collection
    }
    
    //TypeAliasis
    typealias questionValueAndType = (value: String, type: String)
    typealias cellValue = (quesValueAndType: [questionValueAndType], position: cellPosition, type: cellType)
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        placesClient = GMSPlacesClient.shared()
        
        isAuthorizedtoGetUserLocation()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
            locationManager.requestLocation()
        }

        //Set parameters initially
        self.navBar?.isHidden = false
        subquestions1Exist = false
        subquestions2Exist = false
        type14Enabled = false
        type6Enabled = false
        viewTextView.isHidden = true
        
        cellValues.append(([("Hi \(UserDataSingleton.sharedInstance.loggedInUser?.firstname!), I’m your virtual assistant Mason. I’ll help you post your advertisement.","0")],.left,.text))
        
        self.tblView?.rowHeight = UITableViewAutomaticDimension;
        self.tblView?.estimatedRowHeight = 212;//(Maximum Height that should be assigned to your cell)
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.separatorStyle = .none
        
        fetchQuestions()
        
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "hideMenuButton"),
            object: nil,
            userInfo:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        self.navBar?.tintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Keyboard Notification

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardConstraint?.constant = 0.0
            } else {
                self.keyboardConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    //MARK:- APIs

    func fetchQuestions(){
        
        let activityData = ActivityData(size: CGSize(width:50 , height: 50), message: "", messageFont:nil , type: .ballClipRotate, color: appColor, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        httpClient.getRequest(withApi: APIConstants.basePath+APIConstants.getQuestions, success: { (data,res) in
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
            let statusCode = res.response?.statusCode.toString
            guard let response = data else {
                apiResponse.failure(.none)
                return
            }
            
            let json = JSON(response)
            
            //Previously Used
            print(json["success"].stringValue)
            let responseType = apiValidation(rawValue: statusCode!) ?? .failure
            
            if responseType == apiValidation.success {
                
                if(json["success"]).boolValue{
                    
                    let myData = QuestionModel.parseArrayinToModal(withAttributes: json[APIConstants.data].arrayValue)
                    
                    
                    //Original data parsing result
                    self.totalData =  (myData as? [[QuestionModel]])!
                    self.arrayRideQuestions = ((self.totalData[5]) as [QuestionModel]?)!
                    
                    //Changed data parsing result
//                    let array = (myData as? [QuestionModel])!
//                    for ques in array{
//                        if Int(ques.questions_id!)! > 25 {
//                            self.arrayRideQuestions.append(ques)
//                        }
//                    }
//                    self.arrayRideQuestions = (myData as? [QuestionModel])!
                    
                    print(self.arrayRideQuestions.count)
                    
                    if self.arrayRideQuestions.count > 0{
                        // Call get Array value here
                        self.getCellCountAndOrder(model: self.arrayRideQuestions[0])
                        self.currentArrayCount = 1
                        self.tblView.reloadData()
                    }
                    
                    return
                }else{
                    print(json["message"])
//                    self.isTokenExpire = false
                    //                    return
                }
            }
            else if responseType == apiValidation.failure || responseType == apiValidation.serverError{
                return
            }
                
            else if  responseType == apiValidation.invalidAccessToken {
                
                //invaild token
//                completion(apiResponse.failure(responseType))
                return
            }
            
        }, failure: { (message) in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            apiResponse.failureMessage(message)
        })
    }

    //MARK:- Cell Count functions

    func getCellCountAndOrder(model: QuestionModel){
        
        //0 select, 1 numeric, 2 file, 3 date, 4 radiobtn, 5 time, 6 dropdown, 7 images, 8 use_location, 9 text, 10 current_location, 11 price, 12 edition, 13 duration, 14 multiple_inputs
        
        if type6Enabled!{
            type6Count = type6Count+1
        }
        
        if(type14Enabled == true){
            
            type14Count = type14Count+1

            if type14Count == 1{
                cellValues.append(([("+ Add stop","8")],.right,.collection))
            }else if type14Count <= 3{
                cellValues.append(([("Skip","15"),("+ Add another stop","8")],.right,.collection))
            }else{
                type14Enabled = false
            }

            return
        }
        
        if(subquestions1Exist == false){
            cellValues.append(([(model.question!,model.type!)],.left,.text))

            if model.have_options == "1"{
                
                if let countSub = model.sub_questions?.count, countSub > 0{
                    
                    var tempSubQuestions = [questionValueAndType]()
                    for quesModel in model.sub_questions! {
                        
                        tempSubQuestions.append((quesModel.question!,quesModel.type!))

                        if quesModel.have_options == "1"{
                            
                            if quesModel.type == "14"{
                                // Allow inputs upto 3
                                type14Enabled = true
                                tempSubQuestions.append(("No","0")) // Manual override of No value in no. of Stops
                                break
                            }
                            
                            if let countSub1 = quesModel.sub1_questions?.count, countSub1 > 0{
                                
                                //Set bool for entering sub questions as 1
                                subquestions1Exist = true
                                continue
                                
                            }else{
                                subquestions1Exist = false
                            }
                            
                        }
                        
                    }
                    cellValues.append((tempSubQuestions,.right,.collection))
                    
                }
                
            }
        }else{
            if (subquestions2Exist == false){
                if let countSub = model.sub_questions?.count, countSub > 0{
                    
                    var index = 0

                    for quesModel in model.sub_questions! {

                        if type6Enabled!{
                            if quesModel.type != "6"{
                                continue
                            }
                        }else{
                            if index != subquestion1Index{
                                index = index + 1
                                continue
                            }
                        }
                        
                        
                        if quesModel.have_options == "1"{
                            
                            // current the model is not entering here
                            if let countSub1 = quesModel.sub1_questions?.count, countSub1 > 0{
                                
                                var index = 0
                                var tempSub1Questions = [questionValueAndType]()
                                
                                for qModel in quesModel.sub1_questions! {
                                    
                                    if qModel.have_options == "1"{
                                        
                                        if let countSub2 = qModel.sub2_questions?.count, countSub2 > 0{
                                            
                                            for quesM in qModel.sub2_questions! {
                                                
                                                subquestions2Exist = true
                                                break
                                            }
                                        }
                                        
                                        //------
                                        if type6Enabled!{
                                            if type6Count < 3{
                                                tempSub1Questions.append((qModel.question!,qModel.type!))
                                                break
                                            }else{
                                                type6Enabled = false
                                                if index == 1{
                                                    tempSub1Questions.append((qModel.question!,qModel.type!))
                                                    subquestions1Exist = false
                                                    subquestions2Exist = false
                                                    self.currentArrayCount = self.currentArrayCount! + 1
                                                    break
                                                }
                                            }
                                        }else{
                                            tempSub1Questions.append((qModel.question!,qModel.type!))
                                        }
                                        //--------
                                        
                                        
                                        
//                                        if index == subquestion1Index{
//                                            tempSub1Questions.append((qModel.question!,qModel.type!))
//                                        }
                                        
                                    }else{
                                        subquestions2Exist = false
                                    }
                                    
                                    index = index + 1

                                }
                                cellValues.append((tempSub1Questions,.right,.collection))
                                
                                //Set bool for entering sub questions as 0
                            }
                        }
                        
                        index = index + 1
                    }
                }
            }else{
                for quesModel in model.sub_questions! {
                    
                    if quesModel.have_options == "1"{
                        
                        // current the model is not entering here
                        if let countSub1 = quesModel.sub1_questions?.count, countSub1 > 0{
                            
                            var index = 0
                            var tempSub2Questions = [questionValueAndType]()
                            for qModel in quesModel.sub1_questions! {
                                if qModel.have_options == "1"{
                                    
                                    if let countSub2 = qModel.sub2_questions?.count, countSub2 > 0{

                                        for quesM in qModel.sub2_questions! {
                                            
                                            if index == subquestion2Index{
                                                tempSub2Questions.append((quesM.question!,quesM.type!))
                                                break
                                            }
                                        }
                                    }
                                }
                                index = index + 1

                            }
                            cellValues.append((tempSub2Questions,.right,.collection))
                            
                            //Set bool for entering sub questions as 0
                            subquestions2Exist = false
                        }
                    }
                }
            }
            
        }

    }
    
    func returnNewCount(currentCount: Int, type: String) -> Int{
        
        return 0
    }


    

}

//MARK:- TableView

extension AddAdViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellValue = self.cellValues[indexPath.row]
        
        if cellValue.position == .left {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostAdLeftTextTableViewCell" , for: indexPath) as? PostAdLeftTextTableViewCell  else {return UITableViewCell() }
            cell.lblLeftText.text = cellValue.quesValueAndType[0].value
            return cell
        }else{
            if cellValue.type == .text{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostAdRightTextTableViewCell" , for: indexPath) as? PostAdRightTextTableViewCell  else {return UITableViewCell() }
                cell.lblRightText.text = cellValue.quesValueAndType[0].value
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell" , for: indexPath) as? CollectionViewTableViewCell  else {return UITableViewCell() }
                
                arrayTexts = cellValue.quesValueAndType
                cell.collectionView.reloadData()

                //To stop collection views from being selected again
                if indexPath.row == cellValues.count - 1{
                    cell.isUserInteractionEnabled = true
                }else{
                    cell.isUserInteractionEnabled = false
                }
                return cell
            }
        }
        
//            cell.lblLeftText.text = "Hi \(UserDataSingleton.sharedInstance.loggedInUser?.firstname), I’m your virtual assistant Mason. I’ll help you post your advertisement."

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellValue = self.cellValues[indexPath.row]

        if cellValue.position == .right{
            if cellValue.type == .collection{
                return 80 // 16+48+16
            }
        }else{
            return UITableViewAutomaticDimension
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}


//MARK:- CollectionView

extension AddAdViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let stringSize = arrayTexts[indexPath.row].value.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)])
        print(stringSize.width)
        //60 intent value [System to Gotham conversion] //White space issue
        return CGSize(width: stringSize.width + 60, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -10 // Set after checking for multiple devices
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTexts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostAdCollectionViewCell", for: indexPath as IndexPath) as! PostAdCollectionViewCell
        cell.lbl.text = arrayTexts[indexPath.row].value
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        let value:String =  arrayTexts[indexPath.item].value
        if (value == "Edit"){
            arrayTexts[indexPath.item].type = "15"
        }else if(value == "Publish"){
            
        }
        
        if subquestions1Exist!{
            subquestion1Index = indexPath.item
        }
        
        if subquestions2Exist!{
            subquestion2Index = indexPath.item
        }
        
        updateTableView(indexPath: indexPath)
//        addNewRows(indexPath: indexPath)
    }
    
}

//MARK:- TableView Updates and additions
extension AddAdViewController{
    
    func updateTableView(indexPath: IndexPath){
        //0 select, 1 numeric, 2 file, 3 date, 4 radiobtn, 5 time, 6 dropdown, 7 images, 8 use_location, 9 text, 10 current_location, 11 price, 12 edition, 13 duration, 14 multiple_inputs
        
        var value = ""
        let type:Int =  Int(arrayTexts[indexPath.item].type)!
        print(type)
        
        viewTextView.isHidden = true
        
        switch type {
        case 0:
            if type14Enabled!{
                type14Enabled = false
                self.currentArrayCount = self.currentArrayCount! + 1
            }
            
            value = arrayTexts[indexPath.item].value
            
            if cellValues.count > 0{
                cellValues[cellValues.count - 1] = ([(value,"0")],.right,.text)
                tblView.reloadData()
            }
            addNewRows(indexPath: indexPath)
        case 1:
            //Open Keyboard with numeric
            viewTextView.isHidden = false
            txtView.keyboardType = .numberPad
            return
        case 2:
            //Does not exist
            return
        case 3:
            //Open Date Picker
            openDatePicker(self)
        case 4:
            //Radio do nothing
            if subquestions1Exist! || subquestions2Exist!{
                value = arrayTexts[indexPath.item].value
                if cellValues.count > 0{
                    cellValues[cellValues.count - 1] = ([(value,"0")],.right,.text)
                    tblView.reloadData()
                }
                addNewRows(indexPath: indexPath)
            }
            return
        case 5:
            //Open Keyboard to enter duration
            viewTextView.isHidden = false
            txtView.keyboardType = .default
            return
        case 6:
            //Drop Down figure out later
            type6Enabled = true
            if subquestions1Exist! || subquestions2Exist!{
                value = arrayTexts[indexPath.item].value
                if cellValues.count > 0{
                    cellValues[cellValues.count - 1] = ([(value,"0")],.right,.text)
                    tblView.reloadData()
                }
                addNewRows(indexPath: indexPath)
            }
            return
        case 7:
            //Open multiselect image picker figure out later
            return
        case 8:
            //Open google places picker
            openPlacePicker()
            value = googlePlaceSelected
        case 9:
            //Open Keyboard for normal text
            viewTextView.isHidden = false
            txtView.keyboardType = .default
            return
        case 10:
            //Get current location place
            value = getCurrentLocation()

        case 11:
            //Open Keyboard with numeric price
            viewTextView.isHidden = false
            txtView.keyboardType = .numberPad
            return
        case 12:
            //Open Keyboard with numeric edition
            viewTextView.isHidden = false
            txtView.keyboardType = .numberPad
            return
        case 13:
            //Open Keyboard with numeric duration in mins
            viewTextView.isHidden = false
            txtView.keyboardType = .numberPad
            return
        case 14:
            //Type 14 unique case of multiple choices possible
            value = arrayTexts[indexPath.item].value
            if cellValues.count > 0{
                cellValues[cellValues.count - 1] = ([(value,"0")],.right,.text)
                tblView.reloadData()
            }
            addNewRows(indexPath: indexPath)

            return
        case 15:
            //Skip
            if type14Enabled!{
                type14Enabled = false
                self.currentArrayCount = self.currentArrayCount! + 1
            }
            if cellValues.count > 0{
                cellValues.remove(at: cellValues.count - 1)
                tblView.reloadData()
            }
            addNewRows(indexPath: indexPath)
        default:
            return
        }

        
//        if cellValues.count > 0{
//            cellValues[cellValues.count - 1] = ([(value,"0")],.right,.text)
//            tblView.reloadData()
//        }
    }
    
    func addNewRows(indexPath: IndexPath){
        //        self.tblView.beginUpdates()
        
        print(currentArrayCount)
        getCellCountAndOrder(model: self.arrayRideQuestions[currentArrayCount!])
        
        var arrayOfItemsAdded = [IndexPath(row: cellValues.count-2, section: 0),IndexPath(row: cellValues.count-1, section: 0)]
        
        if type14Enabled == true{
            // Let it automatically pick values from static parameters
            if(type14Count == 0){
                arrayOfItemsAdded = [IndexPath(row: cellValues.count-2, section: 0),IndexPath(row: cellValues.count-1, section: 0)]
            }else{
                arrayOfItemsAdded = [IndexPath(row: cellValues.count-1, section: 0)]
            }
            
            if(type14Count > 1){
                if(indexPath.item == 0){
                    type14Enabled = false // In case of Skip Tapped
                    self.currentArrayCount = self.currentArrayCount! + 1
                }else{
                    //Another Stop picked
                }
            }
        }else if type6Enabled!{
            arrayOfItemsAdded = [IndexPath(row: cellValues.count-2, section: 0),IndexPath(row: cellValues.count-1, section: 0)]
        }else{
            if(subquestions1Exist == true){
                //Let it be the same question and donot update currentArrayCount here
            }else{
                self.currentArrayCount = self.currentArrayCount! + 1
            }
        }
        
        //        self.tblView.insertRows(at: arrayOfItemsAdded, with: .automatic)
        //        self.tblView.endUpdates()
        
        tblView.reloadData()
        
        let indexPath = IndexPath(row: cellValues.count-1, section: 0)
        self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

//MARK:- Location Delegates

extension AddAdViewController: GMSAutocompleteViewControllerDelegate {
    
    func getCurrentLocation() -> String{
        var placeValue = ""
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    let place = likelihood.place
                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
                    print("Current Place address \(place.formattedAddress)")
                    print("Current Place attributions \(place.attributions)")
                    print("Current PlaceID \(place.placeID)")
                    print("Current PlaceCoordinate Latitude \(place.coordinate.latitude) and Longitude \(place.coordinate.longitude)")
                    
                    placeValue = place.name
                    if self.cellValues.count > 0{
                        self.cellValues[self.cellValues.count - 1] = ([(placeValue,"0")],.right,.text)
                        self.tblView.reloadData()
                    }
                }
            }
            
            self.addNewRows(indexPath:IndexPath(row: 0, section: 0))
        })
        
        return placeValue
    }
    
    func openPlacePicker(){
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        googlePlaceSelected = place.name
        if cellValues.count > 0{
            cellValues[cellValues.count - 1] = ([(googlePlaceSelected,"0")],.right,.text)
            tblView.reloadData()
        }
        
        dismiss(animated: true, completion: nil)
        
        addNewRows(indexPath:IndexPath(item: 1, section: 0))
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}

extension AddAdViewController:CLLocationManagerDelegate{
    //if we have no permission to access user location, then ask user for permission.
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    //this method will be called each time when a user change his location access preference.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("User allowed us to access location")
            //do whatever init activities here.
        }
    }
    
    
    //this method is called by the framework on         locationManager.requestLocation();
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called")
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")

        //store the user location here to firebase or somewhere
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }
}

//MARK:- Select Functions

extension AddAdViewController{
    func openDatePicker(_ sender : Any){
        
        let datePicker = ActionSheetDatePicker(title: "Birth Date", datePickerMode: UIDatePickerMode.date, selectedDate: NSDate() as Date!, doneBlock: {
            picker, value, index in
            
            //dd-MMM-YYYY
            //yyyy-mm-dd
            
            print("value = \(value)")
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: value as! Date)
            print ("true value = \(tomorrow)")
            print("index = \(index)")
            print("picker = \(picker)")
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            let myDateString = dateFormatter.string(from: value! as! Date)
            print(myDateString)
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd/mm/yy"
            let showDate = inputFormatter.date(from: myDateString)
            inputFormatter.dateFormat = "yyyy-dd-mm"
            let resultString = inputFormatter.string(from: showDate!)
            print(resultString)
            
//            self.txtFieldDOB.text = resultString
            self.dateSelected = resultString
            if self.cellValues.count > 0{
                self.cellValues[self.cellValues.count - 1] = ([(resultString,"0")],.right,.text)
                self.tblView.reloadData()
            }
            self.addNewRows(indexPath:IndexPath(row: 0, section: 0))

        }, cancel: { ActionStringCancelBlock in return },origin: (self.view))

//        ,origin: (sender as AnyObject).superview!?.superview)
        
        datePicker?.maximumDate = NSDate() as Date!
        
        datePicker?.setTextColor(appColor)
        datePicker?.pickerBackgroundColor = UIColor.white
        datePicker?.toolbarBackgroundColor = UIColor.white
        datePicker?.toolbarButtonsColor = appColor
        
        datePicker?.show()
    }
    
    func openTimePicker(_ sender : Any){
        
        let datePicker = ActionSheetDatePicker(title: "Birth Date", datePickerMode: UIDatePickerMode.time, selectedDate: NSDate() as Date!, doneBlock: {
            picker, value, index in
            
            print("value = \(value)")
            self.dateSelected = (value as! String?)!
            
        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!?.superview)
        
//        datePicker?.maximumDate = NSDate() as Date!
        datePicker?.minuteInterval = 20

        datePicker?.setTextColor(appColor)
        datePicker?.pickerBackgroundColor = UIColor.white
        datePicker?.toolbarBackgroundColor = UIColor.white
        datePicker?.toolbarButtonsColor = appColor
        
        datePicker?.show()
    }
}

extension AddAdViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Type something"){
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.cellValues.count > 0{
            self.viewTextView.isHidden = true
            self.cellValues[self.cellValues.count - 1] = ([("$ " + textView.text,"0")],.right,.text)
            self.tblView.reloadData()
        }
        self.addNewRows(indexPath:IndexPath(row: 0, section: 0))
    }
}

