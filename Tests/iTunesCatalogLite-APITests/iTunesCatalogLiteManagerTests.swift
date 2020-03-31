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
        guard let mockSearchRequest = iTunesSearchRequest(term: "jack johnson"),
            let urlRequest = iTunesCatalogLiteManager.shared.createUrlRequest(mockSearchRequest) else {
                XCTFail("Could not create urlRequest")
                return
        }

        let urlString = iTunesCatalogLiteManager.Endpoints.search.path + "?" + mockSearchRequest.parameterKeyValue
        XCTAssert(urlRequest.url?.absoluteString.contains(urlString) == true)
    }
}
