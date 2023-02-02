//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

public class BrApiError: Error {
    
}


enum BrApiException: Error {
    case EmptyValue(errorMessage: String)
}
