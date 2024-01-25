//
//  Person.swift
//  MeetupHelp
//
//  Created by Leo  on 25.01.24.
//

import Foundation
import SwiftData

@Model
class Person {
    var name: String
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}
