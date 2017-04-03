//
//  ViewController.swift
//  ParsingJson
//
//  Created by luk dro on 3/30/17.
//  Copyright © 2017 luk dro. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var arrayToSend = [Articles]()
    var articles = [Articles]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
       cell.filmTitle.text = articles[indexPath.row].title
       cell.filmImage.downloadImage(from: self.articles[indexPath.item].urlToImage!)
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "second") as! SecondViewController
        sVC.author = self.articles[indexPath.item].author!
        sVC.desc = self.articles[indexPath.item].desc!
        sVC.url = self.articles[indexPath.item].url!
        self.present(sVC, animated: true)
        
      
    }
    
    func fetchData()
    {
        let urlRequest = URLRequest(url: URL(string:"https://newsapi.org/v1/articles?source=the-economist&sortBy=latest&apiKey=be430ec4af5a431696f404f925272a4d" )!)
        let task = URLSession.shared.dataTask(with: urlRequest)
        {( data,response,error) in
        if error != nil {
            print(error!.localizedDescription)
        }
        else {
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as![String:AnyObject]
                if let articlesFromJson = json["articles"] as? [[String:AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = Articles()
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let newsUrl = articleFromJson["url"] as? String, let imageUrl = articleFromJson["urlToImage"] as? String {
                            
                            article.author = author
                            article.title = title
                            article.desc = desc
                            article.url = newsUrl
                            article.urlToImage = imageUrl
                            
                        }
                        self.articles.append(article)
                    }
                    
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
               

            }
            catch {
                print("error in json serialization")
            }
        }
        
    }
task.resume()
}

}
extension UIImageView {
    func downloadImage(from url: String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest){(data,response,error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
    }
        task.resume()
}
}
