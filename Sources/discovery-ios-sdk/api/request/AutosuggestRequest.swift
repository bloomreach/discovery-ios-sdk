//
// AutosuggestRequest.swift
// Create the object of this class in order to send it with AutoSuggest API
//
//  Created by Prashant Bhujbal
//

import Foundation


public class AutosuggestRequest: RequestMap<AutosuggestRequest> {
    
    let REQUEST_TYPE = "request_type"
    let REQUEST_TYPE_SUGGEST = "suggest"
    
    // add hardcoded default parameters required for AutosuggestRequest API
    public override init() {
        super.init()
        setRequestType()
    }
    
    /**
     Method to set hardcoded default parameters required for Auto Suggest API
     */
        private func setRequestType() {
            set(key: REQUEST_TYPE, value: REQUEST_TYPE_SUGGEST)
        }

    /**
     Method to set catalog views that you want to see in your suggestions.
     - parameters:
        - value: catalogs views formatted in required format
     - returns A reference to the current Request object
     */
    public  func catalogViews(value: String) -> AutosuggestRequest {
            return set(key: "catalog_views", value: value)
        }

    /**
     Method to set catalog views that you want to see in your suggestions.
     This method helps to format the catalogs views in required format
     - parameters:
        - values: Dictonary of catalog views attributes and its values
     - returns A reference to the current Request object
     */
    public func catalogViews(values: [String: String])-> AutosuggestRequest {
        let catalogViewsStr = values.map { $0.0 + ":" + $0.1 }.joined(separator: "|")
        return catalogViews(value: catalogViewsStr)
    }

    /**
     Method to set search term for Search APIs
     - parameters:
        - q: Partial search query that Autosuggest should operate on.
     - returns A reference to the current Request object
     */
    public  func searchTerm(q: String) -> AutosuggestRequest {
            return set(key: "q", value: q)
        }
    
    /**
     Method to set search term for Search APIs
     - parameters:
        - value: user agent value
     - returns A reference to the current Request object
     */
    public func userAgent(value: String) -> AutosuggestRequest {
            return set(key: "user_agent", value: value)
        }

    /**
     Method to set url
     - parameters:
        - value: The title or name of the product.
     - returns A reference to the current Request object
     */
    public func url(value: String) -> AutosuggestRequest {
            return set(key: "url", value: value)
        }

    /**
     Method to set user id of the customer
     - parameters:
        - value: The universal customer ID of the user.
     - returns A reference to the current Request object
     */
    public func userId(value: String?) -> AutosuggestRequest {
            return set(key: "user_id", value: value)
        }
}
