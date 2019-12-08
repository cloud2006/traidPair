//
//  DataSetupable.swift
//  TradePairs
//
//  Created by Pavel Antonyuk on 08.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation

/// This protocol used to setup data with ViewModels.
protocol DataSetupable {
    
    /// This funcstion sets the data.
    ///
    /// - Parameters:
    ///     - data: generic data that should be set.
    func setup<T>(data: T)
}
