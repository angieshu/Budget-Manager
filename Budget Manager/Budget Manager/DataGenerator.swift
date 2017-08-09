//
//  DataGenerator.swift
//  Budget Manager
//
//  Created by Anhelina Shulha on 8/6/17.
//  Copyright © 2017 Anhelina Shulha. All rights reserved.
//

import Foundation

struct Money {
    var month: String
    var value: Int
}

class DataGenerator {
    
    static func set(dict:[String:Int]) -> [Money] {
//        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var money = [Money]()
        
        if (dict.isEmpty) {
            return money
        }

        for (key, value) in dict {
//            let ind:Int = months.index(of: key)!
//            let month = months[ind]
//            print("\(month)")
            let m = Money(month: key, value: value)
            money.append(m)
        }
        return money
    }

}
