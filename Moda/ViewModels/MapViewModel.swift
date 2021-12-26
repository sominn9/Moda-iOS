//
//  MapViewModel.swift
//  Moda
//
//  Created by 신소민 on 2021/12/26.
//

import MapKit

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
            locationManager?.allowsBackgroundLocationUpdates = true
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startMonitoringSignificantLocationChanges()
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

// MARK: - Location Manager Delegate
extension MapViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            region.center = CLLocationCoordinate2D(
                latitude: lastLocation.coordinate.latitude,
                longitude: lastLocation.coordinate.longitude)
        }
    }
    
}
