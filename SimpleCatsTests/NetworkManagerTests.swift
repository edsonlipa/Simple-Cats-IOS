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
        let testData = loadTestData(named: "cat_response")
        mockSession.mockData = testData
        mockSession.mockResponse = HTTPURLResponse(
            url: mockEndpoint.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let data = try await sut.request(mockEndpoint)
        
        // Then
        #expect(data == testData)
    }
    
    @Test("Successfully decodes CatBreed from valid JSON")
    func testDecodingSuccess() async throws {
        // Given
        let mockEndpoint = MockEndpoint()
        let testData = loadTestData(named: "cat_response")
        mockSession.mockData = testData
        
        mockSession.mockResponse = HTTPURLResponse(
            url: mockEndpoint.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let catImages: [CatImage] = try await sut.request(mockEndpoint)
        let catImage = catImages.first!
        
        // Then
        #expect(catImage.id == "0XYvRd7oD")
        #expect(catImage.width == 1204)
        #expect(catImage.height == 1445)
        #expect(catImage.breeds.first?.id == "abys")
        #expect(catImage.breeds.first?.name == "Abyssinian")
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
    
    @Test("Should handle malformed JSON")
    func shouldHandleMalformedJSON() async {
        // Given
        let mockEndpoint = MockEndpoint()
        let invalidJSON = "{ invalid json }".data(using: .utf8)!
        mockSession.mockData = invalidJSON
        mockSession.mockResponse = HTTPURLResponse(
            url: mockEndpoint.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When/Then
        do {
            let _: CatImage = try await sut.request(mockEndpoint)
            #expect(Bool(false), "Expected decoding error")
        } catch {
            #expect(error as? NetworkError == NetworkError.decodingError)
        }
    }
    
    @Test("Should handle different HTTP status codes")
    func shouldHandleDifferentStatusCodes() async throws {
        // Test 401 Unauthorized
        await testStatusCode(401)
        // Test 403 Forbidden
        await testStatusCode(403)
        // Test 500 Server Error
        await testStatusCode(500)
    }

    private func testStatusCode(_ code: Int) async {
        let mockEndpoint = MockEndpoint()
        mockSession.mockResponse = HTTPURLResponse(
            url: mockEndpoint.url!,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )
        
        do {
            let _: Data = try await sut.request(mockEndpoint)
            #expect(Bool(false), "Expected error for status code \(code)")
        } catch {
            #expect(error as? NetworkError == NetworkError.requestFailed)
        }
    }
    
    @Test("Should throw invalidResponse when response is not HTTPURLResponse")
    func shouldThrowInvalidResponseForNonHTTPResponse() async {
        // Given
        let mockEndpoint = MockEndpoint()
        mockSession.mockData = Data()
        mockSession.mockResponse = URLResponse(
            url: mockEndpoint.url!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        
        // When/Then
        do {
            let _: Data = try await sut.request(mockEndpoint)
            #expect(Bool(false), "Expected invalidResponse error")
        } catch {
            #expect(error as? NetworkError == NetworkError.invalidResponse)
        }
    }
}

extension NetworkManagerTests {
    func loadTestData(named name: String, extension ext: String = "json") -> Data {
        guard let path = Bundle(for: MockURLSession.self).path(forResource: name, ofType: ext),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Couldn't find \(name).\(ext) in test bundle")
        }
        return data
    }
}
