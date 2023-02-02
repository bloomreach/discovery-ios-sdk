//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

public struct CoreResponse {
    let response: Response?
    var extraOptions: [String: AnyDecodable]
}
// MARK: - Response
struct Response: Codable {
    let numFound, start: Int?
    let docs: [Doc]?
    //other fields
}

// MARK: - Doc
struct Doc: Codable {
    let pid: String?

    enum CodingKeys: String, CodingKey {
        case pid
    
    }
}

extension CoreResponse: Decodable {
  private enum KnownCodingKeys: CodingKey, CaseIterable {
    case response

    static func doesNotContain(_ key: CoreResponse.DynamicCodingKeys) -> Bool {
      !Self.allCases.map(\.stringValue).contains(key.stringValue)
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

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        self.response = try container.decode(Response.self, forKey: .response)
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}
