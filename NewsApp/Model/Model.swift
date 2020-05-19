//
//  Model.swift
//  NewsApp
//
//  Created by Zaitsev Aleksey on 15.05.2020.
//  Copyright © 2020 Zaitsev Aleksey. All rights reserved.
//

import Foundation

var articles: [Article] {
    guard let data = try? Data(contentsOf: urlToData) else { return [] }
    guard let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [] }
    guard let rootDictionary = rootDictionaryAny as? Dictionary<String, Any> else { return [] }
    
    if let array = rootDictionary["articles"] as? [Dictionary<String, Any>] {
        var returnArray: [Article] = []
        for dict in array {
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        return returnArray
    }
    return []
}

var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

func loadNews(completionHandler: (()-> Void)?) {
        let url = URL(string: "http://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=f82881d5dda4439bb081c127de72aaf5")
        
        let session = URLSession(configuration: .default)
        
        let downloadTask = session.downloadTask(with: url!) { (urlFile, response, error) in
            if urlFile != nil {
                try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
                print(urlToData)
                print("Articles count: \(articles.count)")
                completionHandler?()
            }
        }
        downloadTask.resume()
}
