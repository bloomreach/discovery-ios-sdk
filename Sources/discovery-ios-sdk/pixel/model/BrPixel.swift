//
//  BrPixel.swift
//  
//  Class containing initialising parameters for the Pixel SDK.
//

import Foundation

public class BrPixel {
    let accountId: String
    let uuid: String
    let visitorType: VisitorType
    let baseUrl: String
    public var domainKey: String? = nil
    public var userId: String? = nil
    public var testData: Bool = false
    public var currency: String? = nil
    public var pixelUrlByRegion: String? = nil
    //segments
    public var customerTier: String? = nil
    public var customerCountry: String? = nil
    public var customerGeo: String? = nil
    public var customerProfile: String? = nil
    
    public var viewId: String? = nil
    // for turning off Pixel Validator logs
    public var debugMode: Bool = false
    
    public init(accountId: String, uuid: String, visitorType: VisitorType, baseUrl: String) {
        self.accountId = accountId
        self.uuid = uuid
        self.visitorType = visitorType
        self.baseUrl = baseUrl
        self.pixelUrlByRegion = PixelRegion.NA.rawValue
    }
    
    public init(accountId: String, uuid: String, visitorType: VisitorType, baseUrl: String, domainKey: String? = nil, userId: String? = nil, testData:Bool = false, currency: String? = nil, pixelUrlByRegion: String = PixelRegion.NA.rawValue, customerTier: String? = nil, customerCountry:String? = nil, customerGeo: String? = nil, customerProfile: String? = nil, viewId: String? = nil) {
        self.accountId = accountId
        self.uuid = uuid
        self.visitorType = visitorType
        self.baseUrl = baseUrl
        self.domainKey = domainKey
        self.userId = userId
        self.testData = testData
        self.currency = currency
        self.pixelUrlByRegion = pixelUrlByRegion
        self.customerTier = customerTier
        self.customerCountry = customerCountry
        self.customerGeo = customerGeo
        self.customerProfile = customerProfile
        self.viewId = viewId
        
    }
}

public enum VisitorType : Int {
    case NEW_USER = 1
    case RETURNING_USER = 2
}

public enum PixelRegion : String {
    case NA = "p.brsrvr.com"
    case EU = "p-eu.brsrvr.com"
    case TEST = "p-test.brsrvr.com"
}
