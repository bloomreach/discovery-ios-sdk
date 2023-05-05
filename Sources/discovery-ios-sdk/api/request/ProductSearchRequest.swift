//
//  ProductSearchRequest.swift
//  
//
//  Product Search Request Object class. Create the object of this class in order to send it with Product Search API
//

import Foundation

public class ProductSearchRequest: SearchRequest<ProductSearchRequest> {
    
    let REQUEST_TYPE = "request_type"
    let SEARCH_TYPE = "search_type"
    
    let REQUEST_TYPE_SEARCH = "search"
    let REQUEST_TYPE_SUGGEST = "suggest"
    
    let SEARCH_TYPE_KEYWORD = "keyword"
    
    public override init() {
        super.init()
        setRequestType()
        setSearchType()
    }
    
    /**
    Method to set hardcoded default parameters required for product search API
    */
       private func setRequestType()  {
           set(key: REQUEST_TYPE, value: REQUEST_TYPE_SEARCH)
       }

       /**
        Method to set hardcoded default parameters required for product search API
        */
       private func setSearchType()  {
           set(key: SEARCH_TYPE, value: SEARCH_TYPE_KEYWORD)
       }
}
