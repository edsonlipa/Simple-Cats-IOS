//
//  TheCatAPI.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import Foundation

enum TheCatAPI {
    case images(limit: Int = 10, page: Int = 0)
    case imageDetail(id: String)
}

extension TheCatAPI: APIEndpointProtocol {
    var baseURL: String { "api.thecatapi.com" }
    private var version: String { "v1" }
    
    var path: String {
        switch self {
        case .images:
            return "/\(version)/images/search"
        case .imageDetail(let id):
            return "/\(version)/images/\(id)"
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = path
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
        return components.url
    }
    
    var headers: [String: String] {
        // Add a global configuration file to keep safe the api key
        ["x-api-key": "live_vWdqwR2UhGsarFsI475IfF0S5fhd3sFNYBalJ9Hq3uQv0yjPbwgqP4vhyQ44ZaXe"]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .images(let limit, let page):
            return [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "has_breeds", value: "1")
            ]
        default:
            return nil
        }
    }
}

// Models


