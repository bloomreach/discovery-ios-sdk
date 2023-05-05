//
//  SuggestResponse.swift
//  
//

import Foundation

// MARK: - SuggestResponse
public struct SuggestResponse {
    public let queryContext: QueryContext?
    public let suggestionGroups: [SuggestionGroup]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - QueryContext
public struct QueryContext {
    public let originalQuery: String?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - SuggestionGroup
public struct SuggestionGroup {
    public let catalogName, view: String?
    public let querySuggestions: [QuerySuggestion]?
    public let attributeSuggestions: [AttributeSuggestion]?
    public let searchSuggestions: [SearchSuggestion]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - QuerySuggestion
public struct QuerySuggestion {
    public let displayText, query: String?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - AttributeSuggestion
public struct AttributeSuggestion {
    public let attributeType, name, value: String?
    public var extraOptions: [String: AnyDecodable?]

}

// MARK: - SearchSuggestion
public struct SearchSuggestion {
    public let pid, title, url: String?
    public let thumbImage: String?
    public let salePrice: Double?
    public let variants: [Variant]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Variant
public struct Variant {
    public let skuId: [String]?
    public var extraOptions: [String: AnyDecodable?]
}


extension SuggestResponse: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case queryContext
    case suggestionGroups

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.queryContext = try container.decodeIfPresent(QueryContext.self, forKey: .queryContext)
        self.suggestionGroups = try container.decodeIfPresent([SuggestionGroup].self, forKey: .suggestionGroups)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension QueryContext: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case originalQuery

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.originalQuery = try container.decodeIfPresent(String.self, forKey: .originalQuery)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}


extension SuggestionGroup: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case catalogName
    case view
    case querySuggestions
    case attributeSuggestions
    case searchSuggestions

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.catalogName = try container.decodeIfPresent(String.self, forKey: .catalogName)
        self.view = try container.decodeIfPresent(String.self, forKey: .view)
        self.querySuggestions = try container.decodeIfPresent([QuerySuggestion].self, forKey: .querySuggestions)
        self.attributeSuggestions = try container.decodeIfPresent([AttributeSuggestion].self, forKey: .attributeSuggestions)
        self.searchSuggestions = try container.decodeIfPresent([SearchSuggestion].self, forKey: .searchSuggestions)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension QuerySuggestion: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case displayText
    case query

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.displayText = try container.decodeIfPresent(String.self, forKey: .displayText)
        self.query = try container.decodeIfPresent(String.self, forKey: .query)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension AttributeSuggestion: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case attributeType
    case name
    case value

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.attributeType = try container.decodeIfPresent(String.self, forKey: .attributeType)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}


extension SearchSuggestion: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case pid
    case title
    case url
    case thumb_image
    case sale_price
    case variants

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.pid = try container.decodeIfPresent(String.self, forKey: .pid)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.thumbImage = try container.decodeIfPresent(String.self, forKey: .thumb_image)
        self.salePrice = try container.decodeIfPresent(Double.self, forKey: .sale_price)
        self.variants = try container.decodeIfPresent([Variant].self, forKey: .variants)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension Variant: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case skuid

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.skuId = try container.decodeIfPresent([String].self, forKey: .skuid)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}
