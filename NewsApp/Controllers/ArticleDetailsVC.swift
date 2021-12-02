//
//  ArticleDetailsVC.swift
//  NewsApp
//
//  Created by FAB LAB on 02/12/2021.
//

import UIKit
import Nuke

class ArticleDetailsVC: UIViewController {
    
    @IBOutlet weak var imgPreviewed: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAuther: UILabel!
    @IBOutlet weak var btnRedirect: UIView!
    
    var viewModel:ArticleCellVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        btnRedirect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(redirectAction)))
    }
    
    @objc func redirectAction(sender : UITapGestureRecognizer) {
        if let url = URL(string: viewModel?.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func initView() {
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "Group 10340"),
            transition: .fadeIn(duration: 0.33)
        )
        if let url = URL(string: viewModel?.urlToImage ?? "") {
        Nuke.loadImage(with: url, options: options, into: imgPreviewed)
        }
        lblTitle.text = viewModel?.title
        lblDescription.text = viewModel?.content
        lblAuther.text = viewModel?.author
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
