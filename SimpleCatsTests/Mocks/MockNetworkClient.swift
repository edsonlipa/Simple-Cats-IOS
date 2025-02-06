//
//  MockNetworkClient.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 6/02/25.
//

@testable import SimpleCats
import Foundation

class MockURLSession: NetworkClientProtocol {
    var mockData: Data?
    var mockError: Error?
    var mockResponse: URLResponse?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        
        return (
            mockData ?? Data(),
            mockResponse ?? URLResponse()
        )
    }
}
