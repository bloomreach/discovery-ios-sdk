//
//  CoreResponse.swift
//  
//
//

import Foundation

public struct CoreResponse {
    public let response: Response?
    public let facetCounts: FacetCounts?
    public let categoryMap: [String: String?]?
    public let didYouMean: [String]?
    public let campaign: Campaign?
    public let stats: Stats?
    public let keywordRedirect: KeywordRedirect?
    public let metadata: Metadata?
    public let autoCorrectQuery: String?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Response
public struct Response {
    public let numFound, start: Int?
    public let docs: [Doc]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Doc
public struct Doc {
    public let pid: String?
    public let brand: String?
    public let description: String?
    public let price: Double?
    public let salePrice: Double?
    public let thumbImage: String?
    public let title: String?
    public let url: String?
    public let variants: [Variant]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - FacetCounts
public struct FacetCounts {
    public let facetFields: [String: [FacetFields]]?
    public let facetQueries: [String: [FacetFields]]?
    public let facetRanges: [String: [String]]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - FacetFields
public struct FacetFields {
    public let name: String?
    public let count: Int?
    public let catId: String?
    public let catName: String?
    public let crumb: String?
    public let treePath: String?
    public let parent: String?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Campaign
public struct Campaign {
    public let id: String?
    public let htmlText: String?
    public let bannerType: String?
    public let keyword: String?
    public let name: String?
    public let dateEnd: String?
    public let dateStart: String?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Stats
public struct Stats {
    public let statsFields: [String: StatsField]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - StatsField
public struct StatsField {
    public let min: Double?
    public let max: Double?
    public var extraOptions: [String: AnyDecodable?]
}

//// MARK: - KeywordRedirect
public struct KeywordRedirect {
    public let originalQuery: String?
    public let redirectedQuery: String?
    public let redirectedUrl: String?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Metadata
public struct Metadata {
    public let query: Query?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Query
public struct Query {
    public let modification: Modification?
    public let didYouMean: [String]?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - Modification
public struct Modification {
    public let mode: String?
    public let value: String?
    public var extraOptions: [String: AnyDecodable?]
}


extension CoreResponse: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case response
    case category_map
    case did_you_mean
    case facet_counts
    case campaign
    case stats
    case keywordRedirect
    case metadata
    case autoCorrectQuery

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        self.response = try container.decodeIfPresent(Response.self, forKey: .response)
        self.categoryMap = try container.decodeIfPresent([String: String?].self, forKey: .category_map)
        self.didYouMean = try container.decodeIfPresent([String].self, forKey: .did_you_mean)
        self.facetCounts = try container.decodeIfPresent(FacetCounts.self, forKey: .facet_counts)
        self.campaign = try container.decodeIfPresent(Campaign.self, forKey: .campaign)
        self.stats = try container.decodeIfPresent(Stats.self, forKey: .stats)
        self.keywordRedirect = try container.decodeIfPresent(KeywordRedirect.self, forKey: .keywordRedirect)
        self.metadata = try container.decodeIfPresent(Metadata.self, forKey: .metadata)
        self.autoCorrectQuery = try container.decodeIfPresent(String.self, forKey: .autoCorrectQuery)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension Response: Decodable {
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
        self.docs = try container.decodeIfPresent([Doc].self, forKey: .docs)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension Doc: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case pid
    case brand
    case description
    case price
    case sale_price
    case thumb_image
    case title
    case url
    case variants

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.pid = try container.decodeIfPresent(String.self, forKey: .pid)
        self.brand = try container.decodeIfPresent(String.self, forKey: .brand)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.salePrice = try container.decodeIfPresent(Double.self, forKey: .sale_price)
        self.thumbImage = try container.decodeIfPresent(String.self, forKey: .thumb_image)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.variants = try container.decodeIfPresent([Variant].self, forKey: .variants)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension FacetCounts: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case facet_fields
    case facet_queries
    case facet_ranges

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.facetFields = try container.decodeIfPresent([String: [FacetFields]].self, forKey: .facet_fields)
        self.facetQueries = try container.decodeIfPresent([String: [FacetFields]].self, forKey: .facet_queries)
        self.facetRanges = try container.decodeIfPresent([String: [String]].self, forKey: .facet_ranges)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension FacetFields: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case name
    case count
    case cat_id
    case cat_name
    case crumb
    case tree_path
    case parent

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.catId = try container.decodeIfPresent(String.self, forKey: .cat_id)
        self.catName = try container.decodeIfPresent(String.self, forKey: .cat_name)
        self.crumb = try container.decodeIfPresent(String.self, forKey: .crumb)
        self.treePath = try container.decodeIfPresent(String.self, forKey: .tree_path)
        self.parent = try container.decodeIfPresent(String.self, forKey: .parent)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension Campaign: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case id
    case htmlText
    case bannerType
    case keyword
    case name
    case dateEnd
    case dateStart

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.htmlText = try container.decodeIfPresent(String.self, forKey: .htmlText)
        self.bannerType = try container.decodeIfPresent(String.self, forKey: .bannerType)
        self.keyword = try container.decodeIfPresent(String.self, forKey: .keyword)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.dateEnd = try container.decodeIfPresent(String.self, forKey: .dateEnd)
        self.dateStart = try container.decodeIfPresent(String.self, forKey: .dateStart)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}



extension Stats: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case stats_fields

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.statsFields = try container.decodeIfPresent([String: StatsField].self, forKey: .stats_fields)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension StatsField: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case min
    case max

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.min = try container.decodeIfPresent(Double.self, forKey: .min)
        self.max = try container.decodeIfPresent(Double.self, forKey: .max)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension KeywordRedirect: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case originalQuery
    case redirectedQuery
    case redirectedUrl

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.originalQuery = try container.decodeIfPresent(String.self, forKey: .originalQuery)
        self.redirectedQuery = try container.decodeIfPresent(String.self, forKey: .redirectedQuery)
        self.redirectedUrl = try container.decodeIfPresent(String.self, forKey: .redirectedUrl)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension Metadata: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case query

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.query = try container.decodeIfPresent(Query.self, forKey: .query)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension Query: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case modification
    case didYouMean

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.modification = try container.decodeIfPresent(Modification.self, forKey: .modification)
        self.didYouMean = try container.decodeIfPresent([String].self, forKey: .didYouMean)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

extension Modification: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case mode
    case value

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.mode = try container.decodeIfPresent(String.self, forKey: .mode)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}

struct DynamicCodingKeys: CodingKey {
  var stringValue: String
  init?(stringValue: String) {
    self.stringValue = stringValue
  }

  // not used here, but a protocol requirement
  var intValue: Int?
  init?(intValue: Int) {
    return nil
  }
}


// MARK: - Modification
public struct BrApiError {
    public let message: String?
    public let errorCode: Int?
    public var extraOptions: [String: AnyDecodable?]
}


extension BrApiError: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case message
    case status_code

    static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
    }
  }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)

        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.errorCode = try container.decodeIfPresent(Int.self, forKey: .status_code)

        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)

        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}


