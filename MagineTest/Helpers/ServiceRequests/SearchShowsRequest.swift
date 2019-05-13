//
//  SearchShowsRequest.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import Foundation

// MARK:- Search Shows Request -
public enum SearchShowsRequest {
    case searchList(searchText: String)
    case fetchImage(imageUrl: String)
}

// MARK:- Extension - Service Request - k
extension SearchShowsRequest: ServiceRequest {
    
    /// Absolute Path:
    public var absolutePath: String {
        switch self {
        case .searchList(let searchText):
            let formattedText = searchText.urlPathEncoded()
            return URLConstants.kServerBaseURL.appendingFormat(URLConstants.kSearchShowsServicePath, formattedText)
        case .fetchImage(let imageUrl):
            return imageUrl
        }
    }
    
    /// HTTP Method
    public var httpMethod: HTTPMethod {
        switch self {
        case .searchList, .fetchImage:
            return .get
        }
    }
    
    /// HTTP Headers: Uses default request header.
    public var headers: HTTPHeaders? {
        switch self {
        case .searchList:
            let headers = ["Content-Type": "application/json; charset=utf-8"]
            return headers
        case .fetchImage:
            let headers = ["Content-Type": "image/jpeg"]
            return headers
        }
    }
    
    /// Query Parameters:
    public var queryParams: [URLQueryItem]? {
        switch self {
        case .searchList, .fetchImage:
            return nil
        }
    }
}
