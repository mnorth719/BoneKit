//
//  WebClient.swift
//  MattKit
//
//  Created by Matt  North on 9/29/17.
//

import Foundation
import PromiseKit

public class WebClient {
    public enum RESTMethod {
        case GET
        case POST(params: [String: Any])
        case PUT(params: [String: Any])
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
    
    private var parsingQueue = DispatchQueue(label: "com.mattkit.web_parse_queue",
                                             qos: .userInitiated,
                                             attributes: DispatchQueue.Attributes.concurrent)
    
    public func request<T: Codable>(_ url: URL, headers: [String : String]?, method: RESTMethod) -> Promise<T> {
        return Promise { resolve, reject in
            do {
                let urlRequest = try RequestFactory.request(for: url, headers: headers, method: method)
                URLSession.shared.dataTask(with: urlRequest).then(on: parsingQueue) { result -> Void in
                    let mapped = try JSONDecoder().decode(T.self, from: result)
                    resolve(mapped)
                }.catch { error in
                    reject(error)
                }
            } catch  {
                reject(error)
            }
        }
    }
}

fileprivate struct RequestFactory {
    static func request(for url: URL, headers: [String : String]?, method: WebClient.RESTMethod) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        var requestBody: [String : Any]?
        
        switch method {
        case .GET:
            break
        case .POST(let body):
            requestBody = body
        case .PUT(let body):
            requestBody = body
        case .DELETE:
            break
        case .PATCH:
            break
        }
        
        if let requestBody = requestBody {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        }
        
        if let headers = headers {
            for key in headers.keys {
                urlRequest.addValue(headers[key]!, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
    }
}
