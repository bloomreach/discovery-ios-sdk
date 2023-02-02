//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation


public class AutosuggestRequest: RequestMap<AutosuggestRequest> {
    
    let REQUEST_TYPE = "request_type"
    let REQUEST_TYPE_SUGGEST = "suggest"
    
    public override init() {
        super.init()
        setRequestType()
    }
    
    /**
         * Method to set hardcoded default parameters required for Auto Suggest API
         * @return  A reference request object
         */
        private func setRequestType() {
            set(key: REQUEST_TYPE, value: REQUEST_TYPE_SUGGEST)
        }
    

        /**
         * Method to set catalog views that you want to see in your suggestions.
         *
         * @param value  catalogs views formatted in required format
         *
         * @return  A reference request object
         */
        func catalogViews(value: String) -> AutosuggestRequest {
            return set(key: "catalog_views", value: value)
        }

        /**
         * Method to set catalog views that you want to see in your suggestions.
         * This method helps to format the catalogs views in required format
         *
         * @param values Map of catalog views attributes and its values
         *
         * @return  A reference request object
         */
    //TODO
//    func catalogViews(values: [String: String])-> AutosuggestRequest {
//            //converts to my_product_catalog:store1|recipe:daily
//            let catalogViewsStr = values.entries
//                .stream()
//                .map { e -> e.key + ":" + e.value }
//                .collect(Collectors.joining("|"))
//            return catalogViews(catalogViewsStr)
//        }

        /**
         * Method to set search term for Search APIs
         *
         * @param q  Partial search query that Autosuggest should operate on.
         *
         * @return  A reference to the current Request object
         */
        func searchTerm(q: String) -> AutosuggestRequest {
            return set(key: "q", value: q)
        }

        /**
         * The user agent of the device that's making the request.
         *
         * @param value user agent value
         *
         * @return  A reference request object
         */
        func userAgent(value: String) -> AutosuggestRequest {
            return set(key: "user_agent", value: value)
        }

        /**
         * Method to set url
         *
         * @param value The title or name of the product.
         *
         * @return  A reference to the current Request object
         */
        func url(value: String) -> AutosuggestRequest {
            return set(key: "url", value: value)
        }

        /**
         * Method to set user id of the customer
         *
         * @param value The universal customer ID of the user.
         *
         * @return  A reference to the current Request object
         */
        func userId(value: String?) -> AutosuggestRequest {
            return set(key: "user_id", value: value)
        }
}
