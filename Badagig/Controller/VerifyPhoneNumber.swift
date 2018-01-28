//
//  VerifyPhoneNumber.swift
//  badagig
//
//  Created by Perfect Aduh on 06/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit
import MRCountryPicker
import NexmoVerify

class VerifyPhoneNumber: UIViewController {
    
    //Outlets
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var verifyActivity: UIActivityIndicatorView!
    @IBOutlet weak var countryPicker: MRCountryPicker!
    @IBOutlet weak var countryLabelTextField: UITextField!
    @IBOutlet weak var selectCountryButtonPressed: UIButton!
    
    //Variable
    var countryCode = ""
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPicker.countryPickerDelegate = self
        countryPicker.showPhoneNumbers = true
        countryLabelTextField.delegate = self
        
        verifyActivity.isHidden = true
    }

    @IBAction func verifyButtonPressed(_ sender: Any) {
        guard let country = countryLabelTextField.text, country != "" else {
            self.showAlert(title: "Country is required", message: "Please select your country")
            return
        }
        guard let phoneNumber = phoneNumberTextField.text, phoneNumber != ""  else {
            self.showAlert(title: "Phone number is required", message: "Please enter your phone number")
            phoneNumberTextField.becomeFirstResponder()
            return
        }
        self.phoneNumber = phoneNumber
        verifyActivity.isHidden = false
        verifyActivity.startAnimating()
        
//        VerifyClient.getUserStatus(countryCode: self.countryCode, number: phoneNumber) { (status, error) in
//            if error != nil {
//                debugPrint("An error has occured: \(error.debugDescription)")
//            } else {
//                guard let status = status else { return }
//                print("Status is: \(status)")
//            }
//        }
        VerifyClient.logoutUser(countryCode: countryCode, number: phoneNumber) { (error) in
            if error == nil {
                print("Canceled")
            } else {
                print("Failed \(String(describing: error?.localizedDescription))")
            }
        }
        
        VerifyClient.getVerifiedUser(countryCode: self.countryCode, phoneNumber: phoneNumber, onVerifyInProgress: {
            //self.showAlert(title: "Verification", message: "Please be informed that your phone number verification is in progress")
            self.performSegue(withIdentifier: TO_PIN_CODE_VC, sender: nil)
        }, onUserVerified: {
            self.showAlert(title: "Verification", message: "Please check your inbox and enter the verification code sent to \(phoneNumber)")
            self.verifyActivity.isHidden = true
            self.verifyActivity.stopAnimating()
        }) { (error) in
            self.verifyActivity.isHidden = true
            self.verifyActivity.stopAnimating()
            self.showAlert(title: "Error", message: "An error has occured: \(error)")
        }
    }
    
    @IBAction func selectCountryButtonPressed(_ sender: Any) {
        countryPicker.isHidden = false
        
        phoneNumberTextField.resignFirstResponder()
    }
    
    @IBAction func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinaionVC = segue.destination as? PinCodeVC  else { return }
        if segue.identifier == TO_PIN_CODE_VC {
            destinaionVC.countryCode = self.countryCode
            destinaionVC.phoneNumber = self.phoneNumber
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        countryPicker.isHidden = true
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension VerifyPhoneNumber: MRCountryPickerDelegate {
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        self.countryCode = countryCode
        countryLabelTextField.text = "\(name) \(countryCode)"
    }
}

extension VerifyPhoneNumber: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        countryPicker.isHidden = true
        if textField == phoneNumberTextField {
            
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if selectCountryButtonPressed.isFocused {
             phoneNumberTextField.resignFirstResponder()
        }
        return true
    }
}
