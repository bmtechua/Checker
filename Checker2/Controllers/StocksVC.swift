//
//  StocksVC.swift
//  Checker2
//
//  Created by bmtech on 20.07.2022.
//

import UIKit
import Foundation
import SwiftUI

class StocksVC: UIViewController{
    
    var networkService = NetworkService()
    var stocks: [Stock] = []
    var myColorGray = UIColor(hex: 0x1E1F26)
    var myColorBlack = UIColor(hex: 0x16171C)
                        

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Stocks"
        setupTable()
        
        networkService.fetchPostData { (stocks) in
            self.stocks = stocks.stock
            self.tableView.reloadData()
        }
        
    }
    
    func setupTable() {
        tableView.register(UINib(nibName: "StockCell", bundle: nil), forCellReuseIdentifier: "StockCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension StocksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count stocks",stocks.count)
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as! StockCell
        let stock = stocks[indexPath.row]
        cell.setupStockCell(stock: stock)
        
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = myColorGray
        } else {
            cell.backgroundColor = myColorBlack
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStockVC") as? DetailStockVC
        
        vc?.name = stocks[indexPath.row].name
        vc?.amount = String(stocks[indexPath.row].price.amount)
        vc?.current = stocks[indexPath.row].price.currency
        vc?.percent = String(stocks[indexPath.row].percent_change)
        vc?.volume = String(stocks[indexPath.row].volume)
        vc?.symbol = stocks[indexPath.row].symbol
        vc?.stockOne = stocks[indexPath.row]
        
        
        print(stocks[indexPath.row].name)
           navigationController?.pushViewController(vc!, animated: true)
    }
    
}
