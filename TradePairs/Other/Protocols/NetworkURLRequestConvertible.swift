//
//  NetworkURLRequestConvertible.swift
//  TradePairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation
import Alamofire

/// This protocol is used for logging and catching error for a specific request.
protocol NetworkURLRequestConvertible: URLRequestConvertible {
    var absolutePath: String { get }
    
    func handleError(_ json: JSON) -> ErrorHandler
}
