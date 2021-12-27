//
//  MenuButton.swift
//  Moda
//
//  Created by 신소민 on 2021/12/20.
//

import SwiftUI

struct MenuButton: View {
    
    @State var menuIcon: String?
    @State var menuTitle: String?
    
    var body: some View {
        Button {
            
        } label: {
            if let menuIcon = menuIcon, let menuTitle = menuTitle {
                VStack {
                    Image(menuIcon)
                        .font(.system(size: 80, weight: .ultraLight))
                        .tint(.primary)
                    Text(menuTitle)
                        .font(.system(size: 17))
                        .fontWeight(.light)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton()
    }
}
