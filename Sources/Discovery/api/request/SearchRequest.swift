//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

public class SearchRequest<T>: RequestMap<T> {
    
    public override init() {
        super.init()
        rows(rows: 10)
        start(start: 0)
    }
    
    
    public func rows(rows: Int) -> T {
        return set(key: "rows", value: String(rows))
    }
    
    public func start(start: Int) -> T {
        return set(key: "rows", value: String(start))
    }
    
    public func searchTerm(q: String) -> T {
        return set(key: "q", value: q)
    }
    
    public func fl(value: String) -> T {
        if(value.isEmpty) {
            // throw
        }
        return set(key: "fl", value: value)
    }
    
    public func fl(values: [String]) -> T {
        var flStr = ""
        if(values.isEmpty) {
            //throw
        } else if (values.count == 1) {
            flStr =  values[0]
        } else if (values.count > 1) {
            flStr = values.joined(separator: ",")
        }
        
        return fl(value: flStr)
    }
    
    public func sort(value: String?) -> T {
        return set(key: "sort", value: value)
    }
    
    public func sort(values: [String]) -> T {
        var sortStr: String? = nil
        if(values.isEmpty) {
            //throw
        } else if (values.count == 1) {
            sortStr =  values[0]
        } else if (values.count > 1) {
            sortStr = values.joined(separator: ",")
        }
        return sort(value: sortStr)
    }
    
    /**
     * Method to set facetPrefix for Search APIs.
     * The facet.prefix parameter limits faceting to terms that start with the specified string prefix.
     *
     * @param facetName The name of the facet
     * @param prefixValue value for facet prefix
     *
     * @return  A reference to the current Request object
     */
    
    public func facetPrefix(facetName: String, prefixValue: String)  -> T {
        let key = "f.\(facetName).facet.prefix"
        return set(key: key, value: prefixValue)
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
    public func facetPrefixWidget(facetName: String, prefixValue: String) -> T {
        return set(key: "facet.prefix", value: "\(facetName):\(prefixValue)")
    }
    
    /**
     * Method to set fq
     *  The fq parameter is an optional parameter that you can add to an API request to filter the results.
     *
     * @param value The formatted value to be passed to fq parameter
     *
     * @return  A reference to the current Request object
     */
    public func fq(value: String) -> T {
        return add(key: "fq", value: value)
    }
    
    /**
     * Method to set fq with attribute and its single value
     * The fq parameter is an optional parameter that you can add to an API request to filter the results.
     *
     * @param attribute The attribute for fq
     * @param value The value of the attribute
     *
     * @return  A reference to the current Request object
     */
    public func fq(attribute: String, value: String) -> T {
        let fqValue = "$attribute:\"\(value)\""
        return fq(value: fqValue)
    }
    
    /**
     * Method to set fq with attribute and its multiple value
     * The fq parameter is an optional parameter that you can add to an API request to filter the results.
     *
     * @param attribute The attribute for fq
     * @param values The list of multiple possible values for given attribute.
     *
     * @return  A reference to the current Request object
     */
    public func fq(attribute: String, values: [String]) -> T {
        var str = ""
        if (values.count > 1) {
            for (index, value) in values.enumerated() {
                str += "\"\(value)\""
                if (index != values.count - 1) {
                    str += " OR "
                }
            }
        } else {
            str += values[0]
        }
        return fq(attribute: attribute, value: str)
    }
    
    /**
     * Method to set stats.field
     * The stats.field allows you to display the maximum and minimum values of any numeric field in your data set for a user query.
     *
     * @param value The formatted stats.field value
     *
     * @return  A reference to the current Request object
     */
    public func statsField(value: String?) -> T {
        return set(key: "stats.field", value: value)
    }
    
    public func statsField(values: [String]) -> T {
        var sfString: String? = nil
        if (values.isEmpty) {
            sfString = nil
        } else if (values.count == 1) {
            sfString = values[0]
        } else if (values.count > 1) {
            sfString = values.joined(separator: ",")
        }
        return statsField(value: sfString)
    }
    
    public func efq(value: String) -> T {
        return set(key: "efq", value: value)
    }
    
    public func efq(attribute: String, value: String) -> T {
        return efq(value: "\(attribute):(\"\(value)\")")
    }
    
    public func efq(attribute: String, value: String, isNot: Bool) -> T {
        if(isNot) {
            return efq(value: "-\(attribute):(\"\(value)\")")
        } else {
            return efq(value: "\(attribute):(\"\(value)\")")
        }
    }
    
    /**
     * Method to set efq with attribute and its multiple values
     *
     * @param attribute The attribute for efq
     * @param values The list of multiple possible values for given attribute.
     * @param operator 'AND' or 'OR' operator for values
     *
     * @return  A reference to the current Request object
     */
    public func efq(attribute: String, values: [String], _operator: Operator) -> T {
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
            str += values[0]
        }
        return efq(attribute: attribute, value: str)
    }
    
    /**
     * Method to set efq with multiple attribute and  values
     *
     * @param values The map of multiple possible attributes and its values.
     * @param operator 'AND' or 'OR' operator for attributes
     *
     * @return  A reference to the current Request object
     */
    //TODO
//    public func efq(values: [String: String], operator: Operator) -> T {
//        var formattedStr = ""
//        //attribute1:("value") OR attribute2:("value")
//        if (values.count > 1) {
//            formattedStr = if (operator == Operator.OR) {
//                values.entries.stream()
//                    .map { e -> "${e.key}:(\"${e.value}\")" }
//                    .collect(Collectors.joining(" OR "))
//            } else {
//                values.entries.stream()
//                    .map { e -> "${e.key}:(\"${e.value}\")" }
//                    .collect(Collectors.joining(" AND "))
//            }
//        }
//        return efq(formattedStr)
//    }
    
    /**
     * Method to set facet.range parameter
     * Use the facet.range parameter to include ranged facets
     *
     * @param value value for the facet range
     *
     * @return  A reference to the current Request object
     */
    public func facetRange(value: String?) -> T {
        return set(key: "facet.range", value: value)
    }
    
    /**
     * Method to set list of facet.range parameter
     * Use the facet.range parameter to include ranged facets
     *
     * @param values list for the facet range
     *
     * @return  A reference to the current Request object
     */
    public func facetRange(values: [String]) -> T {
        var frString: String? = nil
        if (values.isEmpty) {
            frString = nil
        } else if (values.count == 1) {
            frString = values[0]
        } else if (values.count > 1) {
            frString = values.joined(separator: ",")
        }
        return facetRange(value: frString)
    }
    
    /**
     * BOPIS-specific parameter to specify the end-customer's latitude-longitude.
     *
     * @param value value for lat long in format 'lat,long'
     *
     * @return  A reference to the current Request object
     */
    public func latLong(value: String?) -> T {
        return set(key: "ll", value: value)
    }
    
    /**
     * Method to set View Id
     *
     * @param value A unique identifier for a specific view of your product catalog.
     *
     * @return  A reference to the current Request object
     */
    public func viewId(value: String?) -> T {
        return set(key: "view_id", value: value)
    }
    
    /**
     * Method to set user id of the customer
     *
     * @param value The universal customer ID of the user.
     *
     * @return  A reference to the current Request object
     */
    public func userId(value: String?) -> T {
        return set(key: "user_id", value: value)
    }
    
    /**
     * Method to set widget Id, The widget_id provided in the Dashboard for the Dynamic Widgets
     * feature, which is used to provided curated results.
     *
     * @param value value for widget id
     *
     * @return  A reference to the current Request object
     */
    public func widgetId(value: String?) -> T {
        return set(key: "widget_id", value: value)
    }
    
    
    /**
     * Method to set title
     *
     * @param value The title or name of the product.
     *
     * @return  A reference to the current Request object
     */
    public func title(value: String?) -> T {
        return set(key: "title", value: value)
    }
    
    
    /**
     * Method to set url
     *
     * @param value The title or name of the product.
     *
     * @return  A reference to the current Request object
     */
    public func url(value: String) -> T {
        return set(key: "url", value: value)
    }
    
}
