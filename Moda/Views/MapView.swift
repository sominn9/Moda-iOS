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
    
    @StateObject private var viewModel = MapViewModel()
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        // Create MKMapView and configure it
        let mapView = MKMapView()
        let region = MKCoordinateRegion(
            center: viewModel.source,
            span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        mapView.setRegion(region, animated: true)
        mapView.delegate = context.coordinator

        // Request permission
        viewModel.checkIfLocationServiceEnabled()
        
        drawRoute(mapView)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        drawRoute(view)
    }
    
    private func drawRoute(_ view: MKMapView) {
        // Set the source and destination
        let source = MKPlacemark(
            coordinate: viewModel.source
        )

        let destination = MKPlacemark(
            coordinate: viewModel.destination
        )
        
        // Create MKDirections.Request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: source)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .walking

        // Create MKDirections
        let directions = MKDirections(request:  request)
        
        // Calculate path and draw it
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            view.addAnnotations([source, destination])
            view.addOverlay(route.polyline)
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


