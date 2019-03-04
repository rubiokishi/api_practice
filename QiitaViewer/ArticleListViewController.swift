//
//  ArticleListViewController        .swift
//  QiitaViewer
//
//  Created by rubio on 2019/03/02.
//  Copyright © 2019 rubio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticleListViewController: UITableViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["link"]!
        return cell
    }
    
    
    
    
    var articles: [[String : String?]] = []
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "新着記事"
        getArticles()
    }
    
    func getArticles() {
        Alamofire.request("https://qiita.com/api/v2/items")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach { (_, json) in
                    let article: [String: String?] = [
                        "title": json["title"].string,
                        "link": json["url"].string
                    ]
                    self.articles.append(article)
                }
                self.tableView.reloadData()
        }
    }


}
