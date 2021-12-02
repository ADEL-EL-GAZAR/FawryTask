//
//  HomeVC.swift
//  NewsApp
//
//  Created by FAB LAB on 02/12/2021.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    lazy var viewModel = {
        HomeVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }

    func initView() {
        searchBar.delegate = viewModel
        
        // TableView customization
        tableView.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false

        tableView.register(ArticleTVC.nib, forCellReuseIdentifier: ArticleTVC.identifier)
    }

    func initViewModel() {
        // Get employees data
        viewModel.getTopHeadlines()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTVC.identifier, for: indexPath) as? ArticleTVC else { return UITableViewCell() }
        cell.currentVC = self
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
}
