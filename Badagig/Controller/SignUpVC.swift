//
//  SignUpVC.swift
//  badagig
//
//  Created by Perfect Aduh on 04/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit
import Photos
import AWSS3

class SignUpVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var signUpActivity: UIActivityIndicatorView!
    
    //Variables
    var phoneNumber: String?
    var profilePicUrl: String?
    var selectedImageUrl: URL?
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        signUpActivity.isHidden = true
       
    }
 
    @IBAction func imagePickerPressed() {
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed() {
        signUpActivity.isHidden = false
        signUpActivity.startAnimating()
        guard let email = emailTxt.text, email != "" else { AlertErrorHandler.instance.showAlert(title: "Email equired", message: "Please enter a valid email")
            return }
        guard let password = passwordTxt.text, password != "" else {
            AlertErrorHandler.instance.showAlert(title: "Password equired", message: "Please enter a password")
            return }
        guard let userName = userNameTxt.text, userName != "" else {
             AlertErrorHandler.instance.showAlert(title: "Username equired", message: "Please enter a username")
            return }
        guard let phoneNumber = phoneNumber else {
             AlertErrorHandler.instance.showAlert(title: "Phone number equired", message: "Please enter a phone number")
            return }
        guard let phone = Int(phoneNumber) else {
            AlertErrorHandler.instance.showAlert(title: "Phone number equired", message: "Please enter a phone number")
            return }
        
        if let image = self.profileImg.image {
            ImageUploadService.instance.imageUpload(image: image) { (success, getUrl) in
                guard let profilePicUrl = getUrl else {
                    AlertErrorHandler.instance.showAlert(title: "Error", message: "An error has occured, Please try again")
                    return }
                if success {
                    print("getUrl retrievd \(getUrl)")
                    self.setupUser(email: email, password: password, profilePicUrl: profilePicUrl, userName: userName, phone: phone)
                } else {
                    AlertErrorHandler.instance.showAlert(title: "Error", message: "An error has occured, Please try again")
                }
            }
        }
    }
    
    private func setupUser(email: String, password: String, profilePicUrl: String, userName: String, phone: Int) {
        AuthService.instance.registerAccount(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(email: email, phone: phone, profilePicUrl: profilePicUrl, userName: userName, completion: { (success) in
                            if success {
                                self.performSegue(withIdentifier: TO_MAIN_VC, sender: nil)
                            }else{
                                AlertErrorHandler.instance.showAlert(title: "Error", message: "An error has occured, Please try again")
                            }
                        })
                    } else {
                         AlertErrorHandler.instance.showAlert(title: "Error", message: "An error has occured, Please try again")
                    }
                })
            } else {
                AlertErrorHandler.instance.showAlert(title: "Error", message: "An error has occured, Please try again")
            }
        }
    }
}

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImg.image = pickedImage
        }
    
        selectedImageUrl = info[UIImagePickerControllerPHAsset] as? URL
    
        dismiss(animated: true, completion: nil)
    }
}
