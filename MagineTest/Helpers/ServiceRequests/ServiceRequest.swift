//
//  ServiceRequest.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import Foundation

// MARK:- Service Request Type -
public protocol ServiceRequest {
    var absolutePath: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var queryParams: [URLQueryItem]? { get }
    var bodyParams: JSONDictionary? { get }
}
/// Supported Headers:
public typealias HTTPHeaders = [String: String]

/// Default JSON Body.
public typealias JSONDictionary = [String: Any]

/// Default Content type header.
extension ServiceRequest {
    /// HTTP Headers
    public var headers: HTTPHeaders? {
        let headers = ["Content-Type": "application/json; charset=utf-8"]
        return headers
    }
    
    /// Body.
    public var bodyParams: JSONDictionary? {
        return nil
    }
}
