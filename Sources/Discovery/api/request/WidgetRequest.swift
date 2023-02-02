//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

public class WidgetRequest : RequestMap<WidgetRequest> {
    
    
    public override init() {
        super.init()
        facet(value: false)
    }
    
    /**
         * Method to set rows
         *
         * @param rows The number of matching items to return per results page in the API response. The maximum value is 200.
         *
         * @return  A reference to the current Request object
         */
        func rows(rows: Int) -> WidgetRequest {
            return set(key: "rows", value: String(rows))
        }

        /**
         * Method to set start
         *
         * @param start The number of the first item on a page of results. For example, the first item on the first page is 0, making the start value also 0.
         *
         * @return  A reference to the current Request object
         */
    func start(start: Int) -> WidgetRequest {
        return set(key: "start", value: String(start))
        }

        /**
         * Method to set itemIds for  Item Based Widget API
         *
         * @param value  Specifies access to a particular set of items. For product catalog, this would be the PID(s).
         *
         * @return  A reference of Request object
         */
    func itemIds(value: String) -> WidgetRequest {
//            if (value.isEmpty()) {
//                throw IllegalArgumentException("ItemIds can't be empty")
//            }
        return set(key: "item_ids", value: value)
        }

        /**
         * Method to set itemIds for  Item Based Widget API
         *
         * @param values Array of access to a particular set of items. For product catalog, this would be the PID(s).
         *
         * @return  A reference to the current Request object
         */
        func itemIds(values: [String]) -> WidgetRequest {
            var itemId:String = ""
//            if (values.isEmpty) {
//                //throw IllegalArgumentException()
//            } else
            if (values.count == 1) {
                itemId = values[0]
            } else if (values.count > 1) {
                itemId = values.joined(separator: ",")
            }
            return itemIds(value: itemId)
        }

        /**
         * Method to set cat Id for Category Based Widget API
         *
         * @param value Your site's category ID.
         *
         * @return  A reference of Request object
         */
        func catId(value: String) -> WidgetRequest {
//            if (value.isEmpty()) {
//                throw IllegalArgumentException("Category Id can't be empty")
//            }
            return set(key: "cat_id", value: value)
        }

        /**
         * Method to set search query for Keyword and Personalization Based Widget API
         *
         * @param value  search query.
         *
         * @return  A reference of Request object
         */
        func query(value: String) -> WidgetRequest {
//            if (value.isEmpty()) {
//                throw IllegalArgumentException("Search query Id can't be empty")
//            }
            return set(key: "query", value: value)
        }

        /**
         * Method to set user id required for Personalization-based Recommendation widgets
         *
         * @param value  The universal customer ID of the user.
         *
         * @return  A reference of Request object
         */
        func userId(value: String) -> WidgetRequest {
//            if (value.isEmpty()) {
//                throw IllegalArgumentException("User Id can't be empty")
//            }
            return set(key: "user_id", value: value)
        }

        /**
         * Method to set context id Item-based Recommendation widget API
         *
         * @param value takes a single product ID for producing Context-based merchandising results for the widget.
         *
         * @return  A reference of Request object
         */
    func contextId(value: String?) -> WidgetRequest {
        return set(key: "context_id", value: value)
        }

        /**
         * Method to set fields Recommendation widget APIs
         *
         * @param value A formatted comma-separated list of fields to be sent in the request.
         *
         * @return  A reference of Request object
         */
    func fields(value: String?) -> WidgetRequest {
        return set(key: "fields", value: value)
        }

        /**
         * Method to set fields Recommendation widget API
         *
         * @param values  List of fields to be sent in the request.
         *
         * @return  A reference of Request object
         */
    func fields(values: [String]?) -> WidgetRequest {
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
         * Method to set filter facet for Keyword and Category Recommendation widget APIs
         *
         * @param value A formatted value to be sent in the request.
         *
         * @return  A reference of Request object
         */
    func filterFacet(value: String)-> WidgetRequest {
        return add(key: "filter_facet", value: value)
        }

        /**
         * Method to set filter facet for Keyword and Category Recommendation widget APIs
         *
         * @param attribute filter facet attribute
         * @param value value for the given attribute
         *
         * @return  A reference of Request object
         */
    func filterFacet(attribute: String, value: String)-> WidgetRequest {
        return filterFacet(value: "\(attribute):\"\(value)\"")
        }

        /**
         * Method to set filter facet for Keyword and Category Recommendation widget APIs
         *
         * @param attribute filter facet attribute
         * @param values The list of multiple possible values for given attribute.
         * @param operator 'AND' or 'OR' operator for values
         *
         * @return  A reference of Request object
         */
    func filterFacet(attribute: String, values: [String], _operator: Operator) -> WidgetRequest {
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
         * Method to View Id
         *
         * @param value A unique identifier for a specific view of your product catalog.
         *
         * @return  A reference of Request object
         */
    func viewId(value: String?) -> WidgetRequest {
        return set(key: "view_id", value: value)
        }

        /**
         * Method to apply facet
         *
         * @param value Boolean value to enable or disable facet filtering
         *
         * @return  A reference of Request object
         */
    func facet(value: Bool) -> WidgetRequest {
        return set(key: "facet", value: String(value))
        }

        /**
         * Method to set filter for Recommendation widget APIs
         *
         * @param value The formatted value for given
         *
         * @return  A reference of Request object
         */
    func filter(value: String) -> WidgetRequest {
        return add(key: "filter", value: value)
        }

        /**
         * Method to set filter for Recommendation widget APIs
         *
         * @param attribute filter attribute value
         * @param value The formatted value for given  attribute
         * @param isNot if '-' is needed at start pass value as true. Default set to false,
         *
         * @return  A reference of Request object
         */
    func filter(attribute: String, value: String, isNot: Bool = false) -> WidgetRequest {
            if (isNot) {
                return filter(value: "-(\(attribute):(\"\(value)\"))")
            } else {
                return filter(value: "(\(attribute):(\"\(value)\"))")
            }
        }

        /**
         * Method to set filter with range for Recommendation widget APIs
         *
         * @param attribute filter attribute value
         * @param startRange The start value for range filter
         * @param endRange The end value for range filter
         * @param isNot if '-' is needed at start pass value as true. Default set to false,
         *
         * @return  A reference of Request object
         */
    func filter(
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
         * Method to set filter with range for Recommendation widget APIs
         *
         * @param attribute filter attribute value
         * @param startRange The start value for range filter
         * @param endRange The end value for range filter
         * @param isNot if '-' is needed at start pass value as true. Default set to false,
         *
         * @return  A reference of Request object
         */
    func filter(
            attribute: String,
            startRange: Int,
            endRange: Int,
            isNot: Bool = false
        ) -> WidgetRequest {
            return filter(attribute: attribute, startRange: String(startRange), endRange: String(endRange), isNot: isNot)
        }

        /**
         * Method to set filter with range for Recommendation widget APIs
         *
         * @param attribute filter attribute value
         * @param range The range(0..100) value for range filter
         * @param isNot if '-' is needed at start pass value as true. Default set to false,
         *
         * @return  A reference of Request object
         */
//        fun filter(attribute: String, range: IntRange, isNot: Boolean = false): WidgetRequest {
//            return filter(attribute, range.first.toString(), range.last.toString(), isNot)
//        }

        /**
         * Method to set filter with attribute and its multiple values
         *
         * @param attribute The attribute for filter
         * @param values The list of multiple possible values for given attribute.
         * @param operator 'AND' or 'OR' operator for values
         *
         * @return  A reference to the current Request object
         */
    func filter(attribute: String, values: [String], _operator: Operator) -> WidgetRequest {
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
         * Method to set facetPrefix for Widget APIs
         * The facet.prefix parameter limits faceting to terms that start with the specified string prefix.
         *
         * @param facetName The name of the facet
         * @param prefixValue value for facet prefix
         *
         * @return  A reference to the current Request object
         */
    func facetPrefix(facetName: String, prefixValue: String) -> WidgetRequest {
        return set(key: "facet.prefix", value: "\(facetName):\(prefixValue)")
        }

        /**
         * Method to set url
         *
         * @param value The absolute URL of the page where the request is initiated. Do not use a relative URL.
         *
         * @return  A reference to the current Request object
         */
    func url(value: String) -> WidgetRequest {
        return set(key: "url", value: value)
        }
}
