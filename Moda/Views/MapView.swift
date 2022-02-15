//
//  MapView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/24.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    @ObservedObject var viewModel: MapViewModel
        
    private let startLocationService: Bool
    private let userInteractionEnabled: Bool
    
    init(viewModel: MapViewModel, startLocationService: Bool, userInteractionEnabled: Bool = true) {
        self.viewModel = viewModel
        self.startLocationService = startLocationService
        self.userInteractionEnabled = userInteractionEnabled
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        // Create MKMapView and configure it
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.tintColor = .systemPink
        mapView.overrideUserInterfaceStyle = .dark
        
        if startLocationService {
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(.follow, animated: true)
            
            // Request permission
            viewModel.checkIfLocationServiceEnabled()
        }
        
        if !userInteractionEnabled {
            mapView.isUserInteractionEnabled = false
        }
        
        drawRoute(mapView)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        drawRoute(view)
    }
    
    private func drawRoute(_ view: MKMapView) {
  
        if let destination = viewModel.points.last {
            // Set the region
            let region = MKCoordinateRegion(
                center: destination,
                span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            view.setRegion(region, animated: true)
        }
        
        if viewModel.points.count != 0 {
            let geodesic = MKGeodesicPolyline(coordinates: viewModel.points, count: viewModel.points.count)
            view.addOverlay(geodesic)
        }
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemPink
            renderer.lineWidth = 5
            return renderer
        }
    }
    
}
