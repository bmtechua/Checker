//
//  DetailStockVC.swift
//  Checker2
//
//  Created by bmtech on 24.07.2022.
//

import UIKit

class DetailStockVC: UIViewController {

    var defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    
    var stockOne: Stock!
    var arrayFavoriteStocks = [Stock]()
    
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel! 
    
    var name = ""
    var current = ""
    var amount = ""
    var percent = ""
    var volume = ""
    var symbol = ""
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        arrayFavoriteStocks = getArrayFromUserDefaults(forKey: "arr") ?? [Stock]()
    }
    
    func setData() {
        DispatchQueue.main.async {
            self.stockOne = self.stockOne
            self.detailNameLabel.text = self.name
            self.currentLabel.text = self.current
            self.amountLabel.text = self.amount
            self.percentLabel.text = self.percent
            self.volumeLabel.text = self.volume
            self.symbolLabel.text = self.symbol
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
    
    @IBAction func addToFavorite(_ sender: Any) {
        print("stockOne -",stockOne)
        arrayFavoriteStocks.append(stockOne)
        defaults.set(name, forKey: "nameStockFavorite")
        defaults.set(amount, forKey: "amountStockFavorite")
        defaults.set(percent, forKey: "percentStockFavorite")
        
        saveArrayToUserDefaults(arrayFavoriteStocks, forKey: "arr")
        
        print(stockOne.name)
        print(arrayFavoriteStocks.count)
        for i in arrayFavoriteStocks {
            print("\(i) - \(i.name)")
        }
        
       
    }
}
