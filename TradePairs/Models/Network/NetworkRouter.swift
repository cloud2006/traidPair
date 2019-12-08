//
//  NetworkRouter.swift
//  TradePairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkRouter: NetworkURLRequestConvertible, CaseIterable {
    
    case USD
    case EUR
    case GBP
    
    var absolutePath: String {
        return "https://cex.io/api/last_prices/".appending(currency)
    }
    
    var currency: String {
        switch self {
        case .USD: return "USD"
        case .EUR: return "EUR"
        case .GBP: return "GBP"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try absolutePath.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 30
        
        return urlRequest
    }
    
    func handleError(_ json: JSON) -> ErrorHandler {
        if let message = json["detail"] as? String {
            return (self, .custom(message))
        } else if let errors = json["errors"] as? [JSON], let first = errors.first, let error = first["detail"] as? String {
            return (self, .custom(error))
        } else {
            return (self, .undefinedError)
        }
    }
}
