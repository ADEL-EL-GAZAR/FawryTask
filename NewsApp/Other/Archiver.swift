//
//  Archiver.swift
//  ProductiveFamilies
//
//  Created by FAB LAB on 22/02/2021.
//  Copyright © 2021 ADEL ELGAZAR. All rights reserved.
//

import Foundation

class Archiver {
    private static let FavouriteKey = "FavouriteKey"
    private static let CartKey = "CartKey"

    private static func archiveProduct(products : [Product]) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: products as NSArray) as NSData
    }
    
    static func loadFavourite() -> [Product]? {
        if let unarchivedObject = UserDefaults.standard.object(forKey: FavouriteKey) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Product]
        }
        return nil
    }

    static func saveFavourite(products : [Product]?) {
        let archivedObject = archiveProduct(products: products!)
        UserDefaults.standard.set(archivedObject, forKey: FavouriteKey)
        UserDefaults.standard.synchronize()
    }
    
    static func loadCart() -> [Product]? {
        if let unarchivedObject = UserDefaults.standard.object(forKey: CartKey) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Product]
        }
        return nil
    }

    static func saveCart(products : [Product]?) {
        let archivedObject = archiveProduct(products: products!)
        UserDefaults.standard.set(archivedObject, forKey: CartKey)
        UserDefaults.standard.synchronize()
        K_Defaults.setValue("\(products?.count ?? 0)", forKey: Saved.cartCount)
    }
    
    func tets() {
        
    }
}
