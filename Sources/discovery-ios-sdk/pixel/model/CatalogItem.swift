//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

public class CatalogItem {
    
    let name: String
    let viewIds: [String]?
    
    public init(name: String, viewIds: [String]?) {
        self.name = name
        self.viewIds = viewIds
    }
}
