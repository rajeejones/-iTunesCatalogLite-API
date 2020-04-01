//
//  iTunesCatalogLiteManagerTests.swift
//  
//
//  Created by Rajee Jones on 3/31/20.
//
import XCTest
@testable import iTunesCatalogLite_API

final class iTunesCatalogLiteManagerTests: XCTestCase {

    func testCreateUrlRequest() {
        guard let mockSearchRequest = iTunesSearchRequest(term: "jamie"),
            let urlRequest = iTunesCatalogLiteManager.shared.createUrlRequest(mockSearchRequest) else {
                XCTFail("Could not create urlRequest")
                return
        }

        let urlString = iTunesCatalogLiteManager.Endpoints.search.path + "?" + mockSearchRequest.parameterKeyValue
        XCTAssert(urlRequest.url?.absoluteString.contains(urlString) == true)
    }

    func testLiveResponse() {
        guard let mockSearchRequest = iTunesSearchRequest(term: "data", media: .movie, limit: 10),
            let urlRequest = iTunesCatalogLiteManager.shared.createUrlRequest(mockSearchRequest) else {
                XCTFail("Could not create urlRequest")
                return
        }

        let urlString = iTunesCatalogLiteManager.Endpoints.search.path + "?" + mockSearchRequest.parameterKeyValue
        XCTAssert(urlRequest.url?.absoluteString.contains(urlString) == true)

        let expectation = XCTestExpectation(description: "request")
        iTunesCatalogLiteManager.shared.searchCatalog(mockSearchRequest) { (result) in

            switch result {
            case .success(let searchResults):
                iTunesCatalogLiteManager.shared.decodeSearchResponse(from: searchResults) { formattedResult in
                    switch formattedResult {
                    case .success(let response):
                        let count = response[.featureMovie]?.count ?? 0
                        XCTAssert(count <= 10)
                        break
                    case .failure:
                        XCTFail("Could not get a response from server")
                    }
                    expectation.fulfill()
                }
            case .failure:
                XCTFail("Could not get a response from server")
            }

        }

        wait(for: [expectation], timeout: 20.0)
    }
}
