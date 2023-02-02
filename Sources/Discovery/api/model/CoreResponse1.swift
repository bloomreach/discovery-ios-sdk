////
////  File.swift
////
////
////  Created by Prashant Bhujbal
////
//
//import Foundation
//
//// MARK: - CoreResponse
//public struct CoreResponse: Codable {
//    let response: Response?
//    let facetCounts: FacetCounts?
//    let categoryMap: [String: String?]?
//    let didYouMean: [String]?
//    let campaign: Campaign?
//    let stats: Stats?
//    let keywordRedirect: KeywordRedirect?
//    let metadata: Metadata?
//    let autoCorrectQuery: String?
//
//    enum CodingKeys: String, CodingKey {
//        case response
//        case facetCounts = "facet_counts"
//        case categoryMap = "category_map"
//        case didYouMean = "did_you_mean"
//        case campaign
//        case stats
//        case keywordRedirect
//        case metadata
//        case autoCorrectQuery
//    }
//    
////    struct StringKey: CodingKey {
////        var intValue: Int?
////
////        init?(intValue: Int) {
////
////        }
////
////        let stringValue: String
////        init(_ string: String) { self.stringValue = string}
////        init?(stringValue: String) {
////            self.init(stringValue)
////        }
////    }
////
////    public init(from decoder: Decoder) throws {
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////        otherFields = try additionalParameters(from: container, excludingKeys: ["response","facetCounts","categoryMap","didYouMean","campaign","stats","keywordRedirect","metadata" ,"autoCorrectQuery"].map(StringKey.init))
////    }
////
////    func additionalParameters<Key>(from container: KeyedDecodingContainer<Key>, excludingKeys: [Key]) throws -> [String: Any] where Key: CodingKey {
////        let excludedKeys = excludingKeys.map { $0.stringValue }
////
////        let optionalKeys = container.allKeys.filter {
////            !excludedKeys.contains($0.stringValue)
////        }
////
////        var p: [String: Any] = [:]
////
////        for key in optionalKeys {
////
////            if let stringValue = try? container.decode(String.self, forKey: key) {
////                p[key.stringValue] = stringValue
////            }
////        }
////
////        return p
////    }
//}
//
//// MARK: - FacetCounts
//struct FacetCounts: Codable {
//    let facetFields: [String: [FacetFields]]?
//    let facetQueries: [String: [FacetFields]]?
//    let facetRanges: [String: [String]]?
//    //other fields
//
//    enum CodingKeys: String, CodingKey {
//        case facetFields = "facet_fields"
//        case facetQueries = "facet_queries"
//        case facetRanges = "facet_ranges"
//    }
//}
//
//// MARK: - FacetFields
//struct FacetFields: Codable {
//    let name: String?
//    let count: Int?
//    //other fields
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let numFound, start: Int?
//    let docs: [Doc]?
//    //other fields
//}
//
//// MARK: - Doc
//struct Doc: Codable {
//    let pid: String?
//
//    enum CodingKeys: String, CodingKey {
//        case pid
//    
//    }
//}
//
//// MARK: - Campaign
//struct Campaign: Codable {
//    let id: String?
//    let htmlText: String?
//    let bannerType: String?
//    let keyword: String?
//    let name: String?
//    let dateEnd: String?
//    let dateStart: String?
//    //other fields
//}
//
//
//// MARK: - Stats
//struct Stats: Codable {
//    let statsFields: [String: StatsField]?
//    //other fields
//    
//    enum CodingKeys: String, CodingKey {
//        case statsFields = "stats_fields"
//    }
//}
//
//// MARK: - StatsField
//struct StatsField: Codable {
//    let min: Double?
//    let max: Double?
//}
//
//// MARK: - KeywordRedirect
//struct KeywordRedirect: Codable {
//    let originalQuery: String?
//    let redirectedQuery: String?
//    let redirectedUrl: String?
//}
//
//// MARK: - Metadata
//struct Metadata: Codable {
//    let query: Query?
//}
//
//// MARK: - Query
//struct Query: Codable {
//    let modification: Modification?
//    let didYouMean: [String]?
//}
//
//// MARK: - Modification
//struct Modification: Codable {
//    let mode: String?
//    let value: String?
//}
