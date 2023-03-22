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
    
    var name = ""
    var text = ""
    var time = ""
    var image = UIImage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageView.layer.cornerRadius = 15
    }
    
    func setupNewsCell(news: Articles) {
        DispatchQueue.main.async {
            self.nameNewsLabel.text = news.title
            self.textNewsLabel.text = news.description
            let date = stringToDate(date: news.publishedAt!)
            self.timeNewsLabel.text = date.timeAgo()
        }
    }
    
    @IBAction func buttonShare(_ sender: Any) {
        
        
    }
    
    @IBAction func buttonFavorite(_ sender: Any) {

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
