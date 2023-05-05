//
//  BestSellerRequest.swift
//  
//  BestSeller Request Object class. Create the object of this class in order to send it with BestSeller API
//
//

import Foundation

public class BestSellerRequest: SearchRequest<BestSellerRequest> {
    
    let REQUEST_TYPE = "request_type"
    let SEARCH_TYPE = "search_type"
    
    let REQUEST_TYPE_SEARCH = "search"
    let REQUEST_TYPE_SUGGEST = "suggest"
    
    let SEARCH_TYPE_KEYWORD = "keyword"
    
    let SEARCH_TYPE_CATEGORY = "category"
    let SEARCH_TYPE_BESTSELLER = "bestseller"
    
    // add hardcoded default parameters required for AutosuggestRequest API
    public override init() {
        super.init()
        setRequestType()
        setSearchType()
    }

    /**
     Method to set hardcoded default parameters required for BestSeller API
     */
        private func setRequestType() {
             set(key: REQUEST_TYPE, value: REQUEST_TYPE_SEARCH)
        }

        /**
         * Method to set hardcoded default parameters required for BestSeller API
         * @return  A reference request object
         */
    /**
     Method to set hardcoded default parameters required for BestSeller API
     */
        private func setSearchType() {
            set(key: SEARCH_TYPE, value: SEARCH_TYPE_BESTSELLER)
        }
}
