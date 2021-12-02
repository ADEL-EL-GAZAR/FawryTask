//
//  ProductTVC.swift
//  ProductiveFamilies
//
//  Created by FAB LAB on 20/11/2020.
//  Copyright © 2020 ADEL ELGAZAR. All rights reserved.
//

import UIKit
import Nuke

class ArticleTVC: UITableViewCell {
    @IBOutlet weak var imgArticle: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var btnViewItem: UIButton!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    var currentVC:UIViewController?
    
    var cellViewModel: ArticleCellVM? {
        didSet {
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: "Group 10340"),
                transition: .fadeIn(duration: 0.33)
            )
            if let url = URL(string: cellViewModel?.urlToImage ?? "") {
            Nuke.loadImage(with: url, options: options, into: imgArticle)
            }
            lblTitle.text = cellViewModel?.title
            lblAuthor.text = cellViewModel?.author
            lblDateTime.text = cellViewModel?.publishedAt
        }
    }
    
    @IBAction func btnViewPressed(_ sender: Any) {
        let vc = StoryBoards.Main.viewController(identifier: "ArticleDetailsVC") as! ArticleDetailsVC
        vc.viewModel = cellViewModel
        vc.modalPresentationStyle = .fullScreen
        currentVC?.present(vc, animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = nil
        lblAuthor.text = nil
        lblDateTime.text = nil
    }
    
}
