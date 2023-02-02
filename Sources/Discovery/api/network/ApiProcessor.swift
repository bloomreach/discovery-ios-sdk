//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation


class ApiProcessor {
    
    
    private let CORE_API_PATH = "/api/v1/core/"
    private let SUGGEST_API_PATH = "/api/v2/suggest"
    private let WIDGET_API_PATH = "/api/v2/widgets/"
    private let restClientApi = RestClientApi()
    
    func processCoreApi(parameters:  [String: Any?],  success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: BrApiError?) -> Void) {
        var queryMap = parameters
        let url = URL(string: getBaseUrlForCore())
        var components = URLComponents(string: url!.absoluteString)!
        
        print("url: \(components.url)"  )
        var params = prepareGlobalQuery(queryMap: &queryMap)
//        components.queryItems = parameters.map { (key, value) in
//            if value is [String] {
//                for listValue in (value as! [String]) {
//                    return URLQueryItem(name: key, value: listValue)
//                }
//            } else {
//                return URLQueryItem(name: key, value: value as? String)
//            }
//            return URLQueryItem(name: key, value: value as! String)
//        }
//
//        var qeryItemArr: [URLQueryItem] = []
//        params.map { (key, value) in
//            if value is [String] {
//                for listValue in (value as! [String]) {
//                    qeryItemArr.append(URLQueryItem(name: key, value: listValue))
//                }
//            } else {
//                qeryItemArr.append(URLQueryItem(name: key, value: value as? String))
//            }
//        }
        
        components.queryItems = getQueryItemArray(params: params)
        restClientApi.doApiCall(components: components, success: success, failure: failure)
    }
    
    func getQueryItemArray(params:  [String: Any?]) -> [URLQueryItem] {
        var qeryItemArr: [URLQueryItem] = []
        params.map { (key, value) in
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
    
    func processSuggestApi(parameters:  [String: Any?],  success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: BrApiError?) -> Void) {
        var queryMap = parameters
        let url = URL(string: getBaseUrlForSuggest())
        var components = URLComponents(string: url!.absoluteString)!
        var params = prepareGlobalQuery(queryMap: &queryMap)
//        components.queryItems = parameters.map { (key, value) in
//            if value is [String] {
//                for listValue in (value as! [String]) {
//                    return URLQueryItem(name: key, value: listValue)
//                }
//            } else {
//                return URLQueryItem(name: key, value: value as? String)
//            }
//            return URLQueryItem(name: key, value: value as! String)
//        }
//
        var qeryItemArr: [URLQueryItem] = []
        params.map { (key, value) in
            if value is [String] {
                for listValue in (value as! [String]) {
                    qeryItemArr.append(URLQueryItem(name: key, value: listValue))
                }
            } else {
                qeryItemArr.append(URLQueryItem(name: key, value: value as? String))
            }
        }
        
        components.queryItems = qeryItemArr
        restClientApi.doApiCall(components: components, success: success, failure: failure)
    }
    
    func getBaseUrlForCore() -> String {
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
    
    private func getBaseUrlForRp() -> String {
        var url = ""
        if BrApi.shared.brApiRequest?.environment == Env.STAGE {
            url = "https://pathways-staging.dxpapi.com"
        } else if BrApi.shared.brApiRequest?.environment == Env.PROD {
            url = "https://pathways.dxpapi.com"
        }
        url.append(SUGGEST_API_PATH)
        return url
    }

}


/**
     * Method to add global request parameters to Uri Builder
     * @param uriBuilder The Uri.Builder where the global request parameters will be added in required format
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
