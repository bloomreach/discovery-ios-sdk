//
//  SearchRequest.swift
//  This class is base class for Search APIs request it provides parameters to be sent with Search APIs
//
//

import Foundation

public class SearchRequest<T>: RequestMap<T> {
    
    // add default parameters required for search API
    public override init() {
        super.init()
        rows(rows: 10)
        start(start: 0)
    }
    
    /**
     Method to set rows Search APIs
     - parameters:
     - rows: The number of matching items to return per results page in the API response. The maximum value is 200.
     - returns A reference to the current Request object
     */
    @discardableResult public func rows(rows: Int) -> T {
        return set(key: "rows", value: String(rows))
    }
    
    /**
     Method to set start Search APIs
     - parameters:
     - start: The number of the first item on a page of results. For example, the first item on the first page is 0, making the start value also 0.
     - returns A reference to the current Request object
     */
    @discardableResult public func start(start: Int) -> T {
        return set(key: "start", value: String(start))
    }
    
    /**
     Method to set search term for Search APIs
     - parameters:
     - q: Query key for Searching
     - returns A reference to the current Request object
     */
    public func searchTerm(q: String) -> T {
        return set(key: "q", value: q)
    }
    
    /**
     Method to set Field List for Search APIs
     - parameters:
     - value: The comma separated attributes that you want returned in your API response, such as product IDs and prices.
     - returns A reference to the current Request object
     */
    public func fl(value: String) throws -> T {
        if(value.isEmpty) {
            throw BrApiException.EmptyValue(errorMessage: "FL should not be empty")
        }
        return set(key: "fl", value: value)
    }
    
    /**
     Method to set Field List for Search APIs
     - parameters:
     - values: The attributes array that you want returned in your API response, such as product IDs and prices.
     - returns A reference to the current Request object
     */
    public func fl(values: [String]) throws -> T {
        var flStr = ""
        if(values.isEmpty) {
            throw BrApiException.EmptyValue(errorMessage: "FL should not be empty")
        } else if (values.count == 1) {
            flStr =  values[0]
        } else if (values.count > 1) {
            flStr = values.joined(separator: ",")
        }
        
        return try fl(value: flStr)
    }
    
    /**
     Method to set sort parameter. You can alter the sequence in which products are displayed by passing the sort parameter.
     - parameters:
     - value: Formatted value for sort parameter. 'price+asc'
     - returns A reference to the current Request object
     */
    public func sort(value: String?) -> T {
        let newSortValue = value?.replacingOccurrences(of: "+", with: " ")
        return set(key: "sort", value: newSortValue)
    }
    
    /**
     Method to set sort parameter. You can alter the sequence in which products are displayed by passing the sort parameter.
     - parameters:
     - values:  Array of sort string
     - returns A reference to the current Request object
     */
    public func sort(values: [String]) -> T {
        var sortStr: String? = nil
        if(values.isEmpty) {
            sortStr = nil
        } else if (values.count == 1) {
            sortStr =  values[0]
        } else if (values.count > 1) {
            sortStr = values.joined(separator: ",")
        }
        return sort(value: sortStr)
    }
    
    /**
     Method to set facetPrefix for Search APIs. The facet.prefix parameter limits faceting to terms that start with the specified string prefix.
     - parameters:
     - facetName: The name of the facet
     - prefixValue: Value for facet prefix
     - returns A reference to the current Request object
     */
    public func facetPrefix(facetName: String, prefixValue: String)  -> T {
        let key = "f.\(facetName).facet.prefix"
        return set(key: key, value: prefixValue)
    }
    
    /**
     Method to set facetPrefix for Widget APIs. The facet.prefix parameter limits faceting to terms that start with the specified string prefix.
     - parameters:
     - facetName: The name of the facet
     - prefixValue: Value for facet prefix
     - returns A reference to the current Request object
     */
    public func facetPrefixWidget(facetName: String, prefixValue: String) -> T {
        return set(key: "facet.prefix", value: "\(facetName):\(prefixValue)")
    }
    
    /**
     Method to set fq
     - parameters:
     - value: The formatted value to be passed to fq parameter
     - returns A reference to the current Request object
     */
    public func fq(value: String) -> T {
        return add(key: "fq", value: value)
    }
    
    /**
     Method to set fq with attribute and its single value. The fq parameter is an optional parameter that you can add to an API request to filter the results.
     - parameters:
     - attribute: The attribute for fq
     - value:  The value of the attribute
     - returns A reference to the current Request object
     */
    public func fq(attribute: String, value: String) -> T {
        let fqValue = "\(attribute):\"\(value)\""
        return fq(value: fqValue)
    }
    
    /**
     Method to set fq with attribute and its multiple value. The fq parameter is an optional parameter that you can add to an API request to filter the results.
     - parameters:
     - attribute: The attribute for fq
     - values: The array of multiple possible values for given attribute.
     - returns A reference to the current Request object
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
     Method to set stats.field. The stats.field allows you to display the maximum and minimum values of any numeric field in your data set for a user query.
     - parameters:
     - value: The formatted stats.field value
     - returns A reference to the current Request object
     */
    public func statsField(value: String?) -> T {
        return set(key: "stats.field", value: value)
    }
    
    /**
     Method to set stats.field. The stats.field allows you to display the maximum and minimum values of any numeric field in your data set for a user query.
     - parameters:
     - values: The array stats.field value
     - returns A reference to the current Request object
     */
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
    
    /**
     Method to set  efq
     - parameters:
     - value: The formatted efq value
     - returns A reference to the current Request object
     */
    public func efq(value: String) -> T {
        return set(key: "efq", value: value)
    }
    
    /**
     Method to set  efq
     - parameters:
     - attribute: The formatted efq attribute
     - value: The formatted efq value for attribute
     - returns A reference to the current Request object
     */
    public func efq(attribute: String, value: String) -> T {
        return efq(value: "\(attribute):(\"\(value)\")")
    }
    
    /**
     Method to set  efq
     - parameters:
     - attribute: The formatted efq attribute
     - value: The formatted efq value for attribute
     - isNot: NOT operator
     - returns A reference to the current Request object
     */
    public func efq(attribute: String, value: String, isNot: Bool) -> T {
        if(isNot) {
            return efq(value: "-\(attribute):(\"\(value)\")")
        } else {
            return efq(value: "\(attribute):(\"\(value)\")")
        }
    }
    
    /**
     Method to set efq with attribute and its multiple values
     - parameters:
     - attribute: The attribute for efq
     - value: The array of multiple possible values for given attribute.
     - operator: 'AND' or 'OR' operator for values
     - returns A reference to the current Request object
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
     Method to set efq with multiple attribute and  values
     - parameters:
     - values:  The dict of multiple possible attributes and its values.
     - operator: 'AND' or 'OR' operator for values
     - returns A reference to the current Request object
     */
    public func efq(values: [String: String], _operator: Operator) -> T {
        var formattedStr = ""
        //attribute1:("value") OR attribute2:("value")
        if (values.count > 1) {
            if (_operator == Operator.OR) {
                formattedStr = values.map { $0.0 + ":(" + $0.1 + ")"}.joined(separator: " OR ")
            } else {
                formattedStr = values.map { $0.0 + ":(" + $0.1 + ")"}.joined(separator: " AND ")
            }
        }
        return efq(value: formattedStr)
    }
    
    /**
     Method to set facet.range parameter. Use the facet.range parameter to include ranged facets
     - parameters:
     - value:  The dict of multiple possible attributes and its values.
     - returns A reference to the current Request object
     */
    public func facetRange(value: String?) -> T {
        return set(key: "facet.range", value: value)
    }
    
    /**
     Method to set facet.range parameter. Use the facet.range parameter to include ranged facets
     - parameters:
     - values: Array for the facet range
     - returns A reference to the current Request object
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
     BOPIS-specific parameter to specify the end-customer's latitude-longitude.
     - parameters:
     - value: value for lat long in format 'lat,long'
     - returns A reference to the current Request object
     */
    public func latLong(value: String?) -> T {
        return set(key: "ll", value: value)
    }
    
    /**
     Method to set View Id
     - parameters:
     - value: A unique identifier for a specific view of your product catalog.
     - returns A reference to the current Request object
     */
    public func viewId(value: String?) -> T {
        return set(key: "view_id", value: value)
    }
    
    /**
     Method to set user id of the customer
     - parameters:
     - value: The universal customer ID of the user.
     - returns A reference to the current Request object
     */
    public func userId(value: String?) -> T {
        return set(key: "user_id", value: value)
    }
    
    /**
     Method to set widget Id, The widget_id provided in the Dashboard for the Dynamic Widgets feature, which is used to provided curated results.
     - parameters:
     - value: value for widget id
     - returns A reference to the current Request object
     */
    public func widgetId(value: String?) -> T {
        return set(key: "widget_id", value: value)
    }
    
    /**
     Method to set title
     - parameters:
     - value: The title or name of the product.
     - returns A reference to the current Request object
     */
    public func title(value: String?) -> T {
        return set(key: "title", value: value)
    }
    
    /**
     Method to set url
     - parameters:
     - value: The title or name of the product.
     - returns A reference to the current Request object
     */
    public func url(value: String) -> T {
        return set(key: "url", value: value)
    }
    
    /**
     Method to set Facet Version
     - parameters:
     - value: facet version eg: '3.0'
     - returns A reference to the current Request object
     */
    public func facetVersion(value: String) -> T {
        return set(key: "facet.version", value: value)
    }
    
    /**
     Method to set Hard Boost
     - parameters:
     - value: Value for Hard Boost eg: pid:“pid1” OR “pid2”
     - returns A reference to the current Request object
     */
    public func hardBoost(value: String) -> T {
        return set(key: "boost", value: value)
    }
    
    /**
     Method to set Hard Bury
     - parameters:
     - value: Value for Hard Bury eg: pid:“pid1” OR “pid2”
     - returns A reference to the current Request object
     */
    public func hardBury(value: String) -> T {
        return set(key: "bury", value: value)
    }
    
    /**
     Method to set LOCK POSITION
     - parameters:
     - value: Value for lock eg: pid:”pid1”#3 OR ”pid2”#10
     - returns A reference to the current Request object
     */
    public func lock(value: String) -> T {
        return set(key: "lock", value: value)
    }
    
    /**
     Method to set Add To Recall
     - parameters:
     - value: Value for add_to_recall eg: pid:“pid1” OR “pid2”
     - returns A reference to the current Request object
     */
    public func addToRecall(value: String) -> T {
        return set(key: "add_to_recall", value: value)
    }
    
    /**
     Method to set Soft Boost
     - parameters:
     - value: Value for soft_boost eg: ”brand”:”Brand1” OR “Brand2”
     - returns A reference to the current Request object
     */
    public func softBoost(value: String) -> T {
        return set(key: "soft_boost", value: value)
    }
    
    /**
     Method to set Soft Bury
     - parameters:
     - value: Value for soft_bury eg: ”brand”:”Brand1” OR “Brand2”
     - returns A reference to the current Request object
     */
    public func softBury(value: String) -> T {
        return set(key: "soft_bury", value: value)
    }
    
    /**
     Method to set include
     - parameters:
     - value: Value for include eg: ”brand”:”Brand1” OR “Brand2”
     - returns A reference to the current Request object
     */
    public func include(value: String) -> T {
        return set(key: "include", value: value)
    }
    
    /**
     Method to set exclude
     - parameters:
     - value: Value for exclude eg: ”brand”:”Brand1” OR “Brand2”
     - returns A reference to the current Request object
     */
    public func exclude(value: String) -> T {
        return set(key: "exclude", value: value)
    }
    
    /**
     Method to set Loomi Search+ API Controls
     - parameters:
     - value: Value for ENUM of type SearchMode. HYBRID for Loomi Search+ mode or STANDARD for Keyword search mode
     - returns A reference to the current Request object
     */
    public func searchMode(value: SearchMode) -> T {
        return set(key: "query.search_mode", value: value.rawValue)
    }
    
    /**
     Method to set Vector Search Temperature
     - parameters:
     - value: Value for ENUM of type VectorSearchTemperature. STANDARD For a wider recall or HIGH For a compact and very precise recall
     - returns A reference to the current Request object
     */
    public func vectorSearchTemperature(value: VectorSearchTemperature) -> T {
        return set(key: "vector_search.temperature", value: value.rawValue)
    }
}

/**
 SearchMode TYPE ENUM to specify which type Search Mode Loomi Search or Keyword based search
 This gets added as API parameter to the request
 */
public enum SearchMode : String {
    case HYBRID = "hybrid" //Apply Loomi Search+ mode
    case STANDARD = "standard" //Apply Keyword search mode
}

/**
 API Controls for adjusting Vector search temperature values for one or all queries.
 This gets added as API parameter to the request
 */
public enum VectorSearchTemperature : String {
    case HIGH = "high"   //  For a compact and very precise recall
    case STANDARD = "standard"    //For a wider recall,
}
