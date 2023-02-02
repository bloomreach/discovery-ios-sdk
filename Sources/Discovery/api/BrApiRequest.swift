//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
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
}

public enum Env {
    case STAGE
    case PROD
}

public enum Operator {
    case OR
    case AND
}
