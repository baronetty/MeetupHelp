//
//  Previewer.swift
//  MeetupHelp
//
//  Created by Leo  on 25.01.24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let person: Person

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: config)

        
        person = Person(name: "Carolin Franke")

        container.mainContext.insert(person)
    }
}
