//
//  MoreVC.swift
//  badagig
//
//  Created by Perfect Aduh on 11/10/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class MoreVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func logunButtonPressed() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gettingStarted = storyBoard.instantiateViewController(withIdentifier: GETTING_STARTED_VC) as! GettingStartedVC
        self.present(gettingStarted, animated: true, completion: nil)
        
        AuthService.instance.isLoggedIn = false
        AuthService.instance.email = ""
        AuthService.instance.tokenKey = ""
    }
    
    @IBAction func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellId = tableView.cellForRow(at: indexPath)?.reuseIdentifier else { return }
        
        switch cellId {
        case POST_REQUEST_CELL:
            performSegue(withIdentifier: TO_POST_REQUEST_VC, sender: indexPath)
        case MANAGE_REQUEST_CELL:
            performSegue(withIdentifier: TO_MANAGE_REQUEST_VC, sender: indexPath)
        default:
            break
        }
        
        print("Indexpath \(indexPath)")
    }
}
