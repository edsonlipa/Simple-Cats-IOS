//
//  APIEndpoint.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import Foundation

protocol APIEndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var url: URL? { get }
    var queryItems: [URLQueryItem]? { get }
}
