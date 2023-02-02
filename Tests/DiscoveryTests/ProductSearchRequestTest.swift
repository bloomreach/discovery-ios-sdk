//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation
import XCTest
@testable import Discovery

class ProductSearchRequestTest: XCTestCase  {
    
    func prepareProductSearchRequest() throws {
        let apiProcessor = ApiProcessor()
        let pr = ProductSearchRequest()
//        let query =
//                    FormatterUtils.mapToUriBuilderForApi(productSearchRequest.getMap()).build().toString()
//
        let url = URL(string: apiProcessor.getBaseUrlForCore())
        var components = URLComponents(string: url!.absoluteString)!
        components.queryItems = apiProcessor.getQueryItemArray(params: pr.getMap())
        
        print(components.url)
        XCTAssertEqual(Discovery().text, "Hello, World!")
    }
}
