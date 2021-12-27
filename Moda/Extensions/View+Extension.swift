//
//  View+Extension.swift
//  Moda
//
//  Created by 신소민 on 2021/12/28.
//

import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
