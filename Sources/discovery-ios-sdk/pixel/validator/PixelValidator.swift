//
//  PixelValidator.swift
//  
//
//  PixelValidator class to format Pixel Validator request and perform the API call and format the response
//

import Foundation

class PixelValidator {
    
    
    private let _protocol = "https"
    private let path = "pix.gif"
    
    func validatePixel(queryMap: [String: String?]) {
        guard let baseUrl = PixelTracker.shared.brPixel?.pixelUrlByRegion,
              let urlString = URL(string: "https://\(baseUrl)/pix.gif"),
              var components = URLComponents(string: urlString.absoluteString) else {
            return
        }
        components.queryItems = queryMap.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let postBody: [String: Any] = [
            "source": components.url!.absoluteString,
            "protocol": _protocol,
            "host": components.host ?? "",
            "port": "",
            "query": components.query ?? "",
            "params": queryMap,
            "file": path,
            "hash": "",
            "path": "/\(path)",
            "relative": "/\(path + (components.query ?? ""))",
            "segments": [path]
        ]
        
        let restClient = RestClient()
        restClient.validatePixel(postBody: postBody)
        
    }
}
