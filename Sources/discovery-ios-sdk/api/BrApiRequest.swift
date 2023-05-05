//
//  BrApiRequest.swift
//  
//
//  Class containing initialising parameters for the API SDK.
//

import Foundation

public class BrApiRequest {
    
    let accountId: String
    let uuid: String
    let visitorType: VisitorType
    let domainKey: String
    var environment: Env = Env.STAGE
    var authKey: String? = nil
    var userId: String? = nil
    
    public init(accountId: String, uuid: String, visitorType: VisitorType, domainKey: String) {
        self.accountId = accountId
        self.uuid = uuid
        self.visitorType = visitorType
        self.domainKey = domainKey
    }
    
    public init(accountId: String, uuid: String, visitorType: VisitorType, domainKey: String, environment: Env) {
        self.accountId = accountId
        self.uuid = uuid
        self.visitorType = visitorType
        self.domainKey = domainKey
        self.environment = environment
    }
    
    public init(accountId: String, uuid: String, visitorType: VisitorType, domainKey: String, environment: Env, authKey: String? = nil, userId: String? = nil) {
        self.accountId = accountId
        self.uuid = uuid
        self.visitorType = visitorType
        self.domainKey = domainKey
        self.environment = environment
        self.authKey = authKey
        self.userId = userId
    }
}

public enum Env {
    case STAGE
    case PROD
}

public enum Operator {
    case OR
    case AND
}

/**
 * Widget TYPE ENUM to specify which type on widget API needs to be called.
 * This gets added as Path parameter to he request
 */
public enum WidgetApiType: String {
    case ITEM = "item"
    case CATEGORY = "category"
    case KEYWORD = "keyword"
    case PERSONALIZED = "personalized"
    case GLOBAL = "global"
}

enum BrApiException: Error {
    case EmptyValue(errorMessage: String)
}
