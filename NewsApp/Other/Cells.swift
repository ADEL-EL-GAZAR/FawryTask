//
//  Cells.swift
//  ProductiveFamilies
//
//  Created by FAB LAB on 26/02/2021.
//  Copyright © 2021 ADEL ELGAZAR. All rights reserved.
//

import Foundation

protocol Cells {
    func refresh(msg:String, isSuccess:Bool)
}

extension Cells {
    func modifyFavourite(sender:UIButton, product:Product) {
        let api_token = K_Defaults.string(forKey: Saved.token) ?? ""
        if api_token.isEmpty {
            var favArray = Archiver.loadFavourite() ?? []
            
            if let index = product.indexof_favourite(), sender.image(for: .normal) == UIImage.init(named: "heart_selected") {
                favArray.remove(at: index)
            } else {
                favArray.append(product)
            }
            Archiver.saveFavourite(products: favArray)
            self.refresh(msg: "", isSuccess: true)
        } else {
            if sender.image(for: .normal) == UIImage.init(named: "heart_selected") {
                removeProductFromFavourite(productID: product.productID)
            } else {
                addProductToFavourite(productID: product.productID)
            }
        }
    }
    
    func addProductToCart(product:Product) {
        let api_token = K_Defaults.string(forKey: Saved.token) ?? ""
        if api_token.isEmpty {
            var cartArray = Archiver.loadCart() ?? []
            
            if let index = product.indexof_cart(), product.quantity > cartArray[index].cartQuantity {
                cartArray[index].cartQuantity = cartArray[index].cartQuantity + 1
            } else {
                product.cartQuantity = 1
                cartArray.append(product)
            }
            Archiver.saveCart(products: cartArray)
            self.refresh(msg: "", isSuccess: true)
        } else {
            addItemToCart(productID: product.productID, quantity: 1)
        }
    }
    
    func removeProductFromCart(product:Product) {
        let api_token = K_Defaults.string(forKey: Saved.token) ?? ""
        if api_token.isEmpty {
            let cartArray = Archiver.loadCart() ?? []
            
            if let index = product.indexof_cart(), product.quantity > 1 {
                cartArray[index].cartQuantity = cartArray[index].cartQuantity - 1
            }
            Archiver.saveCart(products: cartArray)
            self.refresh(msg: "", isSuccess: true)
        } else {
            removeItemToCart(productID: product.productID, quantity: 1)
        }
    }
    
    func deleteProductFromCart(product:Product) {
        let api_token = K_Defaults.string(forKey: Saved.token) ?? ""
        if api_token.isEmpty {
            var cartArray = Archiver.loadCart() ?? []
            
            if let index = product.indexof_cart() {
                cartArray.remove(at: index)
            }
            Archiver.saveCart(products: cartArray)
            self.refresh(msg: "", isSuccess: true)
        } else {
            removeFromCart(productID: product.productID)
        }
    }
    
    private func addItemToCart(productID: String, quantity: Int) {
        K_Network.sendRequest(function: apiService.addItemToCart(productID: productID, quantity: quantity), showLoading: false, success: { (code, msg, response)  in
            self.refresh(msg: msg, isSuccess: true)
        }) { (code, msg, response, errors) in
            self.refresh(msg: msg, isSuccess: false)
        }
    }
    
    private func removeItemToCart(productID: String, quantity: Int) {
        K_Network.sendRequest(function: apiService.removeItemToCart(productID: productID, quantity: quantity), showLoading: false, success: { (code, msg, response)  in
            self.refresh(msg: msg, isSuccess: true)
        }) { (code, msg, response, errors) in
            self.refresh(msg: msg, isSuccess: false)
        }
    }
    
    private func addProductToFavourite(productID: String) {
        K_Network.sendRequest(function: apiService.addProductToFavourite(productID: productID), success: { (code, msg, response)  in
                self.refresh(msg: msg, isSuccess: true)
        }) { (code, msg, response, errors) in
        }
    }
    
    private func removeProductFromFavourite(productID: String) {
        K_Network.sendRequest(function: apiService.removeProductFromFavourite(productID: productID), success: { (code, msg, response)  in
            self.refresh(msg: msg, isSuccess: true)
        }) { (code, msg, response, errors) in
        }
    }
    
    private func removeFromCart(productID: String) {
        K_Network.sendRequest(function: apiService.removeProductFromCart(productID: productID), success: { (code, msg, response)  in
            self.refresh(msg: msg, isSuccess: true)
        }) { (code, msg, response, errors) in
        }
    }
}
