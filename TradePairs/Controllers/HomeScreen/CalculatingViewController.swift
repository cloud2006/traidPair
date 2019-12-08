//
//  CalculatingViewController.swift
//  TradePairs
//
//  Created by Pavel Antonyuk on 08.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import UIKit

final class CalculatingViewController: UIViewController {
    
    @IBOutlet weak var pairLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var calculatedSumLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var cryptoCurrencyLabel: UILabel!
    @IBOutlet weak var swapButton: UIButton!
    
    private var viewModel: CalculatingViewModel!
    var trasferedData: ItemPair!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CalculatingViewModel(item: trasferedData)
        viewModel.delegate = self
        
        amountTextField.becomeFirstResponder()
        amountTextField.addTarget(self, action: #selector(CalculatingViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        setupUI()
    }
    
    func setupUI() {
        let data = viewModel.dataToDisplay()
        pairLabel.text = "\(data.crypt) / \(data.currency)"
        priceLabel.text = data.price
        calculatedSumLabel.text = "0"
        currencyLabel.text = data.currency
        cryptoCurrencyLabel.text = data.crypt
        calculatedSumLabel.text = viewModel.calculateSum(Double(self.amountTextField.text!) ?? 0)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let amount = Double(self.amountTextField.text!) ?? 0
        calculatedSumLabel.text = viewModel.calculateSum(amount)
    }

    @IBAction func swapButtonPressed(_ sender: Any) {
        viewModel.swapData()
    }
}

extension CalculatingViewController: ViewModelDelegate {
    func updateLoadingStatus(_ newStatus: Bool) {
        
    }
    
    func reloadViewData() {
        setupUI()
    }
    
    func handleError(_ error: Error) {
        
    }
}
