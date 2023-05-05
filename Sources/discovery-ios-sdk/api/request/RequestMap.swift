//
//  RequestMap.swift
//  RequestMap class base class for all Request class, which stores the parameters in the Dict
//
//

import Foundation

public class RequestMap<T> {
    
    private var requestMap = [String: Any?]()
    
    /**
     Method to set query parameter as key and value. If the key key is already set, the value will get replaced
     - parameters:
     - key: internal object which holds data for fields required to generate query parameter String
     - value: The value that is used for the query parameter value. If the value is <pre>null</pre> the key will be removed
     - returns A reference to the current Request object
     */
    public func set(key: String, value: String?) -> T {
        
        if(value != nil && !value!.isEmpty) {
            requestMap[key] = value
        } else {
            requestMap.removeValue(forKey: key)
        }
        return self as! T
    }
    
    /**
     Method to add multiple query parameter for same key
     - parameters:
     - key: internal object which holds data for fields required to generate query parameter String
     - value: The value that is used for the query parameter value. If the value is <pre>null</pre> the key will be removed
     - returns A reference to the current Request object
     */
    public func add(key: String, value: String?) -> T {
        if(value != nil && !value!.isEmpty) {
            
            if let val = requestMap[key] {
                
                if(val is [String]) {
                    //(val as! [String]).append(value) //TODO
                    requestMap[key] = val
                } else if (val is String) {
                    var list = [String]()
                    list.append(val as! String)
                    list.append(value!)
                    requestMap[key] = list
                }
                
            } else {
                requestMap[key] = value
            }
            
        } else {
            requestMap.removeValue(forKey: key)
        }
        return self as! T
        
    }
    
    /**
     Method to get Request Map object
     - returns A reference request Dict object
     */
    public func getMap() -> [String: Any?] {
        return requestMap
    }
    
}
