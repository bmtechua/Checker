//
//  StockGroups.swift
//  Checker2
//
//  Created by bmtech on 18.03.2023.
//

import Foundation
import UIKit

struct StockNew {
    var name: String
    var amount: String
    var percent: String
}

struct GroupStock {
    var name: String
    var stock: [StockNew]
}



let s1 = StockNew(name: "Acer", amount: "234", percent: "5")
let s2 = StockNew(name: "Acpache", amount: "234", percent: "5")
let s3 = StockNew(name: "Ancor", amount: "234", percent: "5")
let s4 = StockNew(name: "Butterfly", amount: "234", percent: "5")
let s5 = StockNew(name: "Barca", amount: "234", percent: "5")
let s6 = StockNew(name: "Contico", amount: "234", percent: "5")
let s7 = StockNew(name: "Link", amount: "234", percent: "5")
let s8 = StockNew(name: "Montana", amount: "234", percent: "5")
let s9 = StockNew(name: "Porto", amount: "234", percent: "5")
let s10 = StockNew(name: "Wizz", amount: "234", percent: "5")

let gAll = [s1, s2, s3, s4, s5, s6, s7, s8, s9, s10]
let gFavorites = [s1, s3, s5]

let g1 = GroupStock(name: "Favorites", stock: gAll)
let g2 = GroupStock(name: "All", stock: gFavorites)


class Groups {
    var groups = [GroupStock]()
    
    init() {
        setup()
    }
    
    func setup() {
        self.groups = [g1, g2]
    }
}
