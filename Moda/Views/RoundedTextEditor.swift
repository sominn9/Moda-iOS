//
//  RoundedTextEditor.swift
//  Moda
//
//  Created by 신소민 on 2021/12/28.
//

import SwiftUI

struct RoundedTextEditor: View {
    
    @Binding var memo: String
    
    var body: some View {
        ZStack {
            TextEditor(text: $memo)
                .frame(minHeight: 90)
                .foregroundColor(memo == "메모를 입력하세요" ? .gray : .primary)
                .disableAutocorrection(true)
                .padding(5)
                .overlay(
                     RoundedRectangle(cornerRadius: 15)
                       .stroke(Color.secondary, lineWidth: 2)
                )
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    if self.memo == "" {
                        self.memo = "메모를 입력하세요"
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    if self.memo == "메모를 입력하세요" {
                        self.memo = ""
                    }
                }
      
            Text(memo).opacity(0).padding(.all, 8)
                .onAppear {
                    if memo == "" {
                        memo = "메모를 입력하세요"
                    }
                }
        }
    }
}
