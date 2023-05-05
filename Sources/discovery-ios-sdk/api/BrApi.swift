//
//  BrApi.swift
//  BrApi Singleton class holds method to initiate BrApiRequest object and API calls methods
//
//

import Foundation

public class BrApi {
    
    static public let shared = BrApi()
    public var brApiRequest: BrApiRequest? = nil
    private let apiProcessor = ApiProcessor()
    
    /**
     Initialise BrApi class with BrApiRequest object
     - parameters:
        - brApiRequest: BrApiRequest object defined for initialisation
     */
    public func intialise(brApiRequest: BrApiRequest) {
        self.brApiRequest = brApiRequest
    }
    
    /**
    Method for calling Product Search API request
     - parameters:
        - productSearchRequest: Request Object required for Product Search API
    */
    public func productSearchApi(productSearchRequest: ProductSearchRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        apiProcessor.processCoreApi(parameters: productSearchRequest.getMap(), success: success, failure: failure)
    }

    /**
     Method for calling Category Search API request
     - parameters:
        - categorySearchRequest: Request Object required for Category Search API
    */
    public func categorySearchApi(categorySearchRequest: CategorySearchRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        apiProcessor.processCoreApi(parameters: categorySearchRequest.getMap(),  success: success, failure: failure)
        }

    /**
     Method for calling Content API request
     - parameters:
        - contentSearchRequest: Request Object required for Content Search API
    */
    public func contentSearchApi(contentSearchRequest: ContentSearchRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        apiProcessor.processCoreApi(parameters: contentSearchRequest.getMap(), success: success, failure: failure)
    }

    /**
     Method for calling BestSeller API request
     - parameters:
        - bestSellerRequest: Request Object required for Content Search API
    */
    public func bestSellerApi(bestSellerRequest: BestSellerRequest, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        apiProcessor.processCoreApi(parameters: bestSellerRequest.getMap(), success: success, failure: failure)
    }

    /**
     Method for calling BestSeller API request
     - parameters:
        - autosuggestRequest: Request Object required for Content Search API
    */
    public func autoSuggestApi(autosuggestRequest: AutosuggestRequest, success: @escaping (_ response: SuggestResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        apiProcessor.processSuggestApi(parameters: autosuggestRequest.getMap(), success: success, failure: failure)
    }
    
    // WIDGET
    /**
     Method for calling Recommendation Widget API where apiType can be specified
     - parameters:
        - widgetId: The ID of the widget, which can be found in the Widget Configurator in the Dashboard.
        - apiType: The type of Recommendation Widget API. This is the widgetType path parameter
        - widgetRequest: Request Object required for Recommendation Widget API
    */
    public func recAndPathwaysWidgetApi(widgetId: String, apiType: WidgetApiType, widgetRequest: WidgetRequest, success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) throws {

        if(widgetId.isEmpty) {
            throw BrApiException.EmptyValue(errorMessage: "Widget Id should not be empty")
        }

        try recAndPathwaysWidgetApi(widgetId: widgetId, apiType: apiType.rawValue, widgetRequest: widgetRequest, success: success, failure: failure)
    }

    /**
     Method for calling Recommendation Widget API where apiType can be specified
     - parameters:
        - widgetId: The ID of the widget, which can be found in the Widget Configurator in the Dashboard.
        - apiType: The type of Recommendation Widget API. This is the widgetType path parameter
        - widgetRequest: Request Object required for  Recommendation Widget API
    */
    public func recAndPathwaysWidgetApi(widgetId: String,
                                apiType: String, widgetRequest: WidgetRequest, success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) throws {
        if(widgetId.isEmpty) {
            throw BrApiException.EmptyValue(errorMessage: "Widget Id should not be empty")
        }
        apiProcessor.processRecsAndPathwaysApi(widgetId: widgetId, widgetType: apiType, parameters: widgetRequest.getMap(), success: success, failure: failure)
        }

    /**
     Method for calling Item-based Recommendation Widget API
     - parameters:
        - widgetId: The ID of the widget, which can be found in the Widget Configurator in the Dashboard.
        - widgetRequest: Request Object required for Item-based Recommendation Widget API
    */
    public func itemBasedRecommendationWidgetApi(widgetId: String, widgetRequest: WidgetRequest,  success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) throws {
            if(widgetId.isEmpty) {
                throw BrApiException.EmptyValue(errorMessage: "Widget Id should not be empty")
            }
            try recAndPathwaysWidgetApi(widgetId: widgetId, apiType: WidgetApiType.ITEM.rawValue, widgetRequest: widgetRequest, success: success, failure: failure)
        }

    /**
     Method for calling Category-based Recommendation Widget API
     - parameters:
        - widgetId: The ID of the widget, which can be found in the Widget Configurator in the Dashboard.
        - widgetRequest: Request Object required for Category-based Recommendation Widget API
    */
    public func categoryBasedWidgetApi(widgetId: String, widgetRequest: WidgetRequest,  success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) throws {
            if(widgetId.isEmpty) {
                throw BrApiException.EmptyValue(errorMessage: "Widget Id should not be empty")
            }
            try recAndPathwaysWidgetApi(widgetId: widgetId, apiType: WidgetApiType.CATEGORY.rawValue, widgetRequest: widgetRequest, success: success, failure: failure)
        }

    /**
     Method for calling Keyword-based Widget API
     - parameters:
        - widgetId: The ID of the widget, which can be found in the Widget Configurator in the Dashboard.
        - widgetRequest: Request Object required for Keyword-based Recommendation Widget API
    */
    public func keywordBasedWidgetApi(widgetId: String, widgetRequest: WidgetRequest, success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) throws {
            if(widgetId.isEmpty) {
                throw BrApiException.EmptyValue(errorMessage: "Widget Id should not be empty")
            }
            try recAndPathwaysWidgetApi(widgetId: widgetId, apiType: WidgetApiType.KEYWORD.rawValue, widgetRequest: widgetRequest, success: success, failure: failure)
        }

    /**
     Method for calling Personalization-based Widget API
     - parameters:
        - widgetId: The ID of the widget, which can be found in the Widget Configurator in the Dashboard.
        - widgetRequest: Request Object required for Personalization-based Recommendation Widget API
    */
    public func personalizationBasedWidgetApi(widgetId: String, widgetRequest: WidgetRequest, success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) throws {
            if(widgetId.isEmpty) {
                throw BrApiException.EmptyValue(errorMessage: "Widget Id should not be empty")
            }
            try recAndPathwaysWidgetApi(widgetId: widgetId, apiType: WidgetApiType.PERSONALIZED.rawValue, widgetRequest: widgetRequest, success: success, failure: failure)
        }
    
    /**
     Method for calling Global Recommendation Widget API
     - parameters:
        - widgetId: The ID of the widget, which can be found in the Widget Configurator in the Dashboard.
        - widgetRequest: Request Object required for Global Recommendation Widget API
    */
    public func globalRecommendationWidgetApi(widgetId: String, widgetRequest: WidgetRequest,  success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) throws {
           if(widgetId.isEmpty) {
               throw BrApiException.EmptyValue(errorMessage: "Widget Id should not be empty")
           }
           try recAndPathwaysWidgetApi(widgetId: widgetId, apiType: WidgetApiType.GLOBAL.rawValue, widgetRequest: widgetRequest, success: success, failure: failure)
       }
}

