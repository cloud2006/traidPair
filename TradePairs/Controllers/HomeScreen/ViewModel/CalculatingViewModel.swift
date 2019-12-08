//
//  CalculatingModelView.swift
//  TradePairs
//
//  Created by Pavel Antonyuk on 08.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation

final class CalculatingViewModel {
    
    private var data: ItemPair
    weak var delegate: ViewModelDelegate?
    
    init(item: ItemPair) {
        self.data = item
    }
    
    func dataToDisplay() -> (crypt: String, currency: String, price: String) {
        (data.cryptoCurrency, data.currency, data.price)
    }
    
    func calculateSum(_ amount: Double) -> String {
        String(Double(data.price)! * amount)
    }
    
    func swapData() {
        let cached = data.currency
        data.currency = data.cryptoCurrency
        data.cryptoCurrency = cached
        data.price = String(1.0 / Double(data.price)!)
        delegate?.reloadViewData()
    }
}
