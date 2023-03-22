//
//  NewsVC.swift
//  Checker2
//
//  Created by bmtech on 20.07.2022.
//

import UIKit

class NewsVC: UIViewController{
    
    var myColorBlack = UIColor(hex: 0x16171C)
    var networkService = NetworkService()
    var news: [Articles] = []
    var numberCell = 0
   

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News"
        
        setupCollView()
        view.backgroundColor = myColorBlack
        
        networkService.fetchPostDataNews { (news) in
            self.news = news.articles
            self.collectionView.reloadData()
        }
    }
    
    func setupCollView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailNewsCVC", bundle: nil), forCellWithReuseIdentifier: "DetailNewsCVC")
    }
    
    func cellColor() {

    }
}

extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count news",news.count)
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailNewsCVC", for: indexPath) as! DetailNewsCVC
        let news = news[indexPath.row]
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
        
        let news = news[indexPath.row]
        let completeLink = news.urlToImage ?? "noImage"
        
        
        vc?.titleNews = news.title
        vc?.descriptionNews = news.description!
        vc?.contentNews = news.content!
        vc?.image = completeLink
        vc?.newsOne = news

        
        print(news.title)
           navigationController?.pushViewController(vc!, animated: true)
    }
    
}
