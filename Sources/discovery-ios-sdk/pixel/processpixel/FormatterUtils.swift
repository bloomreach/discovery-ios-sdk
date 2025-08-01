//  
//  FormatterUtils.swift

//  Utility class for performing string formatting operations
//

import Foundation
import UIKit

class FormatterUtils {
    
    static public let shared = FormatterUtils()
    
    //Initializer access level private
    private init(){}
    
    
    /**
     Method to generate a random number
     - returns random number in string
     */
    func generateRand() -> String {
        // generate random Long
        let n = Int(arc4random_uniform(999999999))
        return String(n)
    }
    
    /**
     Method to format Cookie2 value
     - parameters:
     - uuid: array of the PixelBasketItem objects
     - hitcount: ENUM VisitorType (The hitcount value should be 1 for a new visitor, or 2 for returning visitors.)
     - returns String  value in 'uid={{UUID}}:v=app:ts=0:hc={{hitcount}}' format
     */
    func formatCookieValue(uuid: String, hitcount: VisitorType) -> String {
        // convert uid={{UUID}}:v=app:ts=0:hc={{hitcount}}
        return "uid=\(uuid):v=app:ts=0:hc=\(hitcount.rawValue)"
    }
    
    /**
     Method to format url value
     - parameters:
     - baseurl: Base Url for the merchant provided bt Bloomreach
     - pType: Page classification type
     - title: Title of the screen
     - brPSuggQ: Value of User clicked a product suggest. If its not there, leave this nil.
     - returns String value in 'http://merchantname.app/ptype/title' format
     */
    func formatUrl(baseurl: String, pType: String, title: String, brPSuggQ: String? = nil) -> String {
        // convert in format http://merchantname.app/ptype/title
        if(pType == PageType.PRODUCT_PAGE.rawValue && brPSuggQ != nil) {
            // returns String value in 'http://merchantname.app/ptype/title?_br_psugg_q=abc' format
            return "\(baseurl)\(pType)/\(title)?_br_psugg_q=\(brPSuggQ ?? "")"
        }
        
        return "\(baseurl)\(pType)/\(title)"
    }
    
    /**
     Method to format catalog value
     The catalog name is encoded by prefixing "cat" + "the index of the catalog starting from 0" + "=" + "the catalog name"
     :param: catalogs Base Url for the merchant provided bt Bloomreach
     @return cataLogs - String value in required format
     */
    
    /**
     Method to format catalog value
     - parameters:
     - catalogs: Array of the CatalogItem objects
     - returns  String value in required format
     
     The catalog name is encoded by prefixing "cat" + "the index of the catalog starting from 0" + "=" + "the catalog name"
     */
    func formatCatalog(catalogs: [CatalogItem]) -> String {
        var string = ""
        for (catalogIndex, catalog) in catalogs.enumerated() {
            // Each catalog in catalogs is separated by an "!"
            if (catalogIndex != 0) {
                string.append("!")
            }
            // add "cat" + "the index of the catalog starting from 0"
            string.append("cat\(catalogIndex)=\(catalog.name)")
            
            if (catalog.viewIds != nil) {
                for (viewIndex, viewId) in catalog.viewIds!.enumerated() {
                    // Catalog name and view_id are separated by a ":"
                    if (viewIndex == 0) {
                        string.append(":")
                    }
                    // Multiple view_ids are separated by a "."
                    else {
                        string.append(".")
                    }
                    // The view_id is encoded by prefixing "v" + "the index of the view_id starting from 0" + "=" + "the view_id"
                    string.append("v\(viewIndex)=\(viewId)")
                }
            }
        }
        return string
    }
    
    /**
     Method to format basket value
     Each product in the cart will be separated by !. Each product's details will be separated by '.
     - parameters:
     - basketItems: -array of the PixelBasketItem objects
     - returns Formatted string for basket vvalue
     */
    func formatBasket(basketItems: [PixelBasketItem]) -> String {
        
        var formattedBasketString = ""
        
        for basketItem in basketItems {
            // add prodId as  '!i<prod_id>'
            formattedBasketString.append("!i\(basketItem.prodId)")
            
            // s<sku> - Sku id, only applies if you have skus.
            if let sku:String = basketItem.sku {
                formattedBasketString.append("'s\(sku)")
            }
            
            // n<product_name>
            formattedBasketString.append("'n\(basketItem.name)")
            
            // q<quantity>
            formattedBasketString.append("'q\(basketItem.quantity)")
            
            // p<price> - This should be the unit price per product and not total price. If the item is on sale, this is the unit sale price.
            formattedBasketString.append("'p\(basketItem.price)")
        }
        return formattedBasketString
    }
    
    /**
     Internal Method to format user agent.
     - returns Formatted string for user agent
     */
    internal func getUserAgent() -> String {
        let SDK_VERSION = "Bloomreach/1.0.19 iOS"
        let device = UIDevice.current.name
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion
        //returns iPhone 15; iOS 17.4; Bloomreach/1.0.15 iOS
        return "\(device); \(systemName) \(systemVersion); \(SDK_VERSION)"
    }
}
