//
//  LoginView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/19/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            
            RadialGradient(colors: [
                .cyan, .black
            ], center: .leading, startRadius: 1000, endRadius: 0)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    Spacer().frame(height: 80)
                    // title
                    titleView
                    
                    Spacer().frame(height: 50)
                    
                    // textfields
                    InputView(
                        placeholder: "Email or Phone number",
                        text: $email
                    )
                    
                    InputView(
                        placeholder: "Password",
                        isSecureField: true,
                        text: $password
                    )
                    // forgot button
                    forgotButton
                    
                    // login button
                    loginButton
                    
                    Spacer()
                    
                    // bottom view
                    bottomView
                }
            }
            .ignoresSafeArea()
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        //note that this alert is going to be presented on create user as well cz we pass the authViewModel from Environment rather that creating new one ... so whenever isError becomes true alert is presented onTop of the screen which is currently there
        .alert("Something went wrong", isPresented: $authViewModel.isError) {}
    }
    
    private var titleView: some View {
        Text("Let's Connect!")
            .foregroundStyle(.white)
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    private var forgotButton: some View {
        HStack {
            Spacer()
            Button {
                router.navigate(to: .forgotPassword)
            } label: {
                Text("Forgot Password?")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
    }
    
    private var loginButton: some View  {
        Button {
            Task {
                await authViewModel.login(email: email, password: password)
            }
        } label: {
            Text("Login")
        }
        .buttonStyle(CapsuleButtonStyle())
    }
    
    private var line: some View {
        VStack {
            Divider().frame(height: 1)
                .background(.gray)
        }
    }
    
    private var bottomView: some View {
        VStack(spacing: 16) {
            lineorView
            appleButton
            googleButton
            footerView
        }
    }
    
    private var lineorView: some View {
        HStack(spacing: 16) {
            line
            Text("or")
                .fontWeight(.semibold)
            line
        }
        .foregroundStyle(.gray)
    }
    
    private var appleButton: some View {
        Button {
            
        } label: {
            Label("Sign up with Apple", systemImage: "apple.logo")
        }
        .buttonStyle(
            CapsuleButtonStyle(
                bgColor: .black
            )
        )
    }
    
    private var googleButton: some View {
        Button {
            
        } label: {
            HStack {
                Image("google")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text("Sign up with Google")
            }
        }
        .buttonStyle(
            CapsuleButtonStyle(
                bgColor: .clear,
                textColor: .white,
                hasBorder: true
            )
        )
    }
    
    private var footerView: some View {
        Button {
            router.navigate(to: .createAccount)
        } label: {
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(.white)
                Text("Sign Up")
                    .foregroundStyle(.cyan)
            }
            .fontWeight(.medium)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
