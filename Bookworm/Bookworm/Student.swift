//
//  Student.swift
//  Bookworm
//
//  Created by Dany Blais Benoit on 2025-01-18.
//

import Foundation
import SwiftData

@Model class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
