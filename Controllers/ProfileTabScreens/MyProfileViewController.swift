//
//  MyProfileViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 15/02/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import RSKImageCropper

class MyProfileViewController: UIViewController {

//MARK:- VARIABLES
    var imagePicked: UIImage?
    
//MARK:- BTN OUTLETS
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var imgView: UIImageView!

//MARK:- BTN ACTIONS

    @IBAction func btnImageAction(_ sender: Any) {
    }
    
    @IBAction func btnChangeAction(_ sender: Any) {
        openImagePicker(sender)
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        
        let editProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        editProfileVC.imagePicked = imagePicked
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @IBAction func btnChangePassAction(_ sender: Any) {
    }
    
//MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navBar?.isHidden = false
        //Remove bottom border of navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        setIntialValues()
    }
    
    func setIntialValues(){
        
        lblEmail.text = UserDataSingleton.sharedInstance.loggedInUser?.email
        lblDob.text = UserDataSingleton.sharedInstance.loggedInUser?.dob
        
        let gender = UserDataSingleton.sharedInstance.loggedInUser?.gender
        if gender == "1"{
            lblGender.text = "Male"
        }else if gender == "2"{
            lblGender.text = "Female"
        }else{
            lblGender.text = ""
        }
        
        if let image = UserDataSingleton.sharedInstance.loggedInUser?.image100{
            imgView.sd_setImage(with: URL(string: image),placeholderImage: UIImage.init(named: "ic_profile_placeholder"))
        }
        imgView.layer.cornerRadius = imgView.frame.width/2
        imgView.clipsToBounds = true
        btnImage.isHidden = true

        btnChange.layer.cornerRadius = 27
        btnChangePassword.layer.cornerRadius = 27
    }
}

extension MyProfileViewController: RSKImageCropViewControllerDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    func openImagePicker(_ sender : Any){
        let alert = UIAlertController(title: "", message: "Please upload image from:", preferredStyle: .actionSheet)
        alert.view.tintColor = appColor
        alert.view.backgroundColor = UIColor.white
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Albums", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let image : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        var imageCropVC : RSKImageCropViewController!
        imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.circle)
        imageCropVC.delegate = self
        self.navigationController?.pushViewController(imageCropVC, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        
        imagePicked = resizeImage(image: croppedImage, newWidth: 100)
        self.imgView.image = croppedImage
        self.imgView.clipsToBounds = true
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

