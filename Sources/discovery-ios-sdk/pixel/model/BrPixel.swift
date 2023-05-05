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
    var domainKey: String? = nil
    var userId: String? = nil
    var testData: Bool = false
    var currency: String? = nil
    var pixelUrlByRegion: String? = nil
    //segments
    var customerTier: String? = nil
    var customerCountry: String? = nil
    var customerGeo: String? = nil
    var customerProfile: String? = nil
    
    public init(accountId: String, uuid: String, visitorType: VisitorType, baseUrl: String) {
        self.accountId = accountId
        self.uuid = uuid
        self.visitorType = visitorType
        self.baseUrl = baseUrl
        self.pixelUrlByRegion = PixelRegion.NA.rawValue
    }
    
    public init(accountId: String, uuid: String, visitorType: VisitorType, baseUrl: String, domainKey: String? = nil, userId: String? = nil, testData:Bool = false, currency: String? = nil, pixelUrlByRegion: String = PixelRegion.NA.rawValue, customerTier: String? = nil, customerCountry:String? = nil, customerGeo: String? = nil, customerProfile: String? = nil) {
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
