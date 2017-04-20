//
//  ManagePaymentsViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 15/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import Stripe
import Koloda
import ObjectMapper


class ManagePaymentsViewController: UIViewController,STPPaymentCardTextFieldDelegate {
    
//MARK:- VC OUTLETS
    @IBOutlet var viewDefaultCard: UIView!
    @IBOutlet var lblDefaultCardNumber: UILabel!
    @IBOutlet var btnChangeOutlet: UIButton!
    @IBOutlet var tblView: UITableView!
    @IBOutlet var btnDefaultCardIcon: UIButton!
    @IBOutlet var ConstraintDefaultCardViewHeight: NSLayoutConstraint!
    
//Mark:- VARIABLES USED
    var arrayViewCards = [ViewAllCardModal]()
    var card_id = ""
    var hideRemoveButton = 0
    
//MARK:- FLOATING BUTTONS
    let btnAddNewCard = UIButton(frame: CGRect(x: 16, y: UIScreen.main.bounds.height - 120, width: 200, height: 50))
    let btnSubmitCard = UIButton(frame: CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height-120, width: 200, height: 50))
    
//MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView?.rowHeight = UITableViewAutomaticDimension;
        self.tblView?.estimatedRowHeight = 212;//(Maximum Height that should be assigned to your cell)
        viewAllCards()
        setButtonFont(button: btnAddNewCard,title:"Add a new Card")
        btnAddNewCard.addTarget(self, action:#selector(self.btnAddNewCardAction), for: .touchUpInside)
        self.view.addSubview(btnAddNewCard)
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewAllCards()
    }
    
// MARK:- BUTTON ACTIONS
    @IBAction func btnChangeAction(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure you want to change default card?", preferredStyle: .alert)
        alert.view.tintColor = appColor
        alert.view.backgroundColor = UIColor.white
        let change = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: { (UIAlertAction)in
            self.changingDefaultCard()})
        let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(change)
        alert.addAction(dismiss)
        
        self.present(alert, animated: true, completion: {
        })
    }
}

//MARK:- TABLE VIEW DELEGATES

extension ManagePaymentsViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        let headerView = nib.instantiate(withOwner: nil, options: nil)[0] as? HeaderView
        headerView?.lblFormattedDate.text = ""
        headerView?.lblTimeSince.text = "Saved Cards"
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayViewCards.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.view.alpha = 1.0
        let model = arrayViewCards[indexPath.row + 1]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierTableCell.managePaymentSavedCards.rawValue , for: indexPath) as? ManagePaymentsTableViewCell  else {return UITableViewCell() }
        if(hideRemoveButton == 1){
            cell.btnRemoveOutlet.isHidden = true
        }
        else {
            cell.btnRemoveOutlet.isHidden = false
        }
        cell.myTableViewController = self
        if(model.is_default == "0"){
            cell.lblAccountNumber.text = "XXXX XXXX XXXX " + model.last4.unwrap()
            cell.btnCardIcon.setImage(UIImage(named:"stp_card_\(model.brand.unwrap().lowercased())"), for: .normal)
            cell.card_id = model.card_id.unwrap()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = arrayViewCards[indexPath.row + 1]
        self.card_id = model.card_id.unwrap()
    }
}

//MARK:- API CALLS
extension ManagePaymentsViewController {
        func viewAllCards(){
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.viewCards(access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                print(data ?? "" )
                let arrayOfDicts = data as? [String:AnyObject]
                
                self.arrayViewCards = arrayOfDicts?[APIConstants.all_cards] as! [ViewAllCardModal]
                
                if (self.arrayViewCards.count >= 0){
                    
                    self.lblDefaultCardNumber.text = "XXXX XXXX XXXX " + self.arrayViewCards[0].last4!
                    self.btnDefaultCardIcon.setImage(UIImage(named:"stp_card_\(self.arrayViewCards[0].brand.unwrap().lowercased())"), for: .normal)
                }
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
    
    func updateStripeAccountId(card_id:String){
        APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.makeCardDefault (access_token: UserDataSingleton.sharedInstance.loggedInUser?.access_token, card_id: card_id)), completion: { (response) in
            
            switch response{
                
            case .success(let data) :
                
                print(data ?? "")
                let message = data as? ManagePaymentModal
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message:(message?.message ?? ""), preferredStyle: .alert)
                    print(message?.message ?? "")
                    alert.view.tintColor = appColor
                    alert.view.backgroundColor = UIColor.white
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
                        self.viewAllCards()
                        self.setEveryThingToDefault()
                        self.hideRemoveButton = 0
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
 
            case .failureMessage( _):
                print("failure")
                UtilityFunctions.showAlert(message: "card selection is must", controller: self)
            default : break
            }
        })
        
    }
}
//MARK::- FUNCTION
    extension ManagePaymentsViewController {
    func changingDefaultCard()
    {
        self.hideRemoveButton = 1
        self.tblView.reloadData()
        animate(constraintHeight:0)
        btnAddNewCard.isHidden = true
        setButtonFont(button: btnSubmitCard,title:"Submit Card")
        btnSubmitCard .addTarget(self, action:#selector(self.btnSubmitCardAction), for: .touchUpInside)
        btnSubmitCard.isHidden = false
        self.view.addSubview(btnSubmitCard)
        
    }
    
    func btnSubmitCardAction(){
        self.updateStripeAccountId(card_id:card_id)
    }
        
    func setEveryThingToDefault(){
        animate(constraintHeight:130)
        btnAddNewCard.isHidden = false
        btnSubmitCard.isHidden = true
    }
        
    func btnAddNewCardAction(sender: UIButton?){
            guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else { return }
            nextViewController.delegate = self
            self.dim(direction: .in, alpha: 0.5, speed: 0.5)
            self.presentVC(nextViewController)
        }
        
    func setButtonFont(button:UIButton,title:String){
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "Gotham-Bold", size: 14)
            button.setTitleColor(UIColor.white.withAlphaComponent(1.0), for: UIControlState.normal)
            button.backgroundColor = appColor
            button.layer.cornerRadius = button.frame.height/2
        }
        
    func animate(constraintHeight:CGFloat){
            view.layoutIfNeeded()
            self.ConstraintDefaultCardViewHeight.constant = constraintHeight
            UIView.animate(withDuration: 1.0, animations: {
                self.view.layoutIfNeeded()
            })
        }
 }


//MARK::-  UPDATE LIST
extension ManagePaymentsViewController :  DelegateUpdatePayments{
    func updatePayments(){
        viewAllCards()
    }
}
