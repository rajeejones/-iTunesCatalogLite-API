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

        let expectation = XCTestExpectation(description: "request")
        iTunesCatalogLiteManager.shared.searchCatalog(mockSearchRequest) { (result) in

            switch result {
            case .success(let searchResults):
                print(searchResults)
            case .failure(let error):
                break
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20.0)
    }
}
