
//  PageViewPixelFormatter.swift
//  
//  Class for creating query parameter as String for each Page View Pixel in required format
//  

import Foundation

class PageViewPixelFormatter {
    
    /**
     Method to generating query parameter String for Product Page View Pixel
     - parameters:
     - pixelObject: internal object which holds data for fields required to generate query parameter String
     - queryMap: reference of Map where the values will be added
     - returns Map with value in required format
     */
    func prepareProductPageViewQuery(pixelObject: PixelObject, queryMap: inout [String: String?]) ->  [String: String?] {
        queryMap["prod_id"] = pixelObject.prodId
        queryMap["prod_name"] = pixelObject.prodName
        
        if(pixelObject.prodSku != nil) {
            queryMap["sku"] = pixelObject.prodSku
        }
        
        return queryMap
    }
    
    /**
     Method to generating query parameter String for Content Page View Pixel
     - parameters:
     - pixelObject: internal object which holds data for fields required to generate query parameter String
     - queryMap: reference of Map where the values will be added
     - returns Map with value in required format
     */
    func prepareContentPageViewQuery(pixelObject: PixelObject, queryMap:  inout [String: String?]) -> [String: String?] {
        if (pixelObject.catalogs != nil) {
            if(!pixelObject.catalogs!.isEmpty){
                queryMap["catalogs"] = FormatterUtils.shared.formatCatalog(catalogs: pixelObject.catalogs!)
            }
        }
        
        queryMap["item_id"] = pixelObject.itemId
        queryMap["item_name"] = pixelObject.itemName
        return queryMap
    }
    
    /**
     Method to generating query parameter String for Content Search Page View Pixel
     - parameters:
     - pixelObject: internal object which holds data for fields required to generate query parameter String
     - queryMap: reference of Map where the values will be added
     - returns Map with value in required format
     */
    func prepareContentSearchPageViewQuery(pixelObject: PixelObject, queryMap: inout [String: String?]) -> [String: String?] {
        if (pixelObject.catalogs != nil) {
            if(!pixelObject.catalogs!.isEmpty){
                queryMap["catalogs"] = FormatterUtils.shared.formatCatalog(catalogs: pixelObject.catalogs!)
            }
        }
        queryMap["search_term"] = pixelObject.searchTerm
        return queryMap
    }
    
    /**
     Method to generating query parameter String for Search Page View Pixel
     - parameters:
     - pixelObject: internal object which holds data for fields required to generate query parameter String
     - queryMap: reference of Map where the values will be added
     - returns Map with value in required format
     */
    func prepareSearchPageViewQuery(pixelObject: PixelObject,  queryMap: inout [String: String?]) -> [String: String?] {
        queryMap["search_term"] = pixelObject.searchTerm
        return queryMap
    }
    
    /**
     Method to generating query parameter String for Category Page View Pixel
     - parameters:
     - pixelObject: internal object which holds data for fields required to generate query parameter String
     - queryMap: reference of Map where the values will be added
     - returns Map with value in required format
     */
    func prepareCategoryPageViewQuery(pixelObject: PixelObject,  queryMap: inout [String: String?]) -> [String: String?] {
        queryMap["cat"] = pixelObject.cat
        queryMap["catId"] = pixelObject.catId
        return queryMap
    }
    
    /**
     Method to generating query parameter String for Conversion Page View Pixel
     - parameters:
     - pixelObject: internal object which holds data for fields required to generate query parameter String
     - queryMap: reference of Map where the values will be added
     - returns Map with value in required format
     */
    func prepareConversionPageViewQuery(pixelObject: PixelObject, queryMap: inout [String: String?]) -> [String: String?] {
        queryMap["is_conversion"] = String(pixelObject.isConversion ?? 0)
        queryMap["basket_value"] = pixelObject.basketValue
        queryMap["order_id"] = pixelObject.orderId
        queryMap["basket"] = FormatterUtils.shared.formatBasket(basketItems: pixelObject.basket ?? [])
        return queryMap
    }
}
