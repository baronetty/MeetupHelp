//
//  MapView.swift
//  MeetupHelp
//
//  Created by Leo  on 26.01.24.
//

import MapKit
import SwiftData
import SwiftUI

struct MapView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 54.5, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    let locationFetcher = MapView.ViewModel.LocationFetcher()
    
    @State private var viewModel = ViewModel()
    @State private var region: MKCoordinateRegion?
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(initialPosition: position) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(.standard())
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditMapView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
            }
            
            HStack {
                
                Spacer()
                
                Button("Start Tracking Location") {
                    locationFetcher.start()
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                
                Spacer()
                
                Button("Read Location") {
                    if let location = locationFetcher.lastKnownLocation {
                        position = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                            )
                        )
                        print("Your location is \(location)")
                    } else {
                        print("Your location is unknown")
                    }
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                
                Spacer()
                
            }
            
        }
    }
}

#Preview {
    MapView()
}
