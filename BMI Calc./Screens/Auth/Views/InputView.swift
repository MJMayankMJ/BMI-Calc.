//
//  InoutView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/19/24.

import SwiftUI

struct InputView: View {
    let placeholder: String
    var isSecureField: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 12) {
//            if isSecureField {
//                SecureField(text: $text) {
//                    Text(placeholder)
//                        .foregroundStyle(.white.opacity(0.7))
//                }
//                .foregroundStyle(.white)
//            }else {
                TextField(text: $text) {
                    Text(placeholder)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .foregroundStyle(.white)
            }
            
            Divider().background(.white)
        }
    }
//}

#Preview {
    ZStack {
        RadialGradient(colors: [
            .cyan, .black
        ], center: .leading, startRadius: 1000, endRadius: 0)
        .ignoresSafeArea()
        InputView(
            placeholder: "Email or Phone number",
            text: .constant("")
        )
    }
}
