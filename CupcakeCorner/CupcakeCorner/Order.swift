//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dany Blais Benoit on 2025-01-14.
//

import Foundation

@Observable class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = UserDefaults.standard.string(forKey: "name") ?? "" {
        didSet {
            UserDefaults.standard.set(name, forKey: "name" )
        }
    }
    
    var streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? "" {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        }
    }
    
    var city = UserDefaults.standard.string(forKey: "city") ?? "" {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }
    
    var zip = UserDefaults.standard.string(forKey: "zip") ?? "" {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }
    
    var hasValidAddress: Bool {
        if name.filter({ !$0.isWhitespace }).isEmpty ||
        streetAddress.filter({ !$0.isWhitespace }).isEmpty ||
        city.filter({ !$0.isWhitespace }).isEmpty ||
        zip.filter({ !$0.isWhitespace }).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var cost: Decimal {
        // 2$ per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // 0.50$/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
