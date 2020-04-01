# iTunesCatalogLite-API

This package provides the `iTunesCatalogLiteManager` as a way to search iTunes and gather `iTunesSearchResult`'s

### Making a request:

Use the `.shared()` iTunesCatalogLiteManager to search the catalog while providing your request object

…
    
    let searchRequest = iTunesSearchRequest(term: "Jack Johnson")
    iTunesCatalogLiteManager.shared().searchCatalog(searchRequest,
    completion: { (result) in 
        switch result:
            case .success(let results):
            // handle results
            case .failure(let error):
            // handle errors
        })
…

### Optional 

Use the `decodeSearchResponse` to decode the API  to a strongly typed response

