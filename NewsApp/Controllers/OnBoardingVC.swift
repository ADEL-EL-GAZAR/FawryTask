//
//  OnBoardingVC.swift
//  NewsApp
//
//  Created by FAB LAB on 02/12/2021.
//

import UIKit
import SKCountryPicker
import DeveloperToolsSupport

class OnBoardingVC: UIViewController {
    @IBOutlet weak var btnSelectCountry: UIView!
    @IBOutlet weak var imgCountryLogo: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var countryCode = ""
    var category = ""

    lazy var viewModel = {
        OnBoardingVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initView() {
        collectionView.register(CategoryCVC.nib, forCellWithReuseIdentifier: CategoryCVC.identifier)
        
        btnSelectCountry.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCountryAction)))
    }

    func initViewModel() {
        // Get employees data
        viewModel.getCategoryList()
        
        // Reload TableView closure
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc func selectCountryAction(sender : UITapGestureRecognizer) {
        let countryController = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: SKCountryPicker.Country) in

            self?.lblCountryName.text = country.countryName
            self?.imgCountryLogo.image = country.flag
            self?.countryCode = country.countryCode
            
        }
        // can customize the countryPicker here e.g font and color
        countryController.detailColor = UIColor.red
    }
    
    @IBAction func btnYallaPressed(_ sender: Any) {
        
        // check country
        if countryCode.isEmpty { alertError(message: "Select Country First") }

        // check category
        else if category.isEmpty { alertError(message: "Select category First") }

        // continue
        else {
            K_Defaults.set(countryCode, forKey: Saved.countryCode)
            K_Defaults.set(category, forKey: Saved.category)

            let vc = StoryBoards.Main.viewController(identifier: "HomeVC")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension OnBoardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryCellViewModels.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        category = viewModel.categoryCellViewModels[indexPath.row].name
        self.alertError(message: "\(category) selected")
    }
}

extension OnBoardingVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2.0
        let height = width*2/3

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
