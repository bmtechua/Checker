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
        newsFavorites = getArrayFromUserDefaults(forKey: "arrNews") ?? [Articles]()
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
        print("newsOne content -", newsOne.title)
        print(newsFavorites.count)
        newsFavorites.append(newsOne)
        
        saveArrayToUserDefaults(newsFavorites, forKey: "arrNews")
    }
    
    
    @IBAction func removeBookmarks(_ sender: Any) {
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
