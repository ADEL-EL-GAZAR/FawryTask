//
//  DB_Operations.swift
//  NewsApp
//
//  Created by FAB LAB on 02/12/2021.
//

import Foundation
import RealmSwift

class DB_Operations {
    
    let localRealm = try! Realm()
    
    func add(object: Object) {
        try! localRealm.write {
            localRealm.add(object)
        }
    }
    
    func getArticles() -> Results<Article> {
        return localRealm.objects(Article.self)
    }
    
    func delete(object: Object) {
        try! localRealm.write {
            localRealm.delete(object)
        }
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }
}
