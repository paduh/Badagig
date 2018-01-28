//
//  PinCodeVC.swift
//  badagig
//
//  Created by Perfect Aduh on 10/22/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit
import PinCodeTextField
import NexmoVerify


class PinCodeVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var pinCodeTextField: PinCodeTextField!
    @IBOutlet weak var pinCodeActivity: UIActivityIndicatorView!
    @IBOutlet weak var submitButtonPressed: MaterialButton!
    @IBOutlet weak var infoLbl: UILabel!
    //Variables
    var pinCode = ""
    var countryCode: String?
    var phoneNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let phoneNumber = phoneNumber {
            infoLbl.text = "Please enter your BadaGig verification code sent to: \(phoneNumber)"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.pinCodeTextField.becomeFirstResponder()
        }
        
        pinCodeTextField.delegate = self
        pinCodeTextField.keyboardType = .numberPad
        
        pinCodeActivity.isHidden = true

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        submitButtonPressed.alpha = 0.5
        submitButtonPressed.isEnabled = false
        pinCodeActivity.isHidden = false
        pinCodeActivity.startAnimating()
        
        guard let pinCode = pinCodeTextField.text, pinCode != "" else { return }
        guard let countryCode = countryCode else { return }
        guard let phoneNumber = phoneNumber else { return }
        
        self.performSegue(withIdentifier: TO_SIGN_UP_VC, sender: self)
        VerifyClient.checkPinCode(pinCode, countryCode: countryCode, number: phoneNumber, onUserVerified: {
            self.showAlert(title: "Success", message: "Phone number verification has completed sucessfully")
            
        }) { (error) in
            self.showAlert(title: "Error", message: "An has occured: \(error)")
            self.submitButtonPressed.alpha = 1.0
            self.submitButtonPressed.isEnabled = true
            self.pinCodeActivity.isHidden = true
            self.pinCodeActivity.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SignUpVC else { return }
        guard let phoneNumber = self.phoneNumber else { return }
        if segue.identifier == TO_SIGN_UP_VC {
            destinationVC.phoneNumber = phoneNumber
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController()
        let okAction = UIAlertAction(title: "title", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension PinCodeVC: PinCodeTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: PinCodeTextField) {
        
    }
    
    func textFieldValueChanged(_ textField: PinCodeTextField) {
        print("value changed: \(String(describing: textField.text))")
        
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: PinCodeTextField) -> Bool {
        return true
    }
}
