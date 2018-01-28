//
//  Request.swift
//  badagig
//
//  Created by Perfect Aduh on 12/10/2017.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import Foundation

struct Request {
 
    public private(set) var id: String = ""
    public private(set) var subCategoryId: String = ""
    public private(set) var deliveryDays: String = ""
    public private(set) var badaGigerId: String = ""
    public private(set) var badaGigeeId: String = ""
    public private(set) var description: String = ""
    public private(set) var budget: Double = 0.0
    public private(set) var requestDate: String
//    public private(set) var serviceType: String = ""
//    public private(set) var platform: String = ""
//    public private(set) var expertise: String = ""
    
    
    init(id: String, deliveryDays: String, badaGigerId: String, badaGigeeId: String, description: String, budget: Double, requestDate: String) {
        self.id = id
        self.deliveryDays = deliveryDays
        self.badaGigerId = badaGigerId
        self.badaGigeeId = badaGigeeId
        self.description = description
        self.budget = budget
//        self.serviceType = serviceType
//        self.platform = platform
//        self.expertise = expertise
        self.requestDate = requestDate
    }
    
}
