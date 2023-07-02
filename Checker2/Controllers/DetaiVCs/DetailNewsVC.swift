//
//  DetailNewsVC.swift
//  Checker2
//
//  Created by bmtech on 26.07.2022.
//

import UIKit

class DetailNewsVC: UIViewController {
    
    var defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    
    var newsOne: Articles!
    var news: [Articles] = []
    var newsFavorites: [Articles] = []

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var newsLargeImage: UIImageView!
    
    var titleNews = ""
    var descriptionNews = ""
    var contentNews = ""
    var image = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNews()
        newsFavorites = saveAndLoad.shared.getArrayFromUserDefaults(forKey: "arrNews") ?? [Articles]()
    }
    
    func setNews() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.titleNews
            self.descriptionLabel.text = self.descriptionNews
            self.contentLabel.text = self.contentNews
            self.newsLargeImage.downloaded(from: self.image)
        }
    }
    
    @IBAction func addBookmarks(_ sender: Any) {
        newsFavorites.append(newsOne)
        saveAndLoad.shared.saveArrayToUserDefaults(newsFavorites, forKey: "arrNews")
    }
    
    @IBAction func removeBookmarks(_ sender: Any) {
    }
    
}
