//
//  ApiProcessor.swift
//  
//  Class for adding global parameters to the request, processing all types of API call and providing callback once API returns
//

import Foundation

class ApiProcessor {
    
    private let CORE_API_PATH = "/api/v1/core/"
    private let SUGGEST_API_PATH = "/api/v2/suggest"
    private let WIDGET_API_PATH = "/api/v2/widgets/"
    private let restClientApi = RestClientApi()
    
    /**
     Method to format Core API parameters, execute the API and invoke the callback with appropriate result
     - parameters:
     - params: Dictonary of request parameters to be sent with the request
     */
    func processCoreApi(parameters:  [String: Any?],  success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var queryMap = parameters
        let url = URL(string: getBaseUrlForCore())
    
        if let urlString = url, var components = URLComponents(string: urlString.absoluteString) {
            let params = prepareGlobalQuery(queryMap: &queryMap)
            components.percentEncodedQuery = getQueryItemString(params: params)
            restClientApi.doApiCall(components: components, success: success, failure: failure)
        } else {
            failure(NSError(domain: "", code: 0))
        }
    }
    
    /**
     Method to format Suggest API parameters, execute the API and invoke the callback with appropriate result
     - parameters:
     - params: Dictonary of request parameters to be sent with the request
     */
    func processSuggestApi(parameters:  [String: Any?],  success: @escaping (_ response: SuggestResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var queryMap = parameters
        let url = URL(string: getBaseUrlForSuggest())
        if let urlString = url, var components = URLComponents(string: urlString.absoluteString) {
            let params = prepareGlobalQuery(queryMap: &queryMap)
            components.percentEncodedQuery = getQueryItemString(params: params)
            restClientApi.doApiCall(components: components, success: success, failure: failure)
        } else {
            failure(NSError(domain: "", code: 0))
        }
    }
    
    /**
     Method to format Suggest API parameters, execute the API and invoke the callback with appropriate result
     - parameters:
     - widgetId: The ID of the widget, which can be found in the Widget Configurator in the Dashboard.
     - widgetType: Type of widget
     - params: Dictonary of request parameters to be sent with the request
     */
    func processRecsAndPathwaysApi(widgetId: String, widgetType: String, parameters:  [String: Any?],  success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var queryMap = parameters
        let url = URL(string: getBaseUrlForRp(widgetType: widgetType, widgetId: widgetId))
        if let urlString = url, var components = URLComponents(string: urlString.absoluteString) {
            let params = prepareGlobalQuery(queryMap: &queryMap)
            components.percentEncodedQuery = getQueryItemString(params: params)
            restClientApi.doApiCall(components: components, success: success, failure: failure)
        } else {
            failure(NSError(domain: "", code: 0))
        }
    }
    
    private func getBaseUrlForCore() -> String {
        var url = ""
        if BrApi.shared.brApiRequest?.environment == Env.STAGE {
            url = "https://staging-core.dxpapi.com"
        } else if BrApi.shared.brApiRequest?.environment == Env.PROD {
            url = "https://core.dxpapi.com"
        }
        url.append(CORE_API_PATH)
        return url
    }
    
    private func getBaseUrlForSuggest() -> String {
        var url = ""
        if BrApi.shared.brApiRequest?.environment == Env.STAGE {
            url = "https://staging-suggest.dxpapi.com"
        } else if BrApi.shared.brApiRequest?.environment == Env.PROD {
            url = "https://suggest.dxpapi.com"
        }
        url.append(SUGGEST_API_PATH)
        return url
    }
    
    private func getBaseUrlForRp(widgetType: String, widgetId: String) -> String {
        var url = ""
        if BrApi.shared.brApiRequest?.environment == Env.STAGE {
            url = "https://pathways-staging.dxpapi.com"
        } else if BrApi.shared.brApiRequest?.environment == Env.PROD {
            url = "https://pathways.dxpapi.com"
        }
        url.append("\(WIDGET_API_PATH)\(widgetType)/\(widgetId)")
        return url
    }
    
    private func getQueryItemArray(params:  [String: Any?]) -> [URLQueryItem] {
        var qeryItemArr: [URLQueryItem] = []
        _ = params.map { (key, value) in
            if value is [String] {
                for listValue in (value as! [String]) {
                    qeryItemArr.append(URLQueryItem(name: key, value: listValue))
                }
            } else {
                qeryItemArr.append(URLQueryItem(name: key, value: value as? String))
            }
        }
        return qeryItemArr
    }
    
    private func getQueryItemString(params:  [String: Any?]) -> String {
            //adding support to encode + sign
            var cs = CharacterSet.urlQueryAllowed
            cs.remove("+")
            
            var queryItemString = ""
            _ = params.map { (key, value) in
                
                if value is [String] {
                    for listValue in (value as! [String]) {
                        if let listValue = listValue.addingPercentEncoding(withAllowedCharacters: cs) {
                            if(!queryItemString.isEmpty) {
                                queryItemString.append("&")
                            }
                            queryItemString.append("\(key)=\(listValue)")
                        }
                    }
                } else {
                    if let value = value {
                        if value is String {
                            if let encodedValue = (value as! String).addingPercentEncoding(withAllowedCharacters: cs) {
                                if(!queryItemString.isEmpty) {
                                    queryItemString.append("&")
                                }
                                queryItemString.append("\(key)=\(encodedValue)")
                            }
                        }
                    }
                }
            }
            return queryItemString
        }
    
    /**
     Method to add global request parameters to Uri Builder
     - parameters:
     - uriBuilder: The Uri.Builder where the global request parameters will be added in required format
     */
    private func prepareGlobalQuery(
        queryMap: inout [String: Any?]
    ) -> [String: Any?] {
        queryMap["account_id"] = BrApi.shared.brApiRequest?.accountId
        
        queryMap["auth_key"] = BrApi.shared.brApiRequest?.authKey
        
        queryMap["domain_key"] = BrApi.shared.brApiRequest?.domainKey
        
        queryMap["_br_uid_2"] = FormatterUtils.shared.formatCookieValue(
            uuid: BrApi.shared.brApiRequest?.uuid ?? "",
            hitcount: BrApi.shared.brApiRequest?.visitorType ?? VisitorType.NEW_USER)
        
        queryMap["request_id"] = FormatterUtils.shared.generateRand()
        
        queryMap["ref_url"] = ""
        
        // customer user id
        if (!(PixelTracker.shared.brPixel!.userId ?? "").isEmpty) {
            queryMap["user_id"] = BrApi.shared.brApiRequest?.userId
        }
        
        return queryMap
    }
    
}
