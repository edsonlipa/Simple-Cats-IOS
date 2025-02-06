//
//  NetworkManagerTests.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 6/02/25.
//

import Testing
import Foundation
@testable import SimpleCats

@Suite("NetworkManager Tests")
struct NetworkManagerTests {
    // System under test
    var sut: NetworkManager
    var mockSession: MockURLSession
    
    init() {
        self.mockSession = MockURLSession()
        self.sut = NetworkManager(session: mockSession)
    }
    
    // MARK: - Tests
    
    @Test("Network request succeeds with valid data")
    func testRequestSucceeds() async throws {
        // Given
        let mockEndpoint = MockEndpoint()
        let expectedData = """
        {
            "id": "abys",
            "name": "Abyssinian"
        }
        """.data(using: .utf8)!
        
        mockSession.mockData = expectedData
        mockSession.mockResponse = HTTPURLResponse(
            url: mockEndpoint.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let data = try await sut.request(mockEndpoint)
        
        // Then
        #expect(data == expectedData)
    }
    
    @Test("Successfully decodes CatBreed from valid JSON")
    func testDecodingSuccess() async throws {
        // Given
        let mockEndpoint = MockEndpoint()
        let jsonData = """
        {
            "id": "abys",
            "name": "Abyssinian",
            "description": "Test cat",
            "temperament": "Friendly",
            "origin": "Egypt",
            "life_span": "14-15",
            "wikipedia_url": "http://example.com"
        }
        """.data(using: .utf8)!
        
        mockSession.mockData = jsonData
        mockSession.mockResponse = HTTPURLResponse(
            url: mockEndpoint.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let breed: CatBreed = try await sut.request(mockEndpoint)
        
        // Then
        #expect(breed.id == "abys")
        #expect(breed.name == "Abyssinian")
    }
    
    @Test("Throws invalidURL error when URL is nil")
    func testInvalidURLError() async {
        // Given
        let mockEndpoint = MockEndpoint(shouldReturnNilURL: true)
        
        // When/Then
        do {
            let _: Data = try await sut.request(mockEndpoint)
            #expect(Bool(false), "Expected invalidURL error to be thrown")
        } catch {
            #expect(error as? NetworkError == NetworkError.invalidURL)
        }
    }
    
    @Test("Throws requestFailed error for non-200 status code")
    func testRequestFailedError() async {
        // Given
        let mockEndpoint = MockEndpoint()
        mockSession.mockResponse = HTTPURLResponse(
            url: mockEndpoint.url!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When/Then
        do {
            let _: Data = try await sut.request(mockEndpoint)
            #expect(Bool(false), "Expected requestFailed error")

        } catch {
            #expect(error as? NetworkError == NetworkError.requestFailed)
        }
    }
}
