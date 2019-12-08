//
//  ItemPair.swift
//  TradePairs
//
//  Created by Pavel Antonyuk on 08.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation

struct ItemPair: Codable {
    var price: String
    var currency: String
    var cryptoCurrency: String
    
    private enum CodingKeys: String, CodingKey {
        case price = "lprice"
        case currency = "symbol2"
        case cryptoCurrency = "symbol1"
    }
}
