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
        if let source = viewModel.points.first, let destination = viewModel.points.last {
            // Set the region
            let region = MKCoordinateRegion(
                center: destination,
                span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            view.setRegion(region, animated: true)
            
            // Set the annotation
            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.coordinate = source
            sourceAnnotation.title = "출발지"
            
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.coordinate = destination
            destinationAnnotation.title = "도착지"
            
            view.removeAnnotations(view.annotations)
            view.showAnnotations([destinationAnnotation, sourceAnnotation], animated: true)
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
