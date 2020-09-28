//
//  LogLevel.swift
//  Logger
//
//  Created by Brian Heller on 12/18/19.
//

import Foundation

public enum LogLevel {
    case Info
    case Debug
    case Warning
    case Error
    
    static func toString(ll: LogLevel) -> String {
        switch ll {
        case .Info:
            return "DEBUG"
        case .Debug:
            return "DEBUG"
        case .Warning:
            return "WARNING"
        case .Error:
            return "ERROR"
        }
    }
}
