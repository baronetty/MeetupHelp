//
//  EditMapView.swift
//  MeetupHelp
//
//  Created by Leo  on 26.01.24.
//

import SwiftData
import SwiftUI

struct EditMapView: View {
    @State private var viewModel: ViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
            // Create a State instance for viewModel
            _viewModel = State(initialValue: ViewModel(location: location, onSave: onSave))
        }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Description", text: $viewModel.description)
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    viewModel.onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
    
    
    
    
}

#Preview {
    EditMapView(location: .example) { _ in }
}
