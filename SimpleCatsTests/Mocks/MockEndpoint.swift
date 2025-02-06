//
//  MockEndpoint.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 6/02/25.
//

@testable import SimpleCats
import Foundation

struct MockEndpoint: APIEndpointProtocol {
    
    var shouldReturnNilURL: Bool
    
    init(shouldReturnNilURL: Bool = false) {
        self.shouldReturnNilURL = shouldReturnNilURL
    }
    
    var baseURL: String { "api.example.com" }
    var path: String { "/test" }
    var headers: [String : String] { [:] }
    var queryItems: [URLQueryItem]? { nil }

    var url: URL? {
        shouldReturnNilURL ? nil : URL(string: "https://\(baseURL)\(path)")
    }
}
