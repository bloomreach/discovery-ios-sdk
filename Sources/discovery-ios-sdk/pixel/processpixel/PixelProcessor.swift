//
//  PixelProcessor.swift
//  
//  Class for processing all the pixel and converting it in required query parameter string
//
//

import Foundation

class PixelProcessor: QueueChanged  {
    
    private let restClient: RestClient = RestClient()
    
    func elementAdded() {
        performApi()
        
    }
    
    func elementRemoved() {
        performApi()
    }
    
    private func performApi() {
        let item = PixelQueue.shared.head()
        if(item != nil) {
            restClient.submitPixel(parameters: item!)
        }
    }
    
    let pageViewPixelFormatter: PageViewPixelFormatter = PageViewPixelFormatter()
    let pixelValidator: PixelValidator = PixelValidator()
    
    
    init() {
        PixelQueue.shared.delegate = self
    }
    
    
    func processPixel(pixelObject: PixelObject) {
        var queryMap: [String: String?] = [:]
        
        // process generic value
        prepareGlobalQuery(pixelObject: pixelObject, queryMap: &queryMap)
        
        switch pixelObject.type {
        case PixelType.PAGEVIEW:
            processPageViewPixel(pixelObject: pixelObject, queryMap: &queryMap)
        case PixelType.EVENT:
            processEventPixel(pixelObject: pixelObject, queryMap: &queryMap)
        }
        
        // Validate Pixel only when in DEBUG mode
        if (PixelTracker.shared.brPixel!.debugMode) {
#if DEBUG
            pixelValidator.validatePixel(queryMap: queryMap)
#endif
        }
        
        // add the processed Map to Queue for further process
        PixelQueue.shared.enqueue(value: queryMap)
    }
    
    @discardableResult private func prepareGlobalQuery(
        pixelObject: PixelObject,
        queryMap: inout [String: String?]
    ) -> [String: String?] {
        queryMap["acct_id"] = PixelTracker.shared.brPixel?.accountId
        
        queryMap["cookie2"] = FormatterUtils.shared.formatCookieValue(
            uuid: PixelTracker.shared.brPixel?.uuid ?? "",
            hitcount: PixelTracker.shared.brPixel?.visitorType ?? VisitorType.NEW_USER)
        
        queryMap["rand"] = FormatterUtils.shared.generateRand()
        
        queryMap["type"] = pixelObject.type.rawValue
        
        queryMap["ptype"] = pixelObject.pType.rawValue
        
        if((PixelTracker.shared.brPixel?.testData) != nil) {
            queryMap["test_data"] = String(PixelTracker.shared.brPixel!.testData)
        }
        
        queryMap["title"] =  pixelObject.title
        
        queryMap["url"] = FormatterUtils.shared.formatUrl(
            baseurl: PixelTracker.shared.brPixel!.baseUrl,
            pType: pixelObject.pType.rawValue,
            title: pixelObject.title
            
        )
        
        queryMap["ref"] = pixelObject.ref
        
        // customer user id
        if (!(PixelTracker.shared.brPixel!.userId ?? "").isEmpty) {
            queryMap["user_id"] = PixelTracker.shared.brPixel!.userId
        }
        
        // customer tier
        if (!(PixelTracker.shared.brPixel!.customerTier ?? "").isEmpty) {
            queryMap["customer_tier"] = PixelTracker.shared.brPixel!.customerTier
        }
        
        // customer country  present
        if (!(PixelTracker.shared.brPixel!.customerCountry ?? "").isEmpty) {
            queryMap["customer_country"] = PixelTracker.shared.brPixel!.customerCountry
        }
        
        // customer geo  present
        if (!(PixelTracker.shared.brPixel!.customerGeo ?? "").isEmpty) {
            queryMap["customer_geo"] = PixelTracker.shared.brPixel!.customerGeo
        }
        
        // customer profile  present
        if (!(PixelTracker.shared.brPixel!.customerProfile ?? "").isEmpty) {
            queryMap["customer_profile"] = PixelTracker.shared.brPixel!.customerProfile
        }
        
        // viewId  present
        if (!(PixelTracker.shared.brPixel!.viewId ?? "").isEmpty) {
            queryMap["view_id"] = PixelTracker.shared.brPixel!.viewId
        }
        
        // currency  present
        if (!(PixelTracker.shared.brPixel!.currency ?? "").isEmpty) {
            queryMap["currency"] = PixelTracker.shared.brPixel!.currency
        }
        
        // domainkey  present
        if (!(PixelTracker.shared.brPixel!.domainKey ?? "").isEmpty) {
            queryMap["domain_key"] = PixelTracker.shared.brPixel!.domainKey
        }
        
        // Event Manager Pixel integration mode only when in DEBUG mode
        if (PixelTracker.shared.brPixel!.debugMode) {
            queryMap["debug"] = String(PixelTracker.shared.brPixel!.debugMode)
        }
        
        
        return queryMap
    }
    
    @discardableResult private func processPageViewPixel(
        pixelObject: PixelObject,
        queryMap: inout [String: String?]
    ) -> [String: String?] {
        // do processing based on pType for each PageView Pixels
        switch pixelObject.pType {
        case PageType.HOME_PAGE:
            return queryMap
            
        case PageType.PRODUCT_PAGE:
            return pageViewPixelFormatter.prepareProductPageViewQuery(pixelObject: pixelObject, queryMap: &queryMap)
            
            
        case PageType.CONTENT_PAGE:
            return pageViewPixelFormatter.prepareContentPageViewQuery(pixelObject: pixelObject, queryMap: &queryMap)
            
            
        case PageType.SEARCH_PAGE:
            if (pixelObject.catalogs != nil) {
                return pageViewPixelFormatter.prepareSearchPageViewQuery(pixelObject: pixelObject, queryMap: &queryMap)
            } else {
                return pageViewPixelFormatter.prepareContentSearchPageViewQuery(
                    pixelObject: pixelObject,
                    queryMap: &queryMap
                )
            }
            
        case PageType.CATEGORY_PAGE:
            return pageViewPixelFormatter.prepareCategoryPageViewQuery(pixelObject: pixelObject, queryMap: &queryMap)
            
        case PageType.CONVERSION:
            return pageViewPixelFormatter.prepareConversionPageViewQuery(pixelObject: pixelObject, queryMap: &queryMap)
            
//        case PageType.OTHER_PAGE:
//            return pageViewPixelFormatter.prepareConversionPageViewQuery(pixelObject: pixelObject, queryMap: &queryMap)
            
        default: return queryMap
        }
    }
    
    @discardableResult  private func processEventPixel(
        pixelObject: PixelObject,
        queryMap: inout [String: String?]
    ) -> [String: String?] {
        queryMap["group"] = pixelObject.group?.rawValue
        queryMap["etype"] = pixelObject.eType
        
        if(pixelObject.prodId != nil) {
            queryMap["prod_id"] = pixelObject.prodId
        }
        
        if(pixelObject.prodName != nil) {
            queryMap["prod_name"] = pixelObject.prodName
        }
        
        if(pixelObject.prodSku != nil) {
            queryMap["sku"] = pixelObject.prodSku
        }
        
        if(pixelObject.prodCollectionId != nil) {
            queryMap["prod_collection_id"] = pixelObject.prodCollectionId
        }
        
        if(pixelObject.searchTerm != nil) {
            queryMap["q"] = pixelObject.searchTerm
        }
        
        if(pixelObject.typedTerm != nil) {
            queryMap["aq"] = pixelObject.typedTerm
        }
        
        if(pixelObject.catalogs != nil) {
            queryMap["catalogs"] = FormatterUtils.shared.formatCatalog(catalogs: pixelObject.catalogs ?? [])
        }
        
        return queryMap
    }
    
    func processPixel(
        queryMap: inout [String: String?]
    ) {
        queryMap["acct_id"] = PixelTracker.shared.brPixel?.accountId
        
        queryMap["cookie2"] = FormatterUtils.shared.formatCookieValue(
            uuid: PixelTracker.shared.brPixel?.uuid ?? "",
            hitcount: PixelTracker.shared.brPixel?.visitorType ?? VisitorType.NEW_USER)
        
        queryMap["rand"] = FormatterUtils.shared.generateRand()
        
        if((PixelTracker.shared.brPixel?.testData) != nil) {
            queryMap["test_data"] = String(PixelTracker.shared.brPixel!.testData)
        }
        
        queryMap["url"] = FormatterUtils.shared.formatUrl(
            baseurl: PixelTracker.shared.brPixel!.baseUrl,
            pType: (queryMap["ptype"] ?? "") ?? "",
            title: (queryMap["title"] ?? "") ?? ""
            
        )
        
        // customer user id
        if (!(PixelTracker.shared.brPixel!.userId ?? "").isEmpty) {
            queryMap["user_id"] = PixelTracker.shared.brPixel!.userId
        }
        
        // customer tier
        if (!(PixelTracker.shared.brPixel!.customerTier ?? "").isEmpty) {
            queryMap["customer_tier"] = PixelTracker.shared.brPixel!.customerTier
        }
        
        // customer country  present
        if (!(PixelTracker.shared.brPixel!.customerCountry ?? "").isEmpty) {
            queryMap["customer_country"] = PixelTracker.shared.brPixel!.customerCountry
        }
        
        // customer geo  present
        if (!(PixelTracker.shared.brPixel!.customerGeo ?? "").isEmpty) {
            queryMap["customer_geo"] = PixelTracker.shared.brPixel!.customerGeo
        }
        
        // customer profile  present
        if (!(PixelTracker.shared.brPixel!.customerProfile ?? "").isEmpty) {
            queryMap["customer_profile"] = PixelTracker.shared.brPixel!.customerProfile
        }
        
        // viewId  present
        if (!(PixelTracker.shared.brPixel!.viewId ?? "").isEmpty) {
            queryMap["view_id"] = PixelTracker.shared.brPixel!.viewId
        }
        
        // currency  present
        if (!(PixelTracker.shared.brPixel!.currency ?? "").isEmpty) {
            queryMap["currency"] = PixelTracker.shared.brPixel!.currency
        }
        
        // domainkey  present
        if (!(PixelTracker.shared.brPixel!.domainKey ?? "").isEmpty) {
            queryMap["domain_key"] = PixelTracker.shared.brPixel!.domainKey
        }
        
        // Validate Pixel only when in DEBUG mode
        if (PixelTracker.shared.brPixel!.debugMode) {
#if DEBUG
            pixelValidator.validatePixel(queryMap: queryMap)
#endif
        }
        
        // Event Manager Pixel integration mode only when in DEBUG mode
        if (PixelTracker.shared.brPixel!.debugMode) {
            queryMap["debug"] = String(PixelTracker.shared.brPixel!.debugMode)
        }
        
        // add the processed Map to Queue for further process
        PixelQueue.shared.enqueue(value: queryMap)
        
    }
    
}
