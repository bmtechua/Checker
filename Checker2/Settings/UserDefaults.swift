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
    
//    func saveEx(name: String, work: Int, rest: Int) {
//        let exercise = Exercise(name: name, work: work, rest: rest)
//        exercisesArray.insert(exercise, at: 0)
//    }
}


func getArrayFromUserDefaults<T: Codable>(forKey key: String) -> [T]? {
    guard let jsonData = UserDefaults.standard.data(forKey: key) else { return nil }
    do {
        let jsonDecoder = JSONDecoder()
        let array = try jsonDecoder.decode([T].self, from: jsonData)
        return array
    } catch {
        print("Error retrieving array from UserDefaults: \(error.localizedDescription)")
        return nil
    }
}
