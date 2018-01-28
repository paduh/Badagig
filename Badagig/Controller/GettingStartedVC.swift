//
//  GettingStartedVC.swift.swift
//  badagig
//
//  Created by Perfect Aduh on 04/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class GettingStartedVC: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate, GIDSignInDelegate  {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
             print("An error has occured \(error)")
        } else if result.isCancelled {
           print("User cancelled")
        } else {
            if result.grantedPermissions.contains("public_profile") {
                print("Access token \(FBSDKAccessToken.current().tokenString)")
                print("")
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
    }
    
    
    
    @IBOutlet weak var faceBookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //faceBookLoginButton.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
//        for const in faceBookLoginButton.constraints {
//            
//            if const.firstAttribute == NSLayoutAttribute.height && const.constant == 28 {
//                faceBookLoginButton.removeConstraint(const)
//            }
//           
//           
//        }
               
//        BadaGigService.instance.getAllCategories { (success) in
//            if success {
//                
//            }
//        }
    }
    
    
   
    @IBAction func googleSignIn() {
        if GIDSignIn.sharedInstance().currentUser == nil {
            
            GIDSignIn.sharedInstance().signIn()
            if GIDSignIn.sharedInstance().currentUser != nil {
                let accessToken = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
                print("Google access token \(accessToken)")
                
                var user: GIDGoogleUser!
                let idToken = user.authentication.idToken // Safe to send to the server
                print("idToken \(idToken)")
            }
        } else {
            let accessToken = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
            print("Google access token \(accessToken)")
            
//            var user: GIDGoogleUser!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            print("idToken \(idToken)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                       withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            if let idToken = user.authentication.idToken  {
                // Safe to send to the server
            print("idToken \(idToken)")
            }
            
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }

    
    @IBAction func facebookSignIn() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userPhotos], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                AlertErrorHandler.instance.showAlert(title: "Error", message: "We encounterd connecting you via facebook. \(error)")
                return
            case .cancelled:
                AlertErrorHandler.instance.showAlert(title: "Cancelled", message: "Please be informed that you have cancelled registering an account via your facebook social media account")
                return
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                if grantedPermissions.contains("email") {
                    print("accessToken: \(accessToken.authenticationToken)")
                     print("FBSDKaccessToken: \(FBSDKAccessToken.current().tokenString)")
                } else {
                    AlertErrorHandler.instance.showAlert(title: "Error", message: "We encounterd connecting. Please try again")
                }
                break
            }
        }
    }
    
    @IBAction func faceBookButtonPressed(_ sender: Any) {
      
       let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userPhotos], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
               AlertErrorHandler.instance.showAlert(title: "Error", message: "We encounterd connecting you via facebook. \(error)")
                return
            case .cancelled:
                AlertErrorHandler.instance.showAlert(title: "Cancelled", message: "Please be informed that you have cancelled registering an account via your facebook social media account")
                return
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                 if grantedPermissions.contains("email") {
                     print("accessToken: \(accessToken.authenticationToken)")
                 } else {
                    AlertErrorHandler.instance.showAlert(title: "Error", message: "We encounterd connecting. Please try again")
                 }
            break
            }
        }
    }
    
    @IBAction func emailSignUpPressed() {
        performSegue(withIdentifier: TO_VERIFY_PHONE_VC, sender: nil)
    }
    @IBAction func emailSignInPressed() {
        performSegue(withIdentifier: TO_SIGN_IN_VC, sender: nil)
    }

}

