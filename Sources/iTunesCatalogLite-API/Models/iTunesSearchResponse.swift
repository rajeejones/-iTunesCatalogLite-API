//
//  iTunesSearchResponse.swift
//  iTunesCatalog
//
//  Created by Rajee Jones on 3/31/20.
//  Copyright © 2020 OldMoonStudios. All rights reserved.
//

import Foundation

struct iTunesSearchResponse: Codable {
    var results: [iTunesSearchResult]

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

/// Wrapper for iTunes Search results [Documentation](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/#understand)
public struct iTunesSearchResult: Codable {
    public private(set) var id: Int
    public private(set) var name: String
    public private(set) var artwork: String
    public private(set) var genre: String
    public private(set) var url: String
    internal private(set) var kind: String
    public private(set) var previewUrl: String
    public private(set) var collectionName: String

    /// `iTunesResultType` wrapper of the kind of content
    public var type: iTunesResultType {
        return iTunesResultType(rawValue: kind) ?? .unknown
    }

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case name = "trackName"
        case artwork = "artworkUrl100"
        case genre = "primaryGenreName"
        case url = "trackViewUrl"
        case kind
        case previewUrl
        case collectionName
    }
}

/// Wrapper for the kind of content returned by the search request.
public enum iTunesResultType: String, RawRepresentable {
    case album
    case book
    case coachedAudio = "coached-audio"
    case featureMovie = "feature-movie"
    case interactiveBooklet = "interactive-booklet"
    case musicVideo = "music-video"
    case pdfPodcast = "pdf podcast"
    case podcastEpisode = "podcast-episode"
    case softwarePackage = "software-package"
    case song
    case tvEpisode = "tv-episode"
    case artist
    case unknown

    public var displayTitle: String {
        let pattern = "([a-z0-9])([A-Z])"

        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.rawValue.count)
        return regex?.stringByReplacingMatches(in: self.rawValue.replacingOccurrences(of: "-", with: " "), options: [], range: range, withTemplate: "$1 $2").capitalized ?? ""
    }
}
