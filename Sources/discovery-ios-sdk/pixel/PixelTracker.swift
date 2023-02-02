//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

public class PixelTracker {
    
    static public let shared = PixelTracker()
    
    //Initializer access level private
    private init(){}
    /**
     Method for sending the Page View Pixel
     - parameters:
     - ref: Synthetic URL from referrer screen
     - title: Screen name of the app view.
     */
    public func pageViewPixel(ref: String, title: String) {
        
        print("Pixel Tracker pageViewPixel")
        
    }
}
