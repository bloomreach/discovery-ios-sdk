//
//  CatalogItem.swift
//  
//  Model class for Catalog Item
//

import Foundation

public class CatalogItem {
    
    let name: String
    let viewIds: [String]?
    
    public init(name: String, viewIds: [String]? = nil) {
        self.name = name
        self.viewIds = viewIds
    }
}
