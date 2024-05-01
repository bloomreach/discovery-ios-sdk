//  
//  FormatterUtils.swift

//  Utility class for performing string formatting operations
//

import Foundation

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
    func formatCookieValue(uuid: String, hitcount: VisitorType, cdpSegments: String? = nil) -> String {
        // convert uid={{UUID}}:v=app:ts=0:hc={{hitcount}}
        if (cdpSegments ?? "").isEmpty {
            return "uid=\(uuid):v=app:ts=0:hc=\(hitcount.rawValue)"
        } else {
            return "uid=\(uuid):v=app:ts=0:hc=\(hitcount.rawValue):cdp_segments=\(cdpSegments!.toBase64())"
        }
        
    }
    
    /**
     Method to format url value
     - parameters:
     - baseurl: Base Url for the merchant provided bt Bloomreach
     - pType: Page classification type
     - title: Title of the screen
     - returns String value in 'http://merchantname.app/ptype/title' format
     */
    func formatUrl(baseurl: String, pType: String, title: String) -> String {
        // convert in format http://merchantname.app/ptype/title
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
}

extension String {
    /// Encode a String to Base64
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

    /// Decode a String from Base64. Returns nil if unsuccessful.
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
