//
//  SuggestResponse.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

// MARK: - SuggestResponse
public struct SuggestResponse: Codable {
    let queryContext: QueryContext?
    let suggestionGroups: [SuggestionGroup]?
}

// MARK: - QueryContext
struct QueryContext: Codable {
    let originalQuery: String?
}

// MARK: - SuggestionGroup
struct SuggestionGroup: Codable {
    let catalogName, view: String?
    let querySuggestions: [QuerySuggestion]?
    let attributeSuggestions: [AttributeSuggestion]?
    let searchSuggestions: [SearchSuggestion]?

}

// MARK: - QuerySuggestion
struct QuerySuggestion: Codable {
    let displayText, query: String?

}

// MARK: - AttributeSuggestion
struct AttributeSuggestion: Codable {
    let attributeType, name, value: String?

}

// MARK: - SearchSuggestion
struct SearchSuggestion: Codable {
    let pid, title, url: String?
    let thumbImage: String?
    let salePrice: Double?
    let variants: [Variant]?
    
    enum CodingKeys: String, CodingKey {
        case pid, title, url
        case thumbImage = "thumb_image"
        case salePrice = "sale_price"
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let skuId: [String]?

    enum CodingKeys: String, CodingKey {
        case skuId = "skuid"
    }
}
