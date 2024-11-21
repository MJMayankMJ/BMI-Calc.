//
//  BMI_Calc_App.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/16/24.
//
import SwiftUI
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FirebaseAuthYoutubeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
    @ObservedObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: Router.AuthFlow.self) { destination in
                        switch destination {
                        case .login: LoginView()
                        case .createAccount: CreateAccountView()
                        case .profile: ProfileView(bmi: BMICalculator())
                        case .forgotPassword: ForgotPasswordView()
                        case .emailSent: EmailSentView()
                        }
                    }
            }
            .environmentObject(authViewModel)
            .environmentObject(router)
        }
    }
}
