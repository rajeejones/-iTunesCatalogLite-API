//
//  iTunesCatalogLiteManager.swift
//  
//
//  Created by Rajee Jones on 3/31/20.
//

import Foundation

/// API Manager responsible for creating requests
public class iTunesCatalogLiteManager {

    /// Singleton instance of the `APIManager`
    public static var shared = iTunesCatalogLiteManager()

    private init() {
        // no-op
    }

    /// Searches the iTunes Catalog asynchronously for the given search request
    /// - Parameters:
    ///   - searchRequest: `iTunesSearchRequest` used to gather data from iTunes
    ///   - completion: `Result<[iTunesSearchResult], CatalogAPIError` that holds the response or an error
    public func searchCatalog(_ searchRequest: iTunesSearchRequest,
                              completion: @escaping (Result<[iTunesSearchResult], CatalogAPIError>) -> Void) {
        guard let urlRequest = createUrlRequest(searchRequest) else {
            completion(.failure(.malformedUrlRequestError))
            return
        }

        // fetching
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // handle errors
            guard error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data else {
                completion(.failure(.generalError))
                return
            }

            guard let searchResponse = try? JSONDecoder().decode(iTunesSearchResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }

            completion(.success(searchResponse.results))
        }.resume()
    }
}

// MARK: - Private Helpers
extension iTunesCatalogLiteManager {
    func createUrlRequest(_ searchRequest: iTunesSearchRequest) -> URLRequest? {
        let urlString = Endpoints.search.path + "?" + searchRequest.parameterKeyValue
        guard let url = URL(string: urlString) else {
            return nil
        }

        return URLRequest(url: url,
                          cachePolicy: .returnCacheDataElseLoad,
                          timeoutInterval: iTunesCatalogLiteManager.requestTimeout)
    }
}

// MARK: - Private Constants
extension iTunesCatalogLiteManager {
    static let iTunesDomain: String = "https://itunes.apple.com"
    static let requestTimeout = TimeInterval(floatLiteral: 20.0)

    enum Endpoints: String, RawRepresentable {
        case search

        var path: String {
            return  iTunesDomain + "/" + self.rawValue
        }

    }
}
