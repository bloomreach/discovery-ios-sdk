//
//  ImageUploadResponse.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

// MARK: - ImageUploadResponse
public struct ImageUploadResponse {
    public let response: UploadResponse?
    public let metadata: RpMetadata?
    public var extraOptions: [String: AnyDecodable?]
}

// MARK: - RpResponse
public struct UploadResponse {
    public let imageId: String?
    public var extraOptions: [String: AnyDecodable?]
}

extension ImageUploadResponse: Decodable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case response
        case metadata
        
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.response = try container.decodeIfPresent(UploadResponse.self, forKey: .response)
        self.metadata = try container.decodeIfPresent(RpMetadata.self, forKey: .metadata)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}


extension UploadResponse: Decodable {
    private enum KnownCodingKeys: CodingKey, CaseIterable {
        case image_id
        
        static func doesNotContain(_ key: DynamicCodingKeys) -> Bool {
            !Self.allCases.map(\.stringValue).contains(key.stringValue)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KnownCodingKeys.self)
        
        self.imageId = try container.decodeIfPresent(String.self, forKey: .image_id)
        
        self.extraOptions = [:]
        let extraContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in extraContainer.allKeys where KnownCodingKeys.doesNotContain(key) {
            let decoded = try extraContainer.decode(AnyDecodable?.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            self.extraOptions[key.stringValue] = decoded
        }
    }
}
