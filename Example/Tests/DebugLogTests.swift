//
//  DebugLogTests.swift
//  BoneKit_Tests
//
//  Created by Josh on 11/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
@testable import BoneKit

class DebugLogTests: XCTestCase {
    
    func testErrorLogFilterLevel() {
        let errorLogger = DebugLogTester(.error)
        errorLogger.runTestSuite(shouldPrintError: true)
    }
    
    func testInfoLogFilterLevel() {
        let errorLogger = DebugLogTester(.info)
        errorLogger.runTestSuite(shouldPrintError: true, shouldPrintInfo: true)
    }
    
    func testDebugLogFilterLevel() {
        let errorLogger = DebugLogTester(.debug)
        errorLogger.runTestSuite(shouldPrintError: true, shouldPrintInfo: true,
                                 shouldPrintDebug: true)
    }
    
    func testVerboseLogFilterLevel() {
        let errorLogger = DebugLogTester(.verbose)
        errorLogger.runTestSuite(shouldPrintError: true, shouldPrintInfo: true,
                                 shouldPrintDebug: true, shouldPrintVerbose: true)
    }
    
    func testExcessiveLogFilterLevel() {
        let excessiveLogger = DebugLogTester(.excessive)
        excessiveLogger.runTestSuite(shouldPrintError: true, shouldPrintInfo: true,
                                     shouldPrintDebug: true, shouldPrintVerbose: true,
                                     shouldPrintExcessive: true)
    }
    
    
}

extension DebugLogTests {
    fileprivate struct DebugLogTester : LogLevelPrintable {
        var debugLogLevel: DebugLevel
        init(_ logLevel: DebugLevel) {
            self.debugLogLevel = logLevel
        }
        
        func runTestSuite(shouldPrintError: Bool, shouldPrintInfo: Bool = false, shouldPrintDebug: Bool = false,
                          shouldPrintVerbose: Bool = false, shouldPrintExcessive: Bool = false) {
            
            let didPrintError = printLog("", atOrAbove: .error)
            XCTAssertEqual(shouldPrintError, didPrintError)
            
            let didPrintInfo = printLog("", atOrAbove: .info)
            XCTAssertEqual(shouldPrintInfo, didPrintInfo)
            
            let didPrintDebug = printLog("", atOrAbove: .debug)
            XCTAssertEqual(shouldPrintDebug, didPrintDebug)
            
            let didPrintVerbose = printLog("", atOrAbove: .verbose)
            XCTAssertEqual(shouldPrintVerbose, didPrintVerbose)
            
            let didPrintExcessive = printLog("", atOrAbove: .excessive)
            XCTAssertEqual(shouldPrintExcessive, didPrintExcessive)
            
            
        }
    }
}
