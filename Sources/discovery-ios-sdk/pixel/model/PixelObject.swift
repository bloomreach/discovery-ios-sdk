//
//  PixelObject.swift
//
// Model class for PixelObject. Pixel Object will hold all the fields provided by merchant app and will be used for further process and converting it to required Query Parameter
//

import Foundation

final class PixelObject {
    
    let type: PixelType //ENUM
    let pType: PageType //ENUM
    let title: String
    let ref: String
    
    var eType: String? = nil
    var prodId: String? = nil
    var prodName: String? = nil
    var prodSku: String? = nil
    var prodCollectionId: String? = nil
    
    var catalogs: [CatalogItem]? = nil //Array of catalogs
    var itemId: String? = nil
    var itemName: String? = nil
    
    var isConversion: Int? = nil
    var basketValue: String? = nil
    var orderId: String? = nil
    var basket: [PixelBasketItem]? = nil
    
    var group: GroupType? = nil
    var searchTerm: String? = nil
    var typedTerm: String? = nil
    var catId:String? = nil
    var cat:String? = nil
    
    init(type: PixelType, pType: PageType, ref: String, title: String) {
        self.type = type
        self.pType = pType
        self.title = title
        self.ref = ref
    }
    
    init(type: PixelType, pType: PageType, ref: String, title: String, prodId: String, prodName: String, prodSku: String?) {
        self.type = type
        self.pType = pType
        self.title = title
        self.ref = ref
        self.prodId = prodId
        self.prodName = prodName
        self.prodSku = prodSku
    }
    
    init(type: PixelType, pType: PageType, group: GroupType, eType: String, ref: String, title: String, prodId: String, prodName: String, prodSku: String?) {
        self.type = type
        self.pType = pType
        self.group = group
        self.eType = eType
        self.title = title
        self.ref = ref
        self.prodId = prodId
        self.prodName = prodName
        self.prodSku = prodSku
    }
}

public enum PixelType: String {
    case PAGEVIEW = "pageview"
    case EVENT = "event"
}

public enum PageType: String {
    // Any home page or landing page that is considered a home page needs to be classified as
    case HOME_PAGE = "homepage"
    // Any product, product bundle, product collection or sku set pages need to be classified as
    case PRODUCT_PAGE = "product"
    // Any category listing pages, category product listing pages or pages that you consider a category page need to be classified as
    case CATEGORY_PAGE = "category"
    // Any search listing or search results pages need to be classified as
    case SEARCH_PAGE = "search"
    // Any content pages need to be classified as
    case  CONTENT_PAGE = "content"
    // Bloomreach Thematic pages need to be classified as
    case THEMATIC_PAGE = "thematic"
    // Any Conversion/ Thank You pages
    case CONVERSION = "conversion"
    //Any page types that are not one of the above need to be classified as
    case OTHER_PAGE = "other"
}

public enum GroupType: String {
    case CART = "cart"
    case SUGGEST = "suggest"
    case PRODUCT = "product"
    case WIDGET = "widget"
}
