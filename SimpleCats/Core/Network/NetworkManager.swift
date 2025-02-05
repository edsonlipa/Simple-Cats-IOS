//
//  NetworkManager.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import Foundation

class NetworkManager: NetworkProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: APIEndpointProtocol) async throws -> T {
        let data = try await request(endpoint)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func request(_ endpoint: APIEndpointProtocol) async throws -> Data {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.headers
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed
        }
        
        return data
    }
}

// Network Errors
enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidData
    case decodingError
}
