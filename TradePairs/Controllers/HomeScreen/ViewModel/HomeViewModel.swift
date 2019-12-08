//
//  HomeViewModel.swift
//  TraidPairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    private let numberOfItemsInSection = 2
    
    weak var delegate: ViewModelDelegate?
    var pairsArray: [ItemPair] = []
    
    func getData(_ param: NetworkRouter = .USD) {
        
        NetworkProvider.current.request(param, success: { [weak self] in
            guard let self = self else { fatalError() }
            guard let dataArray = $0["data"] as? [JSON] else { fatalError() }
            self.pairsArray = try! JSONDecoder().decode([ItemPair].self, from: JSONSerialization.data(withJSONObject: dataArray))
            self.delegate?.reloadViewData()
        }, failure: nil)
    }
    
    func getSectionsCount() -> Int {
        let fraction = Double(pairsArray.count) / 2
        let roundedNum = Int(round(fraction))
        return roundedNum
    }
    
    func getNumberOfItemsInSection() -> Int {
        numberOfItemsInSection
    }
    
    func getItem(_ indexPath: IndexPath) -> ItemPair? {
        let index = indexPath.section * numberOfItemsInSection + indexPath.row
        return pairsArray.count <= index ? nil : pairsArray[index]
    }
}
