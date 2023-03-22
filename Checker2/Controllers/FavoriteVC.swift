//
//  FavoriteVC.swift
//  Checker2
//
//  Created by bmtech on 20.07.2022.
//

import UIKit

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var networkService = NetworkService()
    var defaults = UserDefaults()
    var newsFavorites : [Articles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Bookmarks"

        setupCollectionView()
        newsFavorites = saveAndLoad.shared.getArrayFromUserDefaults(forKey:"arrNews") ?? [Articles]()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailNewsCVC", bundle: nil), forCellWithReuseIdentifier: "DetailNewsCVC")
    }
}

extension FavoriteVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return newsFavorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailNewsCVC", for: indexPath) as! DetailNewsCVC
        let news = newsFavorites[indexPath.row]
        let completeLink = news.urlToImage ?? "noImage"
        cell.newsImageView.downloaded(from: completeLink)
        cell.setupNewsCell(news: news)
        cell.layer.cornerRadius = 15

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.size.width - 20
        return CGSize(width: width, height: 191)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailNewsVC") as? DetailNewsVC
 
        let news = newsFavorites[indexPath.row]
        let completeLink = news.urlToImage ?? "noImage"
        vc?.titleNews = news.title
        vc?.descriptionNews = news.description!
        vc?.contentNews = news.content!
        vc?.image = completeLink
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
