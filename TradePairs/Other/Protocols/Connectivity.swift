//
//  Connectivity.swift
//  TradePairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation

/// This class declares availability of network.
protocol Connectivity {
    /// Checks vether network is available or not.
    var isNetworkAvailable: Bool { get }
}
