//
//  MapView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/24.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, interactionModes: .all, showsUserLocation: true)
            .tint(Color(.systemPink))
            .onAppear {
                viewModel.checkIfLocationServiceEnabled()
            }
    }
}

class MapViewModel: NSObject, ObservableObject {
    
    var locationManager: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914),
        span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    func checkIfLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            // Show an alert letting them know location service if off
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Location service is restricted")
            case .denied:
                print("Location service is denied")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(
                    center: locationManager.location!.coordinate,
                    span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            @unknown default:
                break
        }
    }
    
    
}

extension MapViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
