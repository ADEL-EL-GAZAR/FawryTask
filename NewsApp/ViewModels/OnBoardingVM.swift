//
//  OnBoardingVM.swift
//  NewsApp
//
//  Created by FAB LAB on 02/12/2021.
//

import Foundation

class OnBoardingVM {
    var reloadCollectionView: (() -> Void)?
    
    var categoryCellViewModels = [CategoryCellVM]() {
        didSet {
            reloadCollectionView?()
        }
    }
    
    func getCategoryList() {
        self.categoryCellViewModels = ["business", "entertainment", "general", "health", "science", "sports", "technology"].map({ self.createCellModel(category: $0) })
    }
    
    func createCellModel(category: String) -> CategoryCellVM {
        return CategoryCellVM(name: category)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CategoryCellVM {
        return categoryCellViewModels[indexPath.row]
    }
}
