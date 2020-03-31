import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(iTunesCatalogLite_APITests.allTests),
    ]
}
#endif
