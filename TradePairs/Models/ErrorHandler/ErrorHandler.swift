//
//  ErrorHandler.swift
//  TradePairs
//
//  Created by Pavel Antonyuk on 07.12.2019.
//  Copyright © 2019 Pavel Antonyuk. All rights reserved.
//

import Foundation
typealias ErrorHandler = (NetworkURLRequestConvertible, CustomError)

final class EventLogger {
    static func logError(_ handler: ErrorHandler) {
        #if DEBUG
        debugPrint("---------------")
        debugPrint(handler.0.absolutePath)
        debugPrint(handler.1)
        #endif
        
        var attributes: JSON = ["url": handler.0.absolutePath, "errorMessage": handler.1.localizedDescription]
    }
}
