//
//  NetworkService.swift
//  Checker2
//
//  Created by bmtech on 20.07.2022.
//

import Foundation

let urlString = "http://phisix-api3.appspot.com/stocks.json"
let date = dateSet()
let urlStringNews = "https://newsapi.org/v2/everything?q=Apple&from=&sortBy=popularity&apiKey=ffc40f9cda57418e9b3600f003ed11b5"
//let urlStringNews = "https://newsapi.org/v2/everything?q=Apple&from=" + date + "&sortBy=popularity&apiKey=ffc40f9cda57418e9b3600f003ed11b5" "https://newsapi.org/v2/everything?q=Apple&from=2022-11-01&sortBy=popularity&apiKey=ffc40f9cda57418e9b3600f003ed11b5"

class NetworkService {

func fetchPostData(completionHandler: @escaping (StocksAll) -> Void) {
    guard let url = URL(string: urlString) else {return}
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        DispatchQueue.main.async {
            guard let dataResponse = data else {
                return
            }
            
            do {
                let stockData = try JSONDecoder().decode( StocksAll.self, from: dataResponse)
                completionHandler(stockData)
                print("2", stockData.stock[0].name)
                
            } catch {
                print(error)
            }
        }
    }
    task.resume()
}
    
    func fetchPostDataNews(completionHandler: @escaping (News) -> Void) {
        guard let url = URL(string: urlStringNews) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let dataResponse = data else {
                    return
                }
                
                do {
                    let newsData = try JSONDecoder().decode( News.self, from: dataResponse)
                    completionHandler(newsData)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }

}

