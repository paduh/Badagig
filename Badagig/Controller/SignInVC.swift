//
//  SignInVC.swift
//  badagig
//
//  Created by Perfect Aduh on 04/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    //Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signInActivity: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        signInActivity.isHidden = true
        
    
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        
        signInActivity.isHidden = false
        signInActivity.startAnimating()
        guard let email = emailTxt.text, email != "" else { return }
        guard let password = passwordTxt.text, password != "" else { return }
        
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                print("Token \(AuthService.instance.tokenKey)")
                print("Login Succedded")
                self.performSegue(withIdentifier: TO_MAIN_VC, sender: nil)
                
            } else {
                self.signInActivity.isHidden = true
                self.signInActivity.stopAnimating()
                self.showALert(title: "Error", message: "An error has occurred. ")
            }
        }
    }
    
    @IBAction func passwordResetPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_PASSWORD_RESET_VC, sender: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showALert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
