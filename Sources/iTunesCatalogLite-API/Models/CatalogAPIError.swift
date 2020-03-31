//
//  CatalogAPIError.swift
//  iTunesCatalog
//
//  Created by Rajee Jones on 3/31/20.
//  Copyright © 2020 OldMoonStudios. All rights reserved.
//

import Foundation

public enum CatalogAPIError: Error {
    case malformedUrlRequestError
    case decodingError
    case generalError
}
