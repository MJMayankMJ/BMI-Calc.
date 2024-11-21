//
//  ContentView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/20/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            }else {
                BMIView()
            }
        }
        .environmentObject(authViewModel)
    }
}

#Preview {
    ContentView()
}
