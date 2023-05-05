//
//  WidgetRequest.swift
//  
//  Widget API Request Object class. Create the object of this class in order to send it with Recommendation Search API
//
//

import Foundation

public class WidgetRequest : RequestMap<WidgetRequest> {
    
    
    public override init() {
        super.init()
        // add default parameters required for search API
        facet(value: false)
    }
    
    /**
     Method to set rows
     - parameters:
     - rows: The number of matching items to return per results page in the API response. The maximum value is 200.
     - returns A reference to the current Request object
     */
    public func rows(rows: Int) -> WidgetRequest {
        return set(key: "rows", value: String(rows))
    }
    
    /**
     Method to set start
     - parameters:
     - start: The number of the first item on a page of results. For example, the first item on the first page is 0, making the start value also 0.
     - returns A reference to the current Request object
     */
    public func start(start: Int) -> WidgetRequest {
        return set(key: "start", value: String(start))
    }
    
    /**
     Method to set itemIds for  Item Based Widget API
     - parameters:
     - value:  Specifies access to a particular set of items. For product catalog, this would be the PID(s).
     - returns A reference to the current Request object
     */
    public func itemIds(value: String) throws -> WidgetRequest {
        if (value.isEmpty) {
            throw BrApiException.EmptyValue(errorMessage: "ItemIds should not be empty")
        }
        return set(key: "item_ids", value: value)
    }
    
    /**
     Method to set itemIds for  Item Based Widget API
     - parameters:
     - values: Array of access to a particular set of items. For product catalog, this would be the PID(s).
     - returns A reference to the current Request object
     */
    public func itemIds(values: [String]) throws -> WidgetRequest {
        var itemId:String = ""
        if (values.count == 1) {
            itemId = values[0]
        } else if (values.count > 1) {
            itemId = values.joined(separator: ",")
        }
        return try itemIds(value: itemId)
    }
    
    /**
     Method to set cat Id for Category Based Widget API
     - parameters:
     - value:  Your site's category ID.
     - returns A reference to the current Request object
     */
    public func catId(value: String) throws -> WidgetRequest {
        if (value.isEmpty) {
            throw BrApiException.EmptyValue(errorMessage: "Category Id should not be empty")
        }
        return set(key: "cat_id", value: value)
    }
    
    /**
     Method to set search query for Keyword and Personalization Based Widget API
     - parameters:
     - value: search query.
     - returns A reference to the current Request object
     */
    public func query(value: String) -> WidgetRequest {
        return set(key: "query", value: value)
    }
    
    /**
     Method to set user id required for Personalization-based Recommendation widgets
     - parameters:
     - value:The universal customer ID of the user.
     - returns A reference to the current Request object
     */
    public func userId(value: String) -> WidgetRequest {
        return set(key: "user_id", value: value)
    }
    
    /**
     Method to set context id Item-based Recommendation widget API
     - parameters:
     - value:takes a single product ID for producing Context-based merchandising results for the widget.
     - returns A reference to the current Request object
     */
    public func contextId(value: String?) -> WidgetRequest {
        return set(key: "context_id", value: value)
    }
    
    /**
     Method to set fields Recommendation widget APIs
     - parameters:
     - value:A formatted comma-separated list of fields to be sent in the request.
     - returns A reference to the current Request object
     */
    public func fields(value: String?) -> WidgetRequest {
        return set(key: "fields", value: value)
    }
    
    /**
     Method to set fields Recommendation widget API
     - parameters:
     - values:Array of fields to be sent in the request.
     - returns A reference to the current Request object
     */
    public func fields(values: [String]?) -> WidgetRequest {
        var fieldString: String? = nil
        if (values == nil) {
            fieldString = nil
        }
        else if (values!.isEmpty) {
            fieldString = nil
        } else if (values!.count == 1) {
            fieldString = values![0]
        } else if (values!.count > 1) {
            fieldString = values?.joined(separator: ",")
        }
        return fields(value: fieldString)
    }
    
    /**
     Method to set filter facet for Keyword and Category Recommendation widget APIs
     - parameters:
     - value:A formatted value to be sent in the request.
     - returns A reference to the current Request object
     */
    public func filterFacet(value: String)-> WidgetRequest {
        return add(key: "filter_facet", value: value)
    }
    
    /**
     Method to set filter facet for Keyword and Category Recommendation widget APIs
     - parameters:
     - attribute:A  filter facet attribute
     - value:value for the given attribute
     - returns A reference to the current Request object
     */
    public func filterFacet(attribute: String, value: String)-> WidgetRequest {
        return filterFacet(value: "\(attribute):\"\(value)\"")
    }
    
    /**
     Method to set filter facet for Keyword and Category Recommendation widget APIs
     - parameters:
     - attribute:A  filter facet attribute
     - value:The array of multiple possible values for given attribute.
     - operator: 'AND' or 'OR' operator for values
     - returns A reference to the current Request object
     */
    public func filterFacet(attribute: String, values: [String], _operator: Operator) -> WidgetRequest {
        var str = "\(attribute):"
        if (values.count > 1) {
            //attribute:"value 1" OR "value 2"
            for (index, value) in values.enumerated() {
                str += "\"\(value)\""
                if (index != values.count - 1) {
                    if (_operator == Operator.OR) {
                        str += " OR "
                    } else if (_operator == Operator.AND) {
                        str += " AND "
                    }
                }
            }
            return filterFacet(value: str)
        } else {
            return filterFacet(attribute: attribute, value: values[0])
        }
    }
    
    /**
     Method to View Id
     - parameters:
     - value: unique identifier for a specific view of your product catalog.
     - returns A reference to the current Request object
     */
    public func viewId(value: String?) -> WidgetRequest {
        return set(key: "view_id", value: value)
    }
    
    /**
     Method to apply facet
     - parameters:
     - value: Boolean value to enable or disable facet filtering
     - returns A reference to the current Request object
     */
    public func facet(value: Bool) -> WidgetRequest {
        return set(key: "facet", value: String(value))
    }
    
    /**
     Method to set filter for Recommendation widget APIs
     - parameters:
     - value: The formatted value for filter
     - returns A reference to the current Request object
     */
    public func filter(value: String) -> WidgetRequest {
        return add(key: "filter", value: value)
    }
    
    /**
     Method to set filter for Recommendation widget APIs
     - parameters:
     - attribute: The filter attribute value
     - value: The formatted value for given  attribute
     - isNot: if '-' is needed at start pass value as true. Default set to false,
     - returns A reference to the current Request object
     */
    public func filter(attribute: String, value: String, isNot: Bool = false) -> WidgetRequest {
        if (isNot) {
            return filter(value: "-(\(attribute):(\"\(value)\"))")
        } else {
            return filter(value: "(\(attribute):(\"\(value)\"))")
        }
    }
    
    /**
     Method to set filter with range for Recommendation widget APIs
     - parameters:
     - attribute: The filter attribute value
     - startRange: The start value for range filter
     - endRange: The end value for range filter
     - isNot: if '-' is needed at start pass value as true. Default set to false,
     - returns A reference to the current Request object
     */
    public func filter(
        attribute: String,
        startRange: String,
        endRange: String,
        isNot: Bool = false
    ) -> WidgetRequest {
        if (isNot) {
            return filter(value: "-(\(attribute):[\"\(startRange)\" TO \"\(endRange)\"])")
        } else {
            return filter(value: "(\(attribute):[\"\(startRange)\" TO \"\(endRange)\"])")
        }
    }
    
    /**
     Method to set filter with range for Recommendation widget APIs
     - parameters:
     - attribute: The filter attribute value
     - startRange: The start value for range filter
     - endRange: The end value for range filter
     - isNot: if '-' is needed at start pass value as true. Default set to false,
     - returns A reference to the current Request object
     */
    public func filter(
        attribute: String,
        startRange: Int,
        endRange: Int,
        isNot: Bool = false
    ) -> WidgetRequest {
        return filter(attribute: attribute, startRange: String(startRange), endRange: String(endRange), isNot: isNot)
    }
    
    /**
     Method to set filter with range for Recommendation widget APIs
     - parameters:
     - attribute: The filter attribute value
     - values: The array of multiple possible values for given attribute.
     - operator: 'AND' or 'OR' operator for values
     - returns A reference to the current Request object
     */
    public func filter(attribute: String, values: [String], _operator: Operator) -> WidgetRequest {
        var str = ""
        if (values.count > 1) {
            //attribute:("value 1" OR "value 2")
            for (index, value) in values.enumerated() {
                str += "\"\(value)\""
                if (index != values.count - 1) {
                    if (_operator == Operator.OR) {
                        str += " OR "
                    } else if (_operator == Operator.AND) {
                        str += " AND "
                    }
                }
            }
        } else {
            str += "\"\(values[0])\""
        }
        
        return add(key: "filter", value: "\(attribute):(\(str))")
    }
    
    /**
     Method to set facetPrefix for Widget APIs. The facet.prefix parameter limits faceting to terms that start with the specified string prefix.
     - parameters:
     - facetName: The name of the facet
     - prefixValue: value for facet prefix
     - returns A reference to the current Request object
     */
    public func facetPrefix(facetName: String, prefixValue: String) -> WidgetRequest {
        return set(key: "facet.prefix", value: "\(facetName):\(prefixValue)")
    }
    
    /**
     Method to set url
     - parameters:
     - value: The absolute URL of the page where the request is initiated. Do not use a relative URL.
     - returns A reference to the current Request object
     */
    public func url(value: String) -> WidgetRequest {
        return set(key: "url", value: value)
    }
}
