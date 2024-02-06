//
//  PixelTracker.swift
//  PixelTracker Singleton class holds all types of Page view and Event Pixels methods
//

import Foundation

public class PixelTracker {
    
    static public let shared = PixelTracker()
    
    //Initializer access level private
    private init(){}
    public var brPixel: BrPixel? = nil
    private let pixelProcessor: PixelProcessor = PixelProcessor()
    
    /**
     Initialise Pixel tracker with BrPixel object
     - parameters:
     - brPixel: BrPixel object defined for initialisation
     */
    public func intialise(brPixel: BrPixel) {
        self.brPixel = brPixel
    }
    
    /**
     Method for sending the Page View Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     */
    public func pageViewPixel(ref: String, title: String) {
        if (brPixel != nil) {
            // create pixel object based on input
            let pixelObject = PixelObject(type: PixelType.PAGEVIEW,
                                          pType: PageType.HOME_PAGE,
                                          ref: ref,
                                          title: title
            )
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Product Page View Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - prodId: Screen name of the app view.
     - prodName: Screen name of the app view.
     - sku: Screen name of the app view.
     */
    public func productPageViewPixel(
        ref: String,
        title: String,
        prodId: String,
        prodName: String,
        sku: String? = nil
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.PAGEVIEW, pType: PageType.PRODUCT_PAGE,
                ref: ref, title: title, prodId: prodId, prodName: prodName, prodSku: sku
            )
            
            //                 send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Content Page View Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - catalogs: List of CatalogItem that are shown in the page. In case the page has multiple tabs, only the catalogs of the selected (and visualized) tabs should be included.If multiple catalogs are shown in the active page (or tab) all of them should be included.
     - itemId: Unique ID of the item being shown in the page. This identifier should match the item_id as specified in the content feed.
     - itemName: Name or the title of the content page.
     */
    public func contentPageViewPixel(
        ref: String,
        title: String,
        catalogs: [CatalogItem],
        itemId: String,
        itemName: String
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.PAGEVIEW,
                pType: PageType.CONTENT_PAGE,
                ref: ref,
                title: title
            )
            pixelObject.itemId = itemId
            pixelObject.itemName = itemName
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Content Search Page View Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - catalogs: List of CatalogItem that are shown in the page.
     - searchTerm: The value of the search query describing the page.
     */
    public func contentSearchPageViewPixel(
        ref: String,
        title: String,
        catalogs: [CatalogItem],
        searchTerm: String
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.PAGEVIEW,
                pType: PageType.SEARCH_PAGE,
                ref: ref,
                title: title
            )
            pixelObject.catalogs = catalogs
            pixelObject.searchTerm = searchTerm
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Category Search Page View Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - categoryId: Unique category ID as referred to in the database/catalog. Bloomreach requires the cat_id field to be unique across your site.
     - category: The bread crumb of the page. Value needs to match the crumb value in your feed. eg: "Home|Clothing|Outerwear"
     */
    public func categoryPageViewPixel(
        ref: String,
        title: String,
        category: String,
        categoryId: String
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.PAGEVIEW,
                pType: PageType.CATEGORY_PAGE,
                ref: ref,
                title: title
            )
            pixelObject.cat = category
            pixelObject.catId = categoryId
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Search Result Page View Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - searchTerm: The value of the search query describing the page.
     */
    public func searchResultPageViewPixel(ref: String, title: String, searchTerm: String) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.PAGEVIEW,
                pType: PageType.SEARCH_PAGE,
                ref: ref,
                title: title
            )
            pixelObject.searchTerm = searchTerm
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Conversion Page View Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - isConversion: Set to true to indicate this is a Conversion or Thank you page
     - basketValue: The total price of the checkout basket including tax, discounts, shipping and/or discounts in the account currency.
     - orderId: The order ID associated with the order placed
     - basket: List of the PixelBasketItem objects (Products purchased).
     */
    public func conversionPageView(
        ref: String,
        title: String,
        isConversion: Bool,
        basketValue: String,
        orderId: String,
        basket: [PixelBasketItem]
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.PAGEVIEW,
                pType: PageType.CONVERSION,
                ref: ref,
                title: title
            )
            
            pixelObject.isConversion = isConversion ? 1 : 0
            pixelObject.basketValue = basketValue
            pixelObject.orderId = orderId
            pixelObject.basket = basket
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    //==================== EVENT PIXELS =======================
    
    
    /**
     Method for sending the Add To Cart Event Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - prodId: This is the unique ID which describes a product or product collection.
     - prodName: The name of the product being viewed.
     - sku: Unique sku ID that represents the selected variant of this product. If your site does not have SKUs, leave this blank.
     - prodCollectionId: (Optional) When a product is added to cart from a Product Collection page, set prod_collection_id as the id of the collection.
     No need to set prod_collection_id param in the ATC event pixel when a product is added to cart from its own page, independent of any Product Collection it is part of.
     */
    public func addToCartEventPixel(
        ref: String,
        title: String,
        prodId: String,
        prodName: String,
        sku: String,
        prodCollectionId: String? = nil
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.EVENT,
                pType: PageType.PRODUCT_PAGE,
                group: GroupType.CART,
                eType: "click-add",
                ref: ref,
                title: title,
                prodId: prodId,
                prodName: prodName,
                prodSku: sku
            )
            
            pixelObject.prodCollectionId = prodCollectionId
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Search Event Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - searchTerm: The value of the search query describing the page.
     - catalogs: Array of CatalogItem that are shown in the page.
     */
    public func searchEventPixel(
        ref: String,
        title: String,
        searchTerm: String,
        catalogs: [CatalogItem]? = nil
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.EVENT,
                pType: PageType.PRODUCT_PAGE,
                group: GroupType.SUGGEST,
                eType: "submit",
                ref: ref,
                title: title
            )
            
            pixelObject.searchTerm = searchTerm
            pixelObject.catalogs = catalogs
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Search Event Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - prodId: This is the unique ID which describes a product or product collection.
     - prodName: The name of the product being viewed.
     - sku: Unique sku ID that represents the selected variant of this product. If your site does not have SKUs, leave this blank.
     - searchTerm: The value of the search query describing the page.
     - catalogs: Array of CatalogItem that are shown in the page.
     */
    @available(*, deprecated, message: "This function will be removed in future version. Instead use searchEventPixel(ref, title, searchTerm, catalogs)")
    public func searchEventPixel(
        ref: String,
        title: String,
        prodId: String,
        prodName: String,
        sku: String,
        searchTerm: String,
        catalogs: [CatalogItem]? = nil
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.EVENT,
                pType: PageType.PRODUCT_PAGE,
                group: GroupType.SUGGEST,
                eType: "submit",
                ref: ref,
                title: title,
                prodId: prodId,
                prodName: prodName,
                prodSku: sku
            )
            
            pixelObject.searchTerm = searchTerm
            pixelObject.catalogs = catalogs
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Suggestion Event Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - typedTerm: The display query (the one or more letters) that the user has actually typed.  This is NOT the suggested word or phrase.
     - searchTerm: The value of the search query describing the page.
     - catalogs: Array of CatalogItem that are shown in the page.
     */
    public func suggestionEventPixel(
        ref: String,
        title: String,
        typedTerm: String,
        searchTerm: String,
        catalogs: [CatalogItem]? = nil
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.EVENT,
                pType: PageType.PRODUCT_PAGE,
                group: GroupType.SUGGEST,
                eType: "click",
                ref: ref,
                title: title
            )
            
            pixelObject.typedTerm = typedTerm
            pixelObject.searchTerm = searchTerm
            pixelObject.catalogs = catalogs
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Suggestion Event Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - prodId: This is the unique ID which describes a product or product collection.
     - prodName: The name of the product being viewed.
     - sku: Unique sku ID that represents the selected variant of this product. If your site does not have SKUs, leave this blank.
     - typedTerm: The display query (the one or more letters) that the user has actually typed.  This is NOT the suggested word or phrase.
     - searchTerm: The value of the search query describing the page.
     - catalogs: Array of CatalogItem that are shown in the page.
     */
    @available(*, deprecated, message: "This function will be removed in future version. Instead use suggestionEventPixel(ref, title, typedTerm, searchTerm, catalogs)")
    public func suggestionEventPixel(
        ref: String,
        title: String,
        prodId: String,
        prodName: String,
        sku: String,
        typedTerm: String,
        searchTerm: String,
        catalogs: [CatalogItem]? = nil
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.EVENT,
                pType: PageType.PRODUCT_PAGE,
                group: GroupType.SUGGEST,
                eType: "click",
                ref: ref,
                title: title,
                prodId: prodId,
                prodName: prodName,
                prodSku: sku
            )
            
            pixelObject.typedTerm = typedTerm
            pixelObject.searchTerm = searchTerm
            pixelObject.catalogs = catalogs
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Quick Event Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - prodId: This is the unique ID which describes a product or product collection.
     - prodName: The name of the product being viewed.
     - sku: Unique sku ID that represents the selected variant of this product. If your site does not have SKUs, leave this blank.
     */
    public func quickViewEventPixel(
        ref: String,
        title: String,
        prodId: String,
        prodName: String,
        sku: String
    ) {
        if (brPixel != nil) {
            // create pixel object based ob input
            let pixelObject = PixelObject(
                type: PixelType.EVENT,
                pType: PageType.PRODUCT_PAGE,
                group: GroupType.PRODUCT,
                eType: "quickview",
                ref: ref,
                title: title,
                prodId: prodId,
                prodName: prodName,
                prodSku: sku
            )
            
            // send pixel for further processing
            pixelProcessor.processPixel(pixelObject: pixelObject)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Custom Event Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     - eType: Event type
     - pType: Maps your site's page type classifications to the values Bloomreach expects for our page type classifications.
     - group: Specifies the event grouping
     - params: Map for custom keys and its associated values
     */
    public func customEventPixel(
        ref: String,
        title: String,
        eType: String,
        pType: PageType,
        group: GroupType,
        params: inout [String: String?]
    ) {
        if (brPixel != nil) {
            // directly add map to the PixelQueue
            params["ref"] = ref
            params["title"] = title
            params["type"] = PixelType.EVENT.rawValue
            params["etype"] = eType
            params["ptype"] = pType.rawValue
            params["group"] = group.rawValue
            pixelProcessor.processPixel(queryMap: &params)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    //==================== WIDGET PIXELS =======================
    
    /**
     Method for sending the Widget View Pixel
     - parameters:
     - widgetDataWrId: The unique ID of the response. This value has to be populated from the API response metadata.widget.rid.
     - widgetViewDataWq: The query string used by the customer which returns a widget suggestion. This is optional for non-query widgets.
     - widgetViewDataWid: The widget ID. This is a unique, 6 character alphanumeric value. This value has to be populated from the API response metadata.widget.id.
     - widgetViewDataWty: The type of recommendation widget. This value has to be populated from the API response.This value has to be populated from the API response                       metadata.widget.type.
     */
    public func widgetView(
        widgetDataWrId: String,
        widgetViewDataWq: String,
        widgetViewDataWid: String,
        widgetViewDataWty: String
    ) {
        if (brPixel != nil) {
            var params: [String: String?] = [:]
            params["type"] = PixelType.EVENT.rawValue
            params["group"] = GroupType.WIDGET.rawValue
            params["etype"] = "widget-view"
            params["wrid"] = widgetDataWrId
            params["wq"] = widgetViewDataWq
            params["wid"] = widgetViewDataWid
            params["wty"] = widgetViewDataWty
            pixelProcessor.processPixel(queryMap: &params)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the Widget Click Pixel
     - parameters:
     - widgetDataWrId: The unique ID of the response. This value has to be populated from the API response metadata.widget.rid.
     - widgetViewDataWq: The query string used by the customer which returns a widget suggestion. This is optional for non-query widgets.
     - widgetViewDataWid: The widget ID. This is a unique, 6 character alphanumeric value. This value has to be populated from the API response metadata.widget.id.
     - widgetViewDataWty: The type of recommendation widget. This value has to be populated from the API response.This value has to be populated from the API response                       metadata.widget.type.
     - widgetDataItemId: The unique ID (PID) of the clicked product. The PID is used from the API call.
     */
    public func widgetClick(
        widgetDataWrId: String,
        widgetViewDataWq: String,
        widgetViewDataWid: String,
        widgetViewDataWty: String,
        widgetDataItemId: String
    ) {
        if (brPixel != nil) {
            var params: [String: String?] = [:]
            params["type"] = PixelType.EVENT.rawValue
            params["group"] = GroupType.WIDGET.rawValue
            
            params["etype"] = "widget-click"
            params["ptype"] = PageType.OTHER_PAGE.rawValue
            params["item_id"] = widgetDataItemId
            params["wrid"] = widgetDataWrId
            params["wq"] = widgetViewDataWq
            params["wid"] = widgetViewDataWid
            params["wty"] = widgetViewDataWty
            pixelProcessor.processPixel(queryMap: &params)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
    
    /**
     Method for sending the  Widget Add to cart
     - parameters:
     - widgetDataWrId: The unique ID of the response. This value has to be populated from the API response metadata.widget.rid.
     - widgetViewDataWq: The query string used by the customer which returns a widget suggestion. This is optional for non-query widgets.
     - widgetViewDataWid: The widget ID. This is a unique, 6 character alphanumeric value. This value has to be populated from the API response metadata.widget.id.
     - widgetViewDataWty: The type of recommendation widget. This value has to be populated from the API response.This value has to be populated from the API response                       metadata.widget.type.
     - widgetDataItemId: The unique ID (PID) of the clicked product. The PID is used from the API call.
     - widgetAtcDataSku: Unique SKU id that represents the selected variant of this product (e.g. size M, color blue of a t-shirt). If your site does not have SKUs, leave this blank.
     */
    public func widgetAddToCart(
        widgetDataWrId: String,
        widgetViewDataWq: String,
        widgetViewDataWid: String,
        widgetViewDataWty: String,
        widgetDataItemId: String,
        widgetAtcDataSku: String
    ) {
        if (brPixel != nil) {
            var params: [String: String?] = [:]
            params["type"] = PixelType.EVENT.rawValue
            params["group"] = GroupType.CART.rawValue
            
            params["etype"] = "widget-add"
            params["item_id"] = widgetDataItemId
            params["wrid"] = widgetDataWrId
            params["wid"] = widgetViewDataWid
            params["wq"] = widgetViewDataWq
            params["wty"] = widgetViewDataWty
            params["sku"] = widgetAtcDataSku
            pixelProcessor.processPixel(queryMap: &params)
            
        } else {
            print("Pixel Tracker not initialised")
        }
    }
}
