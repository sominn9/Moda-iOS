//
//  CustomButton.swift
//  Moda
//
//  Created by 신소민 on 2021/12/21.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    
    var colorName: String
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color(colorName))
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .medium))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }

}

struct CustomButtonView: View {
    var body: some View {
        Button("Stop") {
            
        }
        .padding([.leading, .trailing], 20)
        .buttonStyle(CustomButton(colorName: "ColorRed"))
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView()
    }
}
