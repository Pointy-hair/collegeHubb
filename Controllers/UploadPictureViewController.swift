//
//  UploadPictureViewController.swift
//  CollegeHub
//
//  Created by Sumanpreet on 25/01/17.
//  Copyright © 2017 Sumanpreet. All rights reserved.
//

import UIKit
import RSKImageCropper

class UploadPictureViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    var imageLoaded: Bool = false
    var imagePicked: UIImage?
    
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnSkipAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navBar?.isHidden = false
        
        //Remove bottom border of navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Back button setting
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back_white")
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white;

        btnImage.layer.cornerRadius = btnImage.frame.width/2
        btnChange.layer.cornerRadius = 27
        btnChange.isHidden = true
        btnUpload.titleLabel?.adjustsFontSizeToFitWidth = true
        btnUpload.titleLabel?.textAlignment = NSTextAlignment.center
        
        if let firstName = UserDataSingleton.sharedInstance.loggedInUser?.firstname{
            lblName.text = "Hello \(firstName), Let's give your name a face!"
        }
    }
    
    //MARK: - Button Actions
    @IBAction func btnImageAction(_ sender: Any) {
        openImagePicker(sender)
    }
    
    @IBAction func btnChangeAction(_ sender: Any) {
        openImagePicker(sender)
    }
    
    @IBAction func btnUploadAction(_ sender: Any) {
        if imageLoaded == false{
            openImagePicker(sender)
        }else{
            
            let user = UserDataSingleton.sharedInstance.loggedInUser
            APIManager.sharedInstance.opertationWithRequest(withApi: api.userApi(ApiEnum: api.userApiEnum.editProfile(access_token: user?.access_token, firstname: user?.firstname, lastname: user?.lastname, gender: user?.gender, dob: user?.dob)) , image: imagePicked , completion: { (response) in
                
                switch response{
                    
                case .success(let data) :
                    
                    print(data ?? "")
                    let x = data as? User
                    print(x?.access_token ?? "")
                    
                    UserDataSingleton.sharedInstance.loggedInUser = data as? User
                    print(UserDataSingleton.sharedInstance.loggedInUser ?? "")
                    let verifyEduEmailVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyEmailViewController") as! VerifyEmailViewController
                    self.navigationController?.pushViewController(verifyEduEmailVC, animated: true)
                    
                case .failureMessage(let message):
                    print("failure")
                    UtilityFunctions.showAlert(message: message, controller: self)
                default : break
                    
                    
                }
            })
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UploadPictureViewController: RSKImageCropViewControllerDelegate{
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
        
        //Implementation for normal ImagePickerController
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            //save image
//            //display image
//            imageLoaded = true
//            btnImage.isUserInteractionEnabled = false
//            btnChange.isHidden = false
//            btnImage.setImage(image, for: UIControlState.normal)
//            btnUpload.titleLabel?.text = "Continue"
//        }
//        self.dismiss(animated: true, completion: nil)
//        self.btnImage.clipsToBounds = true

        
        let image : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        var imageCropVC : RSKImageCropViewController!
        imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.circle)
        imageCropVC.delegate = self
        self.navigationController?.pushViewController(imageCropVC, animated: true)
        self.dismiss(animated: true, completion: nil)

        //Previously the code was based in this completion box and the animation was not that good
//        picker.dismiss(animated: false, completion: { () -> Void in
//        })
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        
        imagePicked = resizeImage(image: croppedImage, newWidth: 100)
        self.btnImage.setImage(croppedImage, for: UIControlState.normal)
        self.imageLoaded = true
        self.btnImage.isUserInteractionEnabled = false
        self.btnImage.layer.borderColor = UIColor.white.cgColor
        self.btnImage.layer.borderWidth = 4
        self.btnChange.isHidden = false
        self.btnUpload.titleLabel?.textAlignment = .right
        self.btnUpload.setTitle("Continue", for: UIControlState.normal)
        self.btnImage.clipsToBounds = true
        
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
