//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

class PixelQueue {
    
    static public var shared = PixelQueue()
    
    //Initializer access level private
    private init(){}
    
    private var elements: [[String:String?]] = []
    weak var delegate: QueueChanged?
    
     func enqueue(value: [String:String?]) {
        elements.append(value)
        delegate?.elementAdded()
      }

     func dequeue() -> [String:String?]? {
        guard !elements.isEmpty else {
          return nil
        }
        return elements.removeFirst()
//          delegate?.elementRemoved()
      }

     func head() -> [String:String?]? {
          guard !elements.isEmpty else {
              return nil
          }
        return elements.first
      }

      var tail: [String:String?]? {
        return elements.last
      }
}

protocol QueueChanged: AnyObject {
       func elementAdded()
       func elementRemoved()
  }
