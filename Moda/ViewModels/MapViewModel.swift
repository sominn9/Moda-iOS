//
//  MapViewModel.swift
//  Moda
//
//  Created by 신소민 on 2021/12/26.
//

import MapKit

class MapViewModel: NSObject, ObservableObject {
    
    var locationManager: CLLocationManager?
    
    @Published var points: [CLLocationCoordinate2D]
    
    init(with points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()) {
        self.points = points
    }

    func checkIfLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.activityType = .fitness
            locationManager?.allowsBackgroundLocationUpdates = true
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
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
            break
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
            points.append(lastLocation.coordinate)
        }
    }
    
}
