//
//  BrApi.swift
//  BrApi Singleton class holds method to initiate BrApiRequest object and API calls methods
//
//  Created by Prashant Bhujbal
//

import Foundation

public class BrApi {
    
    static public let shared = BrApi()
    public var brApiRequest: BrApiRequest? = nil
    private let apiProcessor = ApiProcessor()
    /**
     Initialise Pixel tracker with BrPixel object
     - parameters:
        - brPixel: BrPixel object defined for initialisation
     */
    public func intialise(brApiRequest: BrApiRequest) {
        self.brApiRequest = brApiRequest
    }
    
    /**
         * Method for calling Product Search API request
         * @param productSearchRequest Request Object required for Product Search API
         * @param brApiCompletionListener Callback listener
         */
    public func productSearchApi(productSearchRequest: ProductSearchRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: BrApiError?) -> Void) {
        apiProcessor.processCoreApi(parameters: productSearchRequest.getMap(), success: success, failure: failure)
        }
    
    
    /**
         * Method for calling Category Search API request
         * @param categorySearchRequest Request Object required for Category Search API
         * @param brApiCompletionListener Callback listener
         */
    func categorySearchApi(categorySearchRequest: CategorySearchRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: BrApiError?) -> Void) {
        apiProcessor.processCoreApi(parameters: categorySearchRequest.getMap(),  success: success, failure: failure)
        }

        /**
         * Method for calling Content API request
         * @param contentSearchRequest Request Object required for Content Search API
         * @param brApiCompletionListener Callback listener
         */
    func contentSearchApi(contentSearchRequest: ContentSearchRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: BrApiError?) -> Void) {
        apiProcessor.processCoreApi(parameters: contentSearchRequest.getMap(), success: success, failure: failure)
        }

        /**
         * Method for calling BestSeller API request
         * @param bestSellerRequest Request Object required for Content Search API
         * @param brApiCompletionListener Callback listener
         */
    func bestSellerApi(bestSellerRequest: BestSellerRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: BrApiError?) -> Void) {
        apiProcessor.processCoreApi(parameters: bestSellerRequest.getMap(), success: success, failure: failure)
        }

        /**
         * Method for calling Suggest API request
         * @param autosuggestRequest Request Object required for Content Search API
         * @param brApiCompletionListener Callback listener
         */
    func autoSuggestApi(autosuggestRequest: AutosuggestRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: BrApiError?) -> Void) {
        apiProcessor.processSuggestApi(parameters: autosuggestRequest.getMap(), success: success, failure: failure)
        }
}

