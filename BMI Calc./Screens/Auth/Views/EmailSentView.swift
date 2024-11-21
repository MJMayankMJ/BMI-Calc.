//
//  EmailSentView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/20/24.
//

import SwiftUI

struct EmailSentView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            
            RadialGradient(colors: [
                .cyan, .black
            ], center: .leading, startRadius: 1000, endRadius: 0)
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()
                
                Image(systemName: "envelope.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.teal)
                
                VStack(spacing: 8) {
                    Text("Check your email")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    
                    Text("We have sent a password recover instructions to your email.")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.secondary)
                }
                
                Button {
                    router.navigateToRoot()
                } label: {
                    Text("Skip, I'll confirm later")
                }
                .buttonStyle(CapsuleButtonStyle())
                
                Spacer()
                
                Button {
                    router.navigateBack()
                } label: {
                    (Text("Did not receive the email? Check your spam filter, or ")
                        .foregroundColor(.gray)
                     +
                     Text("try another email address")
                        .foregroundColor(.cyan))
                }
            }
            .padding()
            .toolbarRole(.editor)
        }
    }
}

#Preview {
    EmailSentView()
}
