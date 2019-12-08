//
//  ItemCell.swift
//  TraidPairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import UIKit

final class ItemCell: UICollectionViewCell {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currencyLabel.text = ""
        priceLabel.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        currencyLabel.text = ""
        priceLabel.text = ""
        self.backgroundColor = .white
    }
}

extension ItemCell: DataSetupable {
    func setup<T>(data: T) {
        guard let item = data as? ItemPair else { return }
        currencyLabel.text = item.cryptoCurrency
        priceLabel.text = item.price
        self.backgroundColor = UIColor(red: 0.152, green: 0.232, blue: 0.228, alpha: 0.2)
    }
}
