//
//  StockNew2VC.swift
//  Checker2
//
//  Created by bmtech on 20.03.2023.
//

import UIKit

class StockNew2VC: UIViewController {

    @IBOutlet weak var collectionViewGroup: UICollectionView!
    @IBOutlet weak var tableViewStock: UITableView!
    
    var myColorGray = UIColor(hex: 0x1E1F26)
    var myColorBlack = UIColor(hex: 0x16171C)
    
    var stock = Groups()
    var selectedGroup = 0
    
    var networkService = NetworkService()
    var defaults = UserDefaults()

    var stocks: [Stock] = []
    var stocksAll: [Stock] = []
    var stocksFavorites : [Stock] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Stocks"
        setupView()
        
        networkService.fetchPostData { (stocks) in
            self.stocksAll = stocks.stock
            self.collectionViewGroup.reloadData()
            self.tableViewStock.reloadData()
        }
        
        collectionViewGroup.reloadData()
        stocksFavorites = getArrayFromUserDefaults(forKey: "arr") ?? stocks
    }
    
    func setupView() {
        tableViewStock.delegate = self
        tableViewStock.dataSource = self
        tableViewStock.register(UINib(nibName: "StockCell", bundle: nil), forCellReuseIdentifier: "StockCell")
        
        collectionViewGroup.delegate = self
        collectionViewGroup.dataSource = self
        collectionViewGroup.register(UINib(nibName: "StockGroupCell", bundle: nil), forCellWithReuseIdentifier: "StockGroupCell")
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
}

extension StockNew2VC: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource  {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewStock.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as! StockCell
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stock.groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewGroup.dequeueReusableCell(withReuseIdentifier: "StockGroupCell", for: indexPath) as! StockGroupCell
        let group = stock.groups[indexPath.row]
        cell.nameLabel.text = group.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1 {
            stocks = stocksAll
            tableViewStock.reloadData()
        } else if indexPath.item == 0 {
            stocks = stocksFavorites
            tableViewStock.reloadData()
        }
    } 
}
