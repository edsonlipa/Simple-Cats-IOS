//
//  NetworkProtocol.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpointProtocol) async throws -> T
    func request(_ endpoint: APIEndpointProtocol) async throws -> Data
}
