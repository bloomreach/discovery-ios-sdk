//
//  RecsAndPathwaysResponse.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

// MARK: - RecsAndPathwaysResponse
public struct RecsAndPathwaysResponse: Codable {
    let response: RpResponse?
    let metadata: RpMetadata?
}

// MARK: - RpMetadata
struct RpMetadata: Codable {
    let widget: Widget?
    let response: MetadataResponse?
}

// MARK: - MetadataResponse
struct MetadataResponse: Codable {
    let personalizedResults: Bool?
    let fallback, recall: String?

    enum CodingKeys: String, CodingKey {
        case personalizedResults = "personalized_results"
        case fallback, recall
    }
}

// MARK: - Widget
struct Widget: Codable {
    let id, name, widgetDescription, type: String?
    let rid: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case widgetDescription = "description"
        case type, rid
    }
}

// MARK: - RpResponse
struct RpResponse: Codable {
    let numFound, start: Int?
    let docs: [RpDoc]?
}

// MARK: - RpDoc
struct RpDoc: Codable {
    let manufacturer: String?
    let price: Double?
    let type, catalogNumber, pid: String?

    enum CodingKeys: String, CodingKey {
        case manufacturer, price, type
        case catalogNumber = "catalog_number"
        case pid
    }
}
