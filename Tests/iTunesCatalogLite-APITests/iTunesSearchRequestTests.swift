//
//  iTunesSearchRequestTests.swift
//  
//
//  Created by Rajee Jones on 3/31/20.
//
import XCTest
@testable import iTunesCatalogLite_API

final class iTunesSearchRequestTests: XCTestCase {

    func testURLTerms() {
        guard let mockSearch = iTunesSearchRequest(term: "jack johnson") else {
            assertionFailure("Could not create mock request")
            return
        }

        XCTAssertTrue(mockSearch.term == "jack+johnson")
    }

    func testInvalidURLTerms() {
        if let _ = iTunesSearchRequest(term: "") {
            XCTFail("Should not be able to create mock request")
        }
    }

    func testMediaScope() {
        let media = iTunesSearchRequest.SearchMedia.musicVideo
        XCTAssertTrue(media.title == "Music Video")

        let scopeMedia = iTunesSearchRequest.SearchMedia(title: media.title)
        XCTAssertTrue(scopeMedia == .musicVideo)
    }

    static var allTests = [
        ("testURLTerms", testURLTerms),
        ("testInvalidURLTerms", testInvalidURLTerms),
        ("testMediaScope", testMediaScope)
    ]

}

