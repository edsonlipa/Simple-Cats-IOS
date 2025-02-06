//
//  NetworkClientProtocol.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 6/02/25.
//

import Foundation

// NetworkClientProtocol helps us to easily change the network client
// (e.g., URLSession, Alamofire, or any other preferred library)
protocol NetworkClientProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkClientProtocol { }
