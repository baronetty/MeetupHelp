//
//  EditPersonView.swift
//  MeetupHelp
//
//  Created by Leo  on 25.01.24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditPersonView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var person: Person
    @Binding var navigationPath: NavigationPath
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var isPromptPresented = false
    
    var body: some View {
        Form {
            Section {
                if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                if person.name.isEmpty {
                    isPromptPresented = true
                }
            }
            .alert(isPresented: $isPromptPresented) {
                Alert(
                    title: Text("Enter Name"),
                    message: Text("Please enter a name for the photo"),
                    primaryButton: .default(Text("OK")),
                    secondaryButton: .cancel()
                )
            }
            
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
            }
            
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedItem) {
            loadPhoto()
        }
    }
    
    
    
    func loadPhoto() {
        Task { @MainActor in
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return EditPersonView(person: previewer.person, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
