//
//  ObservableTests.swift
//  BoneKit_Tests
//
//  Created by Matt  North on 10/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import BoneKit

class ObservableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testObservableStruct() {
        let testStruct: Observable<StructTestSubject> = Observable(StructTestSubject(identifier: "JetFuelMeme"))
        let newTestStruct = StructTestSubject(identifier: "WakeUpSheeple")
        let valueWillChange = expectation(description: "Value will change should notify listener")
        let valueDidChange = expectation(description: "Value did change should notify listener")
        
        testStruct.onEvent(.valueWillChange) { newValue in
            if newValue.identifier == newTestStruct.identifier {
                valueWillChange.fulfill()
            }
        }
        
        testStruct.onEvent(.valueDidChange) { newValue in
            if newValue.identifier == newTestStruct.identifier {
                valueDidChange.fulfill()
            }
        }
        
        testStruct.value = newTestStruct
        wait(for: [valueWillChange, valueDidChange], timeout: 0.2, enforceOrder: true)
    }
    
    func testObservableClass() {
        let testStruct: Observable<ClassTestSubject> = Observable(ClassTestSubject("JetFuelMeme"))
        let newTestStruct = ClassTestSubject("WakeUpSheeple")
        let valueWillChange = expectation(description: "Value will change should notify listener")
        let valueDidChange = expectation(description: "Value did change should notify listener")
        
        testStruct.onEvent(.valueWillChange) { newValue in
            if newValue.identifier == newTestStruct.identifier {
                valueWillChange.fulfill()
            }
        }
        
        testStruct.onEvent(.valueDidChange) { newValue in
            if newValue.identifier == newTestStruct.identifier {
                valueDidChange.fulfill()
            }
        }
        
        testStruct.value = newTestStruct
        wait(for: [valueWillChange, valueDidChange], timeout: 0.2, enforceOrder: true)
    }
    
    func testCustomOperator() {
        let testStruct: Observable<ClassTestSubject> = Observable(ClassTestSubject("JetFuelMeme"))
        let newTestStruct = ClassTestSubject("WakeUpSheeple")
        let valueWillChange = expectation(description: "Value will change should notify listener")
        let valueDidChange = expectation(description: "Value did change should notify listener")
        
        testStruct.onEvent(.valueWillChange) { newValue in
            if newValue.identifier == newTestStruct.identifier {
                valueWillChange.fulfill()
            }
        }
        
        testStruct.onEvent(.valueDidChange) { newValue in
            if newValue.identifier == newTestStruct.identifier {
                valueDidChange.fulfill()
            }
        }
        
        testStruct << newTestStruct
        wait(for: [valueWillChange, valueDidChange], timeout: 0.2, enforceOrder: true)
    }
    
    func testClassPropertyUpdate() {
        func testObservableClass() {
            let testStruct: Observable<ClassTestSubject> = Observable(ClassTestSubject("JetFuelMeme"))
            let valueWillChange = expectation(description: "Value will change should notify listener")
            let valueDidChange = expectation(description: "Value did change should notify listener")
            
            testStruct.onEvent(.valueWillChange) { newValue in
                if newValue.identifier == "FalseFlag" {
                    valueWillChange.fulfill()
                }
            }
            
            testStruct.onEvent(.valueDidChange) { newValue in
                if newValue.identifier == "FalseFlag" {
                    valueDidChange.fulfill()
                }
            }
            
            testStruct.value.identifier = "FalseFlag"
            wait(for: [valueWillChange, valueDidChange], timeout: 0.2, enforceOrder: true)
        }
    }
    
    func testUpdateStructProperty() {
        let testStruct: Observable<StructTestSubject> = Observable(StructTestSubject(identifier: "JetFuelMeme"))
        let valueWillChange = expectation(description: "Value will change should notify listener")
        let valueDidChange = expectation(description: "Value did change should notify listener")
        
        testStruct.onEvent(.valueWillChange) { newValue in
            if newValue.identifier == "FalseFlag" {
                valueWillChange.fulfill()
            }
        }
        
        testStruct.onEvent(.valueDidChange) { newValue in
            if newValue.identifier == "FalseFlag" {
                valueDidChange.fulfill()
            }
        }
        
        testStruct.value.identifier = "FalseFlag"
        wait(for: [valueWillChange, valueDidChange], timeout: 0.2, enforceOrder: true)
    }
    
    func testRemoveObserver() {
        let testStruct: Observable<StructTestSubject> = Observable(StructTestSubject(identifier: "JetFuelMeme"))
        
        testStruct.onEvent(.valueDidChange) { newValue in
            XCTFail("Handler should not be called after removal")
        }
        
        testStruct.removeObserver(.valueDidChange)
        testStruct.value.identifier = "FalseFlag"
    }
    
    func testRemoveAllObservers() {
        let testStruct: Observable<StructTestSubject> = Observable(StructTestSubject(identifier: "JetFuelMeme"))
        
        testStruct.onEvent(.valueWillChange) { newValue in
            XCTFail("Handler should not be called after removal")
        }
        
        testStruct.onEvent(.valueDidChange) { newValue in
            XCTFail("Handler should not be called after removal")
        }
        
        testStruct.removeObservers()
        testStruct.value.identifier = "FalseFlag"
    }
}

class ClassTestSubject {
    var identifier: String
    init(_ identifier: String) {
        self.identifier = identifier
    }
}

struct StructTestSubject {
    var identifier: String
}
