//
//  ViewModelDelegate.swift
//  TraidPairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    /// Notifies current loading status
    func updateLoadingStatus(_ newStatus: Bool)
    
    /// Notifies about reload data
    func reloadViewData()
    
    /// Notifies about the error
    func handleError(_ error: Error)
}
