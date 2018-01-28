//
//  InitialVC.swift
//  badagig
//
//  Created by Perfect Aduh on 11/7/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import FacebookCore
import FacebookLogin

class InitialVC: UIViewController {
    
    //Variables
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var topCategories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        
       isLoggedIn()
    }

    func isLoggedIn() {
        let mainVC = self.storyBoard.instantiateViewController(withIdentifier: MAIN_VC) as! MainVC
        if AuthService.instance.isLoggedIn == true{
            OperationQueue.main.addOperation {
//                BadaGigService.instance.getAllCategories { (success) in
//                    if success {
//                        print(" InitCounter \(BadaGigService.instance.categories.count)")
//                        self.topCategories = BadaGigService.instance.topCategories
//                    }
//                }
//                BadaGigService.instance.getAllRequest { (success) in
//                    if success {
//                    }
//                }
                self.present(mainVC, animated: true, completion: nil)
            }
        }
//        else if FBSDKAccessToken.current().tokenString != nil {
//            self.present(mainVC, animated: true, completion: nil)
//        }
//        else if GIDSignIn.sharedInstance().currentUser.authentication.accessToken != nil {
//            self.present(mainVC, animated: true, completion: nil)
//        }
        else {
            OperationQueue.main.addOperation {
                let gettingStartedVC = self.storyBoard.instantiateViewController(withIdentifier: GETTING_STARTED_VC) as! GettingStartedVC
                self.present(gettingStartedVC, animated: true, completion: nil)
            }
        }
    }
    

}
