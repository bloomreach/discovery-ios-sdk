//
//  RecsAndPathwaysResponse.swift
//
//

import Foundation

// MARK: - RecsAndPathwaysResponse
public struct RecsAndPathwaysResponse {
    public let response: RpResponse?
    public let metadata: RpMetadata?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - RpMetadata
public struct RpMetadata {
    public let widget: Widget?
    public let response: MetadataResponse?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - MetadataResponse
public struct MetadataResponse {
    public let personalizedResults: Bool?
    public let fallback, recall: String?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Widget
public struct Widget {
    public let id, name, widgetDescription, type: String?
    public let rid: String?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - RpResponse
public struct RpResponse {
    public let numFound, start: Int?
    public let docs: [RpDoc]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - RpDoc
public struct RpDoc {
    public let manufacturer: String?
    public let price: Double?
    public let type, catalogNumber, pid: String?
    public let brand: String?
    public let description: String?
    public let salePrice: Double?
    public let thumbImage: String?
    public let title: String?
    public var extraOptions: [String: AnyDecodable?]
}

extension RecsAndPathwaysResponse: Decodable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case response
        case metadata
        
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.response = try container.decodeIfPresent(RpResponse.self, forKey: .response)
        self.metadata = try container.decodeIfPresent(RpMetadata.self, forKey: .metadata)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension RpMetadata: Decodable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case widget
        case response
        
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.widget = try container.decodeIfPresent(Widget.self, forKey: .widget)
        self.response = try container.decodeIfPresent(MetadataResponse.self, forKey: .response)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension MetadataResponse: Decodable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case personalized_results
        case fallback
        case recall
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.personalizedResults = try container.decodeIfPresent(Bool.self, forKey: .personalized_results)
        self.fallback = try container.decodeIfPresent(String.self, forKey: .fallback)
        self.recall = try container.decodeIfPresent(String.self, forKey: .recall)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension Widget: Decodable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case id
        case name
        case description
        case type
        case rid
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.widgetDescription = try container.decodeIfPresent(String.self, forKey: .description)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.rid = try container.decodeIfPresent(String.self, forKey: .rid)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension RpResponse: Decodable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case numFound
        case start
        case docs
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.numFound = try container.decodeIfPresent(Int.self, forKey: .numFound)
        self.start = try container.decodeIfPresent(Int.self, forKey: .start)
        self.docs = try container.decodeIfPresent([RpDoc].self, forKey: .docs)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension RpDoc: Decodable, Hashable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case manufacturer
        case price
        case type
        case catalog_number
        case pid
        case brand
        case description
        case sale_price
        case thumb_image
        case title
        case url
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.manufacturer = try container.decodeIfPresent(String.self, forKey: .manufacturer)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.catalogNumber = try container.decodeIfPresent(String.self, forKey: .catalog_number)
        self.pid = try container.decodeIfPresent(String.self, forKey: .pid)
        
        self.brand = try container.decodeIfPresent(String.self, forKey: .brand)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.salePrice = try container.decodeIfPresent(Double.self, forKey: .sale_price)
        self.thumbImage = try container.decodeIfPresent(String.self, forKey: .thumb_image)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

// MARK: - Modification
public struct RpError {
    public let detail: String?
    public var extraOptions: [String: AnyDecodable?]
}


extension RpError: Decodable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case detail
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.detail = try container.decodeIfPresent(String.self, forKey: .detail)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}
