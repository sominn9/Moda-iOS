//
//  ResultView.swift
//  Moda
//
//  Created by 신소민 on 2021/12/20.
//

import SwiftUI
import MapKit

struct ResultView: View {
    
    @Binding var pushed: Bool
    
    var body: some View {
        VStack {
            // MARK: - UP
            ZStack {
                Color("ColorRed")
                    .ignoresSafeArea()
                
                VStack {
                    
                }
            }
            
            // MARK: - DOWN
            VStack {
                // Map
                MapView()
                
                // Button
                Button("저장하기") {
                    self.pushed = false
                }
                .buttonStyle(CustomButton())
            }.padding(.horizontal, 10)
            
        } //: VSTACK
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(pushed: .constant(true))
    }
}
