//
//  Save_Load.swift
//  Checker2
//
//  Created by bmtech on 22.03.2023.
//

import Foundation
import UIKit

class saveAndLoad {
    
    static let shared = saveAndLoad()
    
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
    
    func saveArrayToUserDefaults<T: Codable>(_ array: [T], forKey key: String) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(array)
            UserDefaults.standard.set(jsonData, forKey: key)
        } catch {
            print("Error saving array to UserDefaults: \(error.localizedDescription)")
        }
    }
    
}
