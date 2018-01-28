//
//  AlertErrorHandlerService.swift
//  badagig
//
//  Created by Perfect Aduh on 12/1/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import Foundation
import UIKit

class AlertErrorHandler{
    
    static let instance = AlertErrorHandler()
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        let alertWindow =  UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
