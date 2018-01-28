//
//  UserDataService.swift
//  badagig
//
//  Created by Perfect Aduh on 06/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var firstName: String = ""
    public private(set) var lastName: String = ""
    public private(set) var userName: String = ""
    public private(set) var email: String = ""
    public private(set) var phoneNumber: Int = 0
    public private(set) var profilePicUrl: String = ""
    public private(set) var availability: String = ""
    public private(set) var skills: [String] = [String]()
    public private(set) var  education: String = ""
    
    func setupUserData(firstName: String, lastName: String, email: String, userName: String, phoneNumber: Int, profilePicUrl: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.profilePicUrl = profilePicUrl
    }
    
    func setupUserSellerInfo(availability: String, skills: [String], education: String) {
        self.availability = availability
        self.education = education
        self.skills = skills
    }
    
//    func getloggedInUserId(completion: Callback) -> String {
//        guard let token = AuthService.instance.tokenKey else { return }
//        let HEADER_BEARER = [
//            "Authorization": "Bearer \(token)",
//            "Content-Type": "application/json; charset=utf-8"
//        ]
//
//        Alamofire.request(URL_GET_LOGGED_IN_USER, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
//            if response.result.error == nil {
//
//            } else {
//
//            }
//        }
//
//        return ""
//    }
    
    func getUerName(userId: String, completion: @escaping Callback) -> String {
        Alamofire.request("\(URL_GET_USER_EMAIL)\(userId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                
                self.userName = json["username"].stringValue
                completion(true)
            } else {
                debugPrint(" Error downloading username\(response.result.error as Any)")
                completion(false)
            }
        }
        return self.userName
    }
}
