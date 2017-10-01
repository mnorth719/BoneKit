import UIKit
import XCTest
import BoneKit
import PromiseKit

class WebClientTests: XCTestCase {
    fileprivate var subject: WebClient!
    fileprivate var mockParser: JSONParserMock!
    fileprivate var urlSessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        self.mockParser = JSONParserMock()
        self.urlSessionMock = URLSessionMock()
        self.subject = WebClient(urlSession: urlSessionMock, parser: mockParser)
    }
    
    func testRequestWithNoParams() {
        let mockObject = MockCodableObject(title: "hi", message: "its me again")
        mockParser.valueToReturn = mockObject
        urlSessionMock.dataPromiseToReturn = URLDataPromise(value: mockObject.asData())
        let url = URL(string: "http://boneKit.com")
        let headers: [String : String] = [
            "headerKey": "headerValue"
        ]
        
        let promiseExpectation = expectation(description: "promise should resolve with mock object")
        subject.request(url!, headers: headers, method: WebClient.RESTMethod.GET).then { (response: MockCodableObject) -> Void in
            XCTAssertEqual(mockObject.title, response.title)
            XCTAssertEqual(mockObject.message, response.message)
            promiseExpectation.fulfill()
        }.always {
        
        }
        
        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail("request promise was never resolved :(")
            }
        }
    }
    
    func testPUTWithParams() {
        let mockObject = MockCodableObject(title: "Question", message: "can jet fuel melt steel beams?")
        mockParser.valueToReturn = mockObject
        urlSessionMock.dataPromiseToReturn = URLDataPromise(value: mockObject.asData())
        let url = URL(string: "http://boneKit.com")
        let headers: [String : String] = [
            "headerKey": "headerValue"
        ]
        let body: [String : Any] = [
            "bodyParam": 1
        ]
        
        let restMethod = WebClient.RESTMethod.PUT(params: body)
        let promiseExpectation = expectation(description: "promise should resolve with mock object")
        subject.request(url!, headers: headers, method: restMethod).then { (response: MockCodableObject) -> Void in
            XCTAssertEqual(mockObject.title, response.title)
            XCTAssertEqual(mockObject.message, response.message)
            promiseExpectation.fulfill()
        }.always {
             // ignore
        }
        
        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail("request promise was never resolved :(")
            }
        }
    }
    
    func testPATCHWithParams() {
        let mockObject = MockCodableObject(title: "Question", message: "can jet fuel melt steel beams?")
        mockParser.valueToReturn = mockObject
        urlSessionMock.dataPromiseToReturn = URLDataPromise(value: mockObject.asData())
        let url = URL(string: "http://boneKit.com")
        let headers: [String : String] = [
            "headerKey": "headerValue"
        ]
        let body: [String : Any] = [
            "bodyParam": 1
        ]
        
        let restMethod = WebClient.RESTMethod.PATCH(params: body)
        let promiseExpectation = expectation(description: "promise should resolve with mock object")
        subject.request(url!, headers: headers, method: restMethod).then { (response: MockCodableObject) -> Void in
            XCTAssertEqual(mockObject.title, response.title)
            XCTAssertEqual(mockObject.message, response.message)
            promiseExpectation.fulfill()
            }.always {
                // ignore
        }
        
        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail("request promise was never resolved :(")
            }
        }
    }
    
    func testPOSTWithParams() {
        let mockObject = MockCodableObject(title: "Question", message: "can jet fuel melt steel beams?")
        mockParser.valueToReturn = mockObject
        urlSessionMock.dataPromiseToReturn = URLDataPromise(value: mockObject.asData())
        let url = URL(string: "http://boneKit.com")
        let headers: [String : String] = [
            "headerKey": "headerValue"
        ]
        let body: [String : Any] = [
            "bodyParam": 1
        ]
        
        let restMethod = WebClient.RESTMethod.POST(params: body)
        let promiseExpectation = expectation(description: "promise should resolve with mock object")
        subject.request(url!, headers: headers, method: restMethod).then { (response: MockCodableObject) -> Void in
            XCTAssertEqual(mockObject.title, response.title)
            XCTAssertEqual(mockObject.message, response.message)
            promiseExpectation.fulfill()
            }.always {
                // ignore
        }
        
        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail("request promise was never resolved :(")
            }
        }
    }
    
    func testDELETEWithParams() {
        let mockObject = MockCodableObject(title: "Question", message: "can jet fuel melt steel beams?")
        mockParser.valueToReturn = mockObject
        urlSessionMock.dataPromiseToReturn = URLDataPromise(value: mockObject.asData())
        let url = URL(string: "http://boneKit.com")
        let headers: [String : String] = [
            "headerKey": "headerValue"
        ]
        let body: [String : Any] = [
            "bodyParam": 1
        ]
        
        let restMethod = WebClient.RESTMethod.DELETE(params: body)
        let promiseExpectation = expectation(description: "promise should resolve with mock object")
        subject.request(url!, headers: headers, method: restMethod).then { (response: MockCodableObject) -> Void in
            XCTAssertEqual(mockObject.title, response.title)
            XCTAssertEqual(mockObject.message, response.message)
            promiseExpectation.fulfill()
        }.always {
                // ignore
        }
        
        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail("request promise was never resolved :(")
            }
        }
    }
    
    func testErrorThrownInPromise() {
        let mockObject = MockCodableObject(title: "Question", message: "can jet fuel melt steel beams?")
        mockParser.valueToReturn = mockObject
        let promiseError = NSError(domain: "com.boneKit", code: 1, userInfo: nil)
        urlSessionMock.dataPromiseToReturn = URLDataPromise(error: promiseError)
        
        let url = URL(string: "http://boneKit.com")
        let headers: [String : String] = [
            "headerKey": "headerValue"
        ]
        let body: [String : Any] = [
            "bodyParam": 1
        ]
        
        let restMethod = WebClient.RESTMethod.POST(params: body)
        let promiseExpectation = expectation(description: "promise should reject with error")
        subject.request(url!, headers: headers, method: restMethod).then { (response: MockCodableObject) -> Void in
            // ignore
        }.catch { error in
            let error = error as NSError
            XCTAssertEqual(error.domain, promiseError.domain)
            promiseExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail("request promise was never resolved :(")
            }
        }
    }
    
    func testErrorThrownInDecoding() {
        let mockObject = MockCodableObject(title: "Question", message: "can jet fuel melt steel beams?")
        mockParser.valueToReturn = mockObject
        let promiseError = NSError(domain: "com.boneKit", code: 1, userInfo: nil)
        urlSessionMock.dataPromiseToReturn = URLDataPromise(value: mockObject.asData())
        let parseError = NSError(domain: "com.boneKit", code: 1, userInfo: nil)
        mockParser.error = parseError

        let url = URL(string: "http://boneKit.com")
        let headers: [String : String] = [
            "headerKey": "headerValue"
        ]
        let body: [String : Any] = [
            "bodyParam": 1
        ]
        
        let restMethod = WebClient.RESTMethod.POST(params: body)
        let promiseExpectation = expectation(description: "promise should reject with error")
        subject.request(url!, headers: headers, method: restMethod).then { (response: MockCodableObject) -> Void in
            // ignore
        }.catch { error in
                let error = error as NSError
                XCTAssertEqual(error.domain, promiseError.domain)
                promiseExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1) { error in
            if error != nil {
                XCTFail("request promise was never resolved :(")
            }
        }
    }
}

fileprivate class JSONParserMock: WebClientJSONParser {
    var didCallDecode = false
    var valueToReturn: Decodable!
    var error: NSError?
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let error = error {
            throw error
        } else {
            return valueToReturn as! T
        }
    }
}

fileprivate class URLSessionMock: URLSessionProtocol {
    var didCallDataTask = false
    var dataTaskParam: URLRequest?
    var dataPromiseToReturn: URLDataPromise!
    func dataTask(with request: URLRequest) -> URLDataPromise {
        self.dataTaskParam = request
        return dataPromiseToReturn
    }
}

fileprivate struct MockCodableObject: Codable {
    var title: String
    var message: String
    
    func asData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}

fileprivate struct BadJSONObject {
    var title: String
}






