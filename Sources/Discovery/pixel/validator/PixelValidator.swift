//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

class PixelValidator {
    
    
    private let _protocol = "https"
    private let path = "pix.gif"
    
    func validatePixel(queryMap: [String: String?]) {
        
        let url = URL(string: "https://p.brsrvr.com/pix.gif")
        var components = URLComponents(string: url!.absoluteString)!
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
