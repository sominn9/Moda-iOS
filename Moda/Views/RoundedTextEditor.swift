//
//  RoundedTextEditor.swift
//  Moda
//
//  Created by 신소민 on 2021/12/28.
//

import SwiftUI

struct RoundedTextEditor: View {
    
    @State var text: String
    
    var body: some View {
        ZStack {
            TextEditor(text: $text)
                .frame(minHeight: 90)
                .foregroundColor(text == "메모를 입력하세요" ? .gray : .primary)
                .disableAutocorrection(true)
                .padding(5)
                .overlay(
                     RoundedRectangle(cornerRadius: 15)
                       .stroke(Color.secondary, lineWidth: 2)
                )
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    if self.text == "" {
                        self.text = "메모를 입력하세요"
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    if self.text == "메모를 입력하세요" {
                        self.text = ""
                    }
                }
      
            Text(text).opacity(0).padding(.all, 8)
                .onAppear {
                    if text == "" {
                        text = "메모를 입력하세요" 
                    }
                }
        }
    }
}

struct RoundedTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        RoundedTextEditor(text: "")
    }
}
