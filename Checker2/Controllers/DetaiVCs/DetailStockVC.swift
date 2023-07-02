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
        arrayFavoriteStocks = saveAndLoad.shared.getArrayFromUserDefaults(forKey: "arr") ?? [Stock]()
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
    
    @IBAction func addToFavorite(_ sender: Any) {
        arrayFavoriteStocks.append(stockOne)
//        defaults.set(name, forKey: "nameStockFavorite")
//        defaults.set(amount, forKey: "amountStockFavorite")
//        defaults.set(percent, forKey: "percentStockFavorite")
        saveAndLoad.shared.saveArrayToUserDefaults(arrayFavoriteStocks, forKey: "arr")
    }
}
