//
//  HomeVM.swift
//  NewsApp
//
//  Created by FAB LAB on 02/12/2021.
//

import Foundation
import UIKit

class HomeVM: NSObject, UISearchBarDelegate {
    var reloadTableView: (() -> Void)?
    
    var allArticles = [ArticleCellVM]() {
        didSet {
            articleCellViewModels = self.allArticles
        }
    }
    
    var articleCellViewModels = [ArticleCellVM]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func getTopHeadlines() {
        let array = Array(DB_Operations().getArticles())
        self.allArticles = array.map({ self.createCellModel(article: $0) })
        
        let lastUpdateDate = K_Defaults.string(forKey: Saved.lastUpdateDate) ?? ""
        
        if lastUpdateDate.isEmpty {
            fetchArticles()
        }
        
        if let oldDate = lastUpdateDate.toDate()?.addingTimeInterval(1800), oldDate < Date() {
            fetchArticles()
        }
    }
    
    func fetchArticles() {
        
        let country = K_Defaults.string(forKey: Saved.countryCode) ?? ""
        let category = K_Defaults.string(forKey: Saved.category) ?? ""
        
        K_Network.sendRequest(function: apiService.getTopHeadlines(country: country, category: category), success: { (code, msg, response)  in
            
            do {
                let array = try response.map(to: [Article].self, keyPath: "articles")
                
                K_Defaults.set(Date().toString(), forKey: Saved.lastUpdateDate)
                
                let db = DB_Operations()
                db.deleteAll()
                for item in array {
                    db.add(object: item)
                }
                
                self.getTopHeadlines()
            } catch { }
            
        }) { (code, msg, response, errors) in
        }
    }
    
    func createCellModel(article: Article) -> ArticleCellVM {
        return ArticleCellVM(author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ArticleCellVM {
        return articleCellViewModels[indexPath.row]
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        articleCellViewModels = searchText.isEmpty ? allArticles : allArticles.filter { (item: ArticleCellVM) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
    }
}
