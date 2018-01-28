//  BadaGigService.swift
//  badagig
//
//  Created by Perfect Aduh on 12/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class BadaGigService {
    
    static let instance = BadaGigService()
    
    var categories = [Category]()
    var topCategories = [Category]()
    var subCategories = [SubCategory]()
    var requests = [Request]()
    var badaGigs = [BadaGig]()
    var deliveryDays = [String]()
    var request: Request!
    var category: Category!
    var recommended: Bool!
  
  
    func getAllCategories(completion: @escaping Callback){
       
        Alamofire.request(URL_GET_ALL_CATEGORIES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array {
                    for item in json {
                    let categoryId = item["_id"].stringValue
                    let cateGoryTitle = item["categoryTitle"].stringValue
                    let categoryDescription = item["categoryDescription"].stringValue
                    self.recommended = item["recommended"].boolValue
                    
                        self.category = Category(id: categoryId, CategoryTItle: cateGoryTitle, categoryDescription: categoryDescription, recommended: self.recommended)
                        self.categories.append(self.category)
                        if self.recommended == true {
                            self.topCategories.append(self.category)
                        }
//                        if self.categories.count == 0 {
//                            self.categories.append(self.category)
//                            if self.recommended == true {
//                                self.topCategories.append(self.category)
//                            }
//                        }
//                        if json.count > self.categories.count {
//                            self.categories.append(self.category)
//                            if self.recommended == true {
//                                self.topCategories.append(self.category)
//                            }
//                        }
                    }
                }
                 completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createNewCategory(categoryTitle: String, categoryDescription:String, submittedBy: String, completion: @escaping Callback) {
        let json: [String: Any] = [
            "submittedBy": submittedBy,
            "categoryTitle": categoryTitle,
            "catehoryDescription": categoryDescription
        ]
       
        Alamofire.request(URL_ADD_NEW_CATEGORIES, method: .post, parameters: json, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func updateCategory(categoryId: String, categoryTitle: String, categoryDescription: String, updatedBy: String, completion: @escaping Callback) {
        let json: [String:Any] = [
            "updatedBy": updatedBy,
            "categoryTitle": categoryTitle,
            "catehoryDescription": categoryDescription
        ]
       
        Alamofire.request("\(URL_ADD_NEW_CATEGORIES)\(categoryId)", method: .put, parameters: json, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func deleteCategory(categoryId: String, categoryTitle: String, categoryDescription: String, updatedBy: String, completion: @escaping Callback) {
       
        Alamofire.request("\(URL_DELETE_CATEGORIES)\(categoryId)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func addNewSubCategory(categoryId: String, subCategoryId: String, SubCategoryTitle: String, completion: @escaping Callback) {
        let json: [String: Any] = [
            "categoryId": categoryId,
            "subCategoryId": subCategoryId,
            "subCategoryTitle": SubCategoryTitle
        ]
       
        Alamofire.request(URL_ADD_NEW_SUBCATEGORIES, method: .get, parameters: json, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getAllSubCategoryByCategory(categoryId: String, compeletion: @escaping Callback) {
       
        Alamofire.request("\(URL_GET_ALL_SUBCATEGORIES_BY_CATEGORY)\(categoryId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array {
                    for item in json {
                        let id = item["_id"].stringValue
                        let title = item["subCategoryTitle"].stringValue
                        let categoryId = item["categoryId"].stringValue
                        
                        let subCategory = SubCategory(id: id, subCategoryTItle: title, categoryId: categoryId)
                        self.subCategories.append(subCategory)
                        if json.count > self.subCategories.count {
                            
                           
                        }
                    }
                }
                 compeletion(true)
            } else {
                debugPrint(response.result.error as Any)
                compeletion(false)
            }
        }
    }
    
    func getAllSubCategory(compeletion: @escaping Callback) {
        
        Alamofire.request(URL_GET_ALL_SUBCATEGORIES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array {
                    for item in json {
                        let id = item["_id"].stringValue
                        let title = item["subCategoryTitle"].stringValue
                        let categoryId = item["categoryId"].stringValue
                        
                        let subCategory = SubCategory(id: id, subCategoryTItle: title, categoryId: categoryId)
                        self.subCategories.append(subCategory)
                        if json.count > self.subCategories.count {
                            
                        }
                    }
                }
                compeletion(true)
            } else {
                debugPrint(response.result.error as Any)
                compeletion(false)
            }
        }
    }
    
    func addNewRequest(description: String, badaGigerId: String, budget: Double, deliveryDays: String, subCategoryId: String, completion: @escaping Callback){
        let json: [String : Any] = [
            "badagiger": badaGigerId,
            "subcategoryid": subCategoryId,
            "description": description,
            "budget": budget,
            "deliverydays": deliveryDays
        ]
      
        Alamofire.request("\(URL_ADD_NEW_REQUESTS)\(subCategoryId)/byBadaGiger/\(badaGigerId)", method: .post, parameters: json, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                debugPrint("An error occured adding new request\(response.result.error as Any)")
                completion(false)
            }
        }
    }
    
    func getAllRequestByABadaGiger(userId: String, completion: @escaping Callback) {
      
        Alamofire.request("\(URL_GET_ALL_REQUESTS_BY_USER)\(userId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array  {
                    for item in json {
                        let id = item["_id"].stringValue
                        let badaGigeeId = item["badaGigeeId"].stringValue
                        let badaGierId = item["badaGigerId"].stringValue
                        let description = item["description"].stringValue
                        let budget = item[" budget"].doubleValue
                        let deliveryDays = item["deliveryDays"].stringValue
                        let requestDate = item["requestDate"].stringValue
                   
                        
                        self.request = Request(id: id, deliveryDays: deliveryDays, badaGigerId: badaGierId, badaGigeeId: badaGigeeId, description: description, budget: budget, requestDate: requestDate)
                        self.requests.append(self.request)
                        if json.count >= self.requests.count {
                            
                        }
                    }
                }
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getAllRequest(completion: @escaping Callback) {
       
        Alamofire.request("\(URL_GET_ALL_REQUESTS)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array  {
                   
                    for item in json {
                        let id = item["_id"].stringValue
                        let badaGigeeId = item["badaGigeeId"].stringValue
                        let badaGierId = item["badaGigerId"].stringValue
                        let description = item["description"].stringValue
                        let budget = item["budget"].doubleValue
                        let deliveryDays = item["deliveryDays"].stringValue
                        let requestDate = item["requestDate"].stringValue
                        
                        self.request = Request(id: id, deliveryDays: deliveryDays, badaGigerId: badaGierId, badaGigeeId: badaGigeeId, description: description, budget: budget, requestDate: requestDate)
                        
                        self.requests.append(self.request)
//                        print("BeforeRequestCount \(self.requests.count)")
//                        if self.requests.count <= 0 {
//                            self.requests.append(self.request)
//                            print("AfterRequestCount \(self.requests.count)")
//                        } else if self.requests.count < json.count {
//                            self.requests.append(self.request)
//                            print("After2RequestCount \(self.requests.count)")
//                        }
                    }
                    completion(true)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
                
            }
        }
    }
    
    func addNewBadaGig(title: String, description: String, subCategoryId: String, searchTag: String, duration: String, badaGigerId: String, completion: @escaping Callback){
        let json: [String: Any] = [
            "badagigtitle": title,
            "badadigdescription": description,
            "searchtags": searchTag,
            "deliveryduration": duration,
            "badagigerid": badaGigerId,
            "subcategoryid": subCategoryId
        ]
        
        Alamofire.request("\(URL_ADD_NEW_BADAGIG)\(subCategoryId)/byBadaGiger\(badaGigerId)", method: .post, parameters: json, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseString { (response) in
            guard let httpStatusCode = response.response?.statusCode else { return }
            if response.result.error == nil {
                completion(true)
                if httpStatusCode == 200 {
                } else {
                    completion(false)
                }
            } else {
                debugPrint("An error occured svaing badagig\(response.result.error as Any)")
                completion(false)
            }
        }
    }
    
    func getAllBadaGig(completion: @escaping Callback) {
      
        Alamofire.request(URL_GET_ALL_BADAGIG, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                let json = JSON(data: data).arrayValue
                for item in json {
                    let id = item["_id"].stringValue
                    let title = item["badaGigTitle"].stringValue
                    let description = item["badaGigDescription"].stringValue
                    let searchTags = item["searchTags"].stringValue
                    let deliveryDuration = item["deliveryDuration"].stringValue
                    let badaGigerId = item["badaGigerId"].stringValue
                    
                    let badaGig = BadaGig(id: id, title: title, description: description, searchTags: searchTags, badaGigerId: badaGigerId)
                    
                    if json.count > self.badaGigs.count {
                        self.badaGigs.append(badaGig)
                    }
                    completion(true)
                }
            } else {
                debugPrint("An error occured retriving all badagig\(response.result.error as Any)")
                completion(false)
            }
        }
    }
    
    func getBadaGigByBadaGiger(badaGigerId: String, completion: @escaping Callback) {
       
        Alamofire.request("\(URL_GET_ALL_BADAGIG_BY_USER)\(badaGigerId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                let json = JSON(data: data).arrayValue
                for item in json {
                    let id = item["_id"].stringValue
                    let title = item["badaGigTitle"].stringValue
                    let description = item["badaGigDescription"].stringValue
                    let searchTags = item["searchTags"].stringValue
                    let deliveryDuration = item["deliveryDuration"].stringValue
                    let badaGigerId = item["badaGigerId"].stringValue
                    
                    let badaGig = BadaGig(id: id, title: title, description: description, searchTags: searchTags, badaGigerId: badaGigerId)
                    self.badaGigs.append(badaGig)
                    completion(true)
                }
            } else {
                debugPrint("An error occured retriving all badagig for \(badaGigerId)\(response.result.error as Any)")
                completion(false)
            }
        }
    }
    
    func addNewOrder(badaGigId: String, completion: @escaping Callback) {
        guard let userId = AuthService.instance.loggedInUserId else { return }
        Alamofire.request("\(URL_ADD_NEW_ORDER)5a4dc20308b4722e6b33523c/byBadaGig/\(badaGigId)", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                print("Succeeded")
                completion(true)
            } else {
                 print("Failed")
                debugPrint("Eroor adding new order\(String(describing: response.result.error))")
                completion(false)
            }
        }
    }
    
    func getDeliveryDays() {
        let days = 1...30
        for i in days {
            if i == 1 {
                let day = "\(i) day"
                self.deliveryDays.append(day)
            } else if i > 1 {
                let days = "\(i) days"
                self.deliveryDays.append(days)
            }
        }
    }
}
