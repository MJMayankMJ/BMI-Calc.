//
//  CapsuleButtonStyle.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/19/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct CapsuleButtonStyle: ButtonStyle {
    var bgColor: Color = .cyan
    var textColor: Color = .white
    var hasBorder: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(bgColor))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .overlay {
                hasBorder ?
                Capsule()
                    .stroke(.gray, lineWidth: 1) :
                nil
            }
    }
}
