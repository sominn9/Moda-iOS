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
