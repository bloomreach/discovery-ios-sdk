//
//  PixelValidatorResponse.swift
//  
//
//

import Foundation

// MARK: - PixelValidatorResponse
struct PixelValidatorResponse: Codable {
    let displayName: String
    let params: [Param]?
    let merchant: String
    let url: String
    let errors : [Param]
    let warns: [Param]
    let success: [Param]
}

// MARK: - Success or Param or Warns or Error
struct Param: Codable {
    let name: String
    let value: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name, value
        case description
    }
}
