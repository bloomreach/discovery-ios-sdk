//
//  PixelBasketItem.swift
//  
//  Class containing product details for the purchase.
//

import Foundation

public class PixelBasketItem {
    
    let prodId: String
    let name: String
    var sku: String? = nil
    let quantity: String
    let price: String
    
    public init(prodId: String, name: String, sku: String?, quantity: String, price: String) {
        self.prodId = prodId
        self.name = name
        self.sku = sku
        self.quantity = quantity
        self.price = price
    }
}
