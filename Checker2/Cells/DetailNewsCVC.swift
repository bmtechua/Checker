//
//  DetailNewsCVC.swift
//  Checker2
//
//  Created by bmtech on 25.07.2022.
//

import UIKit

class DetailNewsCVC: UICollectionViewCell {
    @IBOutlet weak var nameNewsLabel: UILabel!
    @IBOutlet weak var textNewsLabel: UILabel!
    @IBOutlet weak var timeNewsLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImageView.layer.cornerRadius = 15
    }
    
    func setupNewsCell(news: Articles) {
        DispatchQueue.main.async {
            self.nameNewsLabel.text = news.title
            self.textNewsLabel.text = news.description
            self.timeNewsLabel.text = "test"
        }
    }
}
