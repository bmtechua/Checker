//
//  UserDefaults.swift
//  Checker2
//
//  Created by bmtech on 20.07.2022.
//

import Foundation

var defaults = UserDefaults.standard

struct KeyDefaults {
    static let stock = "stock"
    static let array = "array"
}

class Base{
    let defaults = UserDefaults.standard
    
    static let shared = Base()

    class Stock: Codable {
        var name: String
        var price: Price
        var percent_change: Double
        var volume: Int
        var symbol: String
    }

    class Price: Codable {
        var currency: String
        var amount: Double

    }
    
    var stocksArray: [Stock] {
        get {
            if let data = defaults.value(forKey: KeyDefaults.array) as? Data{
                return try! JSONDecoder().decode([Stock].self, from: data)
            } else {
                return [Stock]()
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                defaults.set(data, forKey: KeyDefaults.array)
            }
        }
    }
}

