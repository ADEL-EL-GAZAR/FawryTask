//
//  DealCVC.swift
//  Plstka
//
//  Created by FAB LAB on 26/03/2021.
//

import UIKit

class CategoryCVC: UICollectionViewCell {
//    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: CategoryCellVM? {
        didSet {
            lblCategoryName.text = cellViewModel?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lblCategoryName.text = nil
    }
    
}
