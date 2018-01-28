//
//  File.swift
//  badagig
//
//  Created by Perfect Aduh on 10/26/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import Foundation

extension CountableClosedRange {

    func returnIndexValue(min: Int, max: Int) -> Int {
        var indexArray = [Int]()
        let range = (min...max)
        
        for i in range {
           indexArray.append(i)
        }
        
        for i in indexArray {
            print(i)
            return i
        }
        return max
    }
}
