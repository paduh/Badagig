//
//  BadaGigOrderVC.swift
//  badagig
//
//  Created by Perfect Aduh on 1/2/18.
//  Copyright © 2018 Perfect Aduh. All rights reserved.
//

import UIKit

class BadaGigOrderVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var badaGigDescription: UILabel!
    @IBOutlet weak var sellerRating: UILabel!
    @IBOutlet weak var gigAmount: UILabel!
    @IBOutlet weak var badaGigOrderActivity: UIActivityIndicatorView!
    
    //Variable
    var selectedBadaGig: Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        badaGigOrderActivity.isHidden = true
    
        if let selectedGig = selectedBadaGig {
            badaGigDescription.text = selectedGig.description
            gigAmount.text = "₦\(selectedGig.budget)"
        }
       
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func orderGigButtonPressed(_ sender: Any) {
        guard let userId = AuthService.instance.loggedInUserId else {
            AlertErrorHandler.instance.showAlert(title: "Error", message: "We encountered an error while processing your order, Please try again later. If it persist, please contact support")
            return }
        print("Userid\(AuthService.instance.loggedInUserId)")
        print("LoginUser\(userId)")
        badaGigOrderActivity.isHidden = false
        badaGigOrderActivity.startAnimating()
        
        guard let gig = selectedBadaGig else {
            AlertErrorHandler.instance.showAlert(title: "Error!", message: "An error was encountered please try again")
            return
        }
        BadaGigService.instance.addNewOrder(badaGigId: gig.id) { (success) in
            if success {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC = storyBoard.instantiateViewController(withIdentifier: MAIN_VC) as! MainVC
                self.present(mainVC, animated: true, completion: nil)
            } else {
                self.badaGigOrderActivity.isHidden = true
                self.badaGigOrderActivity.stopAnimating()
            }
        }
        
    }
    
    
    
}
