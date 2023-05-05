//
//  PixelValidatorBody.swift
//  
//
//

import Foundation

class PixelValidatorBody {
    let source: String
    let `protocol`: String
    let host: String
    let port: String
    let query: String
    let params: KeyValuePairs<String, String?>
    let file: String
    let hash: String
    let path: String
    let relative: String
    let segments: [String]
    
    init(source: String, _protocol: String, host: String, port: String, query: String, params: KeyValuePairs<String, String?>, file: String, hash: String, path: String, relative: String, segments: [String]) {
        self.source = source
        self.protocol = _protocol
        self.host = host
        self.port = port
        self.query = query
        self.params = params
        self.file = file
        self.hash = hash
        self.path = path
        self.relative = relative
        self.segments = segments
    }
}
