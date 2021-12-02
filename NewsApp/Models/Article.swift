//
//  TeamMember.swift
//  Maly7a-Provider
//
//  Created by Sayed Reda on 2/7/18.
//  Copyright © 2018 hassan. All rights reserved.
//

import Foundation
import Mapper
import RealmSwift

class Article: Object, Mappable {
    var source:ArticleSource?
    @Persisted var author = ""
    @Persisted var title = ""
    @Persisted var desc = ""
    @Persisted var url = ""
    @Persisted var urlToImage = ""
    @Persisted var publishedAt = ""
    @Persisted var content = ""
    
    override init () {
    }
    
    required init (map: Mapper) throws {
        source = map.optionalFrom("source")
        author = map.optionalFrom("author") ?? ""
        title = map.optionalFrom("title") ?? ""
        desc = map.optionalFrom("description") ?? ""
        url = map.optionalFrom("url") ?? ""
        urlToImage = map.optionalFrom("urlToImage") ?? ""
        publishedAt = map.optionalFrom("publishedAt") ?? ""
        content = map.optionalFrom("content") ?? ""
    }
    
    convenience init(author: String, title: String, desc: String, url: String, urlToImage: String, publishedAt: String, content: String) {
        self.init()
        self.author = author
        self.title = title
        self.desc = desc
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
