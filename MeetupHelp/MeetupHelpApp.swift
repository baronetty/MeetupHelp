//
//  MeetupHelpApp.swift
//  MeetupHelp
//
//  Created by Leo  on 25.01.24.
//

import SwiftData
import SwiftUI

@main
struct MeetupHelpApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
