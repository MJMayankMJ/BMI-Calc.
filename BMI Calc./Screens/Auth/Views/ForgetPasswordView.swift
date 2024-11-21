//
//  ForgetPasswordView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/20/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            
            RadialGradient(colors: [
                .cyan, .black
            ], center: .leading, startRadius: 1000, endRadius: 0)
            .ignoresSafeArea()

            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Reset Password")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    
                    Text("Enter the email associated with your account and we'll send an email with instructions to reset your password")
                        .font(.subheadline)
                        .foregroundStyle(.white.secondary)
                }.padding(.bottom, 32)
                
                InputView(placeholder: "Enter your email", text: $email)
                    .padding(.bottom, 16)
                
                Button {
                    Task {
                        await authViewModel.resetPassword(by: email)
                        if !authViewModel.isError {
                            router.navigate(to: .emailSent)
                        }
                    }
                } label: {
                    Text("Send Insturctions")
                }
                .buttonStyle(CapsuleButtonStyle())
                
                
                Spacer()
            }
            .padding()
            .toolbarRole(.editor)
            .onAppear {
                email = ""
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
