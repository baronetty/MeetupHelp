//
//  MapView-ViewModel.swift
//  MeetupHelp
//
//  Created by Leo  on 26.01.24.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit
import SwiftData


extension MapView { // so it's the ViewModel for MapView
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlace")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "Here I met...", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        class LocationFetcher: NSObject, CLLocationManagerDelegate {
            let manager = CLLocationManager()
            var lastKnownLocation: CLLocationCoordinate2D?

            override init() {
                super.init()
                manager.delegate = self
            }

            func start() {
                manager.requestWhenInUseAuthorization()
                manager.startUpdatingLocation()
            }

            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                lastKnownLocation = locations.first?.coordinate
            }
        }
    }
}

