//
//  Stocks.swift
//  Checker2
//
//  Created by bmtech on 20.07.2022.
//

import Foundation
import UIKit

class StocksAll: Codable {
    var stock: [Stock]
}

class StocksFavorites: Codable {
    var stock: [Stock]
}

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




