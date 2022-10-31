//
//  StockCell.swift
//  Checker2
//
//  Created by bmtech on 20.07.2022.
//

import UIKit

class StockCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupStockCell(stock: Stock) {
        nameLabel.text = stock.name
        amountLabel.text = String(stock.price.amount)
        percentLabel.text = String(stock.percent_change)
        
        if stock.percent_change <= 0 {
            percentLabel.textColor = .red
        } else {
            percentLabel.textColor = .green

        }
    }
    
}
