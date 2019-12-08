//
//  HomeViewController.swift
//  TraidPairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var changeCurrencyButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var picker: UIPickerView!
    
    private var viewModel = HomeViewModel()
    var pairsArray: [ItemPair] = []
    
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 40.0,
                                             bottom: 20.0,
                                             right: 40.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.isHidden = true
        
        viewModel.delegate = self
        viewModel.getData()
        
        changeCurrencyButton.setTitle(NetworkRouter.USD.currency, for: .normal)
        picker.delegate = self
    }
    
    @IBAction func chooseCurrencyPressed(_ sender: Any) {
        picker.isHidden = false
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell else { fatalError() }
        cell.setup(data: viewModel.getItem(indexPath))
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getSectionsCount()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        guard let data = viewModel.getItem(indexPath) else { return }
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculatingViewController") as? CalculatingViewController else { fatalError() }
        vc.trasferedData = data
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * 3
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / 2
      
      return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}

extension HomeViewController: ViewModelDelegate {
    func updateLoadingStatus(_ newStatus: Bool) {
        print(newStatus)
    }
    
    func reloadViewData() {
        collectionView.reloadData()
    }
    
    func handleError(_ error: Error) {
        print(error.localizedDescription)
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return NetworkRouter.allCases[row].currency
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeCurrencyButton.setTitle(NetworkRouter.allCases[row].currency, for: .normal)
        picker.isHidden = true
        viewModel.getData(NetworkRouter.allCases[row])
    }
}
