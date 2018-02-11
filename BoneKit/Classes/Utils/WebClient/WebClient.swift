//
//  WebClient.swift
//  MattKit
//
//  Created by Matt  North on 9/29/17.
//

import Foundation
import PromiseKit

public protocol JSONParserProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

public protocol JSONEncoderProtocol {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest) -> URLDataPromise
}

extension URLSession: URLSessionProtocol {}
extension JSONDecoder: JSONParserProtocol {}
extension JSONEncoder: JSONEncoderProtocol {}

public class WebClient {
    
    public init(urlSession: URLSessionProtocol = URLSession.shared,
                parser: JSONParserProtocol = JSONDecoder(),
                jsonEncoder: JSONEncoderProtocol = JSONEncoder()) {
        self.parser = parser
        self.urlSession = urlSession
        self.encoder = jsonEncoder
    }
    
    public enum HTTPMethod {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
        
        var rawValue: String {
            switch self {
            case .GET:
                return "GET"
            case .POST:
                return "POST"
            case .PUT:
                return "PUT"
            case .DELETE:
                return "DELETE"
            case .PATCH:
                return "PATCH"
            }
        }
    }
    
    private var urlSession: URLSessionProtocol
    private var parser: JSONParserProtocol
    private var encoder: JSONEncoderProtocol
    private let requestFactory = RequestFactory()
    private var parsingQueue = DispatchQueue(label: "com.mattkit.web_parse_queue",
                                             qos: .userInitiated,
                                             attributes: DispatchQueue.Attributes.concurrent)
    
    public func request<T: Decodable, U: Encodable>(_ url: URL, headers: [String : String]?, requestBody: U?, method: HTTPMethod) -> Promise<T> {
        do {
            let urlRequest = try requestFactory.request(for: url, headers: headers, method: method, requestBody: requestBody)
            return decodableRequestPromise(for: urlRequest)
        } catch {
            return Promise(error: error)
        }
    }
    
    public func request<T: Decodable>(_ url: URL, headers: [String : String]?, method: HTTPMethod) -> Promise<T> {
        do {
            let urlRequest = try requestFactory.request(for: url, headers: headers, method: method)
            return decodableRequestPromise(for: urlRequest)
        } catch {
            return Promise(error: error)
        }
    }
    
    private func decodableRequestPromise<T: Decodable>(for urlRequest: URLRequest) -> Promise<T> {
        return Promise { resolve, reject in
            urlSession.dataTask(with: urlRequest).then(on: parsingQueue) {[weak self] result -> Void in
                guard let `self` = self else { return }
                let mapped = try self.parser.decode(T.self, from: result)
                resolve(mapped)
            }.catch { error in
                reject(error)
            }
        }
    }
}
fileprivate struct RequestFactory {
    private var encoder: JSONEncoderProtocol
    
    init(encoder: JSONEncoderProtocol = JSONEncoder()) {
        self.encoder = encoder
    }
    
    func request<T: Encodable>(for url: URL, headers: [String: String]?, method: WebClient.HTTPMethod, requestBody: T) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = try? encoder.encode(requestBody)
        
        if let headers = headers {
            for key in headers.keys {
                urlRequest.addValue(headers[key]!, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
    }
    
    func request(for url: URL, headers: [String: String]?, method: WebClient.HTTPMethod) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let headers = headers {
            for key in headers.keys {
                urlRequest.addValue(headers[key]!, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
    }
}
