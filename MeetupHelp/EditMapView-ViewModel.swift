//
//  EditMapView-ViewModel.swift
//  MeetupHelp
//
//  Created by Leo  on 26.01.24.
//

import Foundation
import SwiftData

extension EditMapView {
    @Observable
    class ViewModel {
        
        private(set) var location: Location
        
        var name: String
        var description: String
        
        
        var onSave: (Location) -> Void
        
        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.location = location
            self.onSave = onSave
            
            _name = location.name // geht auch mit State(initialValue: location.name).wrappedValue
            _description = location.description
        }
        
    }
}
