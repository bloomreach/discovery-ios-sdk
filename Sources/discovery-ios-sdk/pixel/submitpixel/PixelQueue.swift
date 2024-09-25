//
//  PixelQueue.swift
//  
//
//  PixelQueue class to hold pixels query parameter map to be sent to PIXEL API
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
        elements.removeFirst()
        delegate?.elementRemoved()
        return nil
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
