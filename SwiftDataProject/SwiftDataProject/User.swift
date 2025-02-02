//
//  User.swift
//  SwiftDataProject
//
//  Created by Dany Blais Benoit on 2025-02-02.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
