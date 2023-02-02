//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

public class ContentSearchRequest : SearchRequest<ContentSearchRequest> {
    
    let REQUEST_TYPE = "request_type"
    let SEARCH_TYPE = "search_type"
    
    let REQUEST_TYPE_SEARCH = "search"
    let REQUEST_TYPE_SUGGEST = "suggest"
    
    let SEARCH_TYPE_KEYWORD = "keyword"
    
    let SEARCH_TYPE_CATEGORY = "category"
    
    public override init() {
        super.init()
        setRequestType()
        setSearchType()
    }
    
    /**
         * Method to set hardcoded default parameters required for content search API
         * @return  A reference request object
         */
        private func setRequestType() -> ContentSearchRequest {
            return set(key: REQUEST_TYPE, value: REQUEST_TYPE_SEARCH)
        }

        /**
         * Method to set hardcoded default parameters required for content search API
         * @return  A reference request object
         */
        private func setSearchType() -> ContentSearchRequest {
            return set(key: SEARCH_TYPE, value: SEARCH_TYPE_KEYWORD)
        }

        /**
         * Method to set catalog name.
         * Named identifier of the catalog. A catalog is a grouping of items into a broader category
         * such as blogs, videos, etc. A catalog is a representation
         * of a group of items and must have a unique name, that is also unique to a domain
         * (if you have multiple sites).
         *
         * @param value  catalog name
         *
         * @return  A reference request object
         */
        func catalogName(value: String) throws -> ContentSearchRequest {
            if (value.isEmpty) {
                throw BrApiException.EmptyValue(errorMessage: "Catalog Name should not be empty")
            }
            return set(key: "catalog_name", value: value)
        }
}
