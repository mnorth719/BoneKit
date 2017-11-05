//
//  DebugLog.swift
//  BoneKit
//
//  Tiered debug log filtration.
//
//  Created by Joshua Johnson on 11/4/17.
//

import Foundation

public enum DebugLevel: UInt {
    case error = 0
    case info
    case debug
    case verbose
    /// An overwhelming level of logging for when you absolutely have to log
    /// everything including the kitchen sink.
    case excessive
}

extension DebugLevel: Comparable {
    public static func <(lhs: DebugLevel, rhs: DebugLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func <=(lhs: DebugLevel, rhs: DebugLevel) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    public static func >=(lhs: DebugLevel, rhs: DebugLevel) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    public static func >(lhs: DebugLevel, rhs: DebugLevel) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}

public protocol LogLevelPrintable {
    var debugLogLevel: DebugLevel { get }
}

extension LogLevelPrintable {
    @discardableResult
    func printLog(_ message: String, atOrAbove logLevel: DebugLevel) -> Bool {
        if logLevel <= debugLogLevel {
            debugPrint(message)
            return true
        }
        return false
    }
}

/*  Usage Example
     class Person : LogLevelDebugPrintable {
         debugLogLevel = .verbose
         init() {
             printLog("Person Initialized", atOrAbove: .verbose)
     }
 */
