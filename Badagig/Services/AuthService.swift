//
//  AuthService.swift
//  badagig
//
//  Created by Perfect Aduh on 04/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AuthService {
    
    static let instance = AuthService()
    
   
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool? {
        get {
            return defaults.bool(forKey: IS_LOGGED_IN) 
        }
        set {
            defaults.set(newValue, forKey: IS_LOGGED_IN)
        }
    }
    
    var tokenKey: String {
        get {
            
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var email: String {
        get {
            return defaults.value(forKey: EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: EMAIL)
        }
    }
    
    var loggedInUserId: String? {
        get  {
            return defaults.value(forKey: LOGGED_IN_USERID) as? String
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_USERID)
        }
    }
    
    func registerAccount(email: String, password: String, completion: @escaping Callback) {
        
        let lowerEmail = email.lowercased()
        let json: [ String: Any ] = [
            "email": lowerEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER_ACCOUNT, method: .post, parameters: json, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                debugPrint(response.request)
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping Callback) {
        let lowerEmail = email.lowercased()
        let jsonBody: [String: Any] = [
            "email": lowerEmail,
            "password": password
        ]
        Alamofire.request(URL_LOGIN_ACCOUNT, method: .post, parameters: jsonBody, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                self.tokenKey = json["token"].stringValue
                self.email = json["user"].stringValue
                self.isLoggedIn = true
                self.loggedInUserId = json["id"].stringValue
                print("login successful")
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func createUser(email: String, phone: Int, profilePicUrl: String, userName: String, completion: @escaping Callback ) {
        let jsonBody: [ String: Any] = [
            "email": email,
            "phonenumber": phone,
            "username": userName,
            "profilepicurl": profilePicUrl
        ]
        
        Alamofire.request(URL_CREATE_USER, method: .post, parameters: jsonBody, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                print("loggedInUser \(String(describing: response.result))")
                guard let data = response.data else { return }
                let json = JSON(data: data)
                print("loggedInUser \(String(describing: self.loggedInUserId))")
                completion(true)
            } else {
                debugPrint("create user error \(String(describing: response.result.error))")
                completion(false)
            }
        }
    }
    
    
    
}
