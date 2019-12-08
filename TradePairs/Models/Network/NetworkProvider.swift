//
//  NetworkProvider.swift
//  TraidPairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: Any]
typealias JSONClosure = ((JSON) -> Void)?
typealias FailureClosure = ((CustomError) -> Void)?

enum CustomError: Error {
    case noInternetConnection
    case undefinedError
    case jsonDecodingFailed
    case custom(String)
}

final class NetworkProvider {
    
    static var current = NetworkProvider()
    
    lazy var sessionManager: SessionManager = {
        let manager = SessionManager(configuration: URLSessionConfiguration.default)
        return manager
    }()
    
    func request(_ router: NetworkURLRequestConvertible, success: JSONClosure = nil, failure: FailureClosure = nil) {
        //Handle network availability
        guard isNetworkAvailable else { failure?(.noInternetConnection); return }
        
        sessionManager
            .request(router)
            .responseJSON(options: [.mutableContainers, .allowFragments]) { [weak self] in
                switch $0.result {
                case .success(let value):
                    guard let statusCode = $0.response?.statusCode,
                        let json = value as? JSON else {
                            failure?(.undefinedError);
                            return }
                    switch statusCode {
                    case 200...204: success?(json)
                    default: self?.logError(router.handleError(json), completion: failure)
                    }
                case .failure(let error):
                     self?.logError((router, .custom(error.localizedDescription)), completion: failure)
                }
        }
    }
    
    //MARK: - ErrorHandler
    private func logError(_ error: ErrorHandler, completion: FailureClosure = nil) {
        EventLogger.logError(error)
        
        completion?(error.1)
    }
    
    func handleError(_ json: JSON) -> CustomError {
        if let message = json["detail"] as? String {
            return (.custom(message))
        } else if let errors = json["errors"] as? [JSON], let first = errors.first, let error = first["detail"] as? String {
            return (.custom(error))
        } else {
            return (.undefinedError)
        }
    }
}

//MARK: - Connectivity
extension NetworkProvider: Connectivity {
    var isNetworkAvailable: Bool {
        guard let manager = NetworkReachabilityManager() else { return false }
        return manager.isReachable
    }
}
