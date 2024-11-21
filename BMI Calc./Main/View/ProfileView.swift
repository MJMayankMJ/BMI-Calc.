//
//  ProfileView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/20/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var profiles: [UserProfile] = []
    @State private var isShowingAddProfile = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    var bmi: BMICalculator
    
    var body: some View {
        NavigationView {
            
            ZStack {
                RadialGradient(colors: [
                    .cyan, .black
                ], center: .leading, startRadius: 1000, endRadius: 0)
                .ignoresSafeArea()
                
                List {
                    
                    ForEach(profiles) { profile in
                        HStack(spacing: 16) {
                            Text(profile.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 70, height: 70)
                                .background(Color(.lightGray))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(profile.name)
                                    .foregroundStyle(.white)
                                    .font(.title2.bold())
                                    .fontWeight(.semibold)
                                
                                Text(profile.gender)
                                    .foregroundStyle(.cyan)
                                    .font(.headline)
                            }
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.clear)
                    Section() {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            Label {
                                Text("Sign Out")
                                    .foregroundStyle(.white)
                            } icon: {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        Button {
                            Task {
                                await authViewModel.deleteAccount()
                            }
                        } label: {
                            Label {
                                Text("Delete Account")
                                    .foregroundStyle(.white)
                            } icon: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                        
                    }
                    .listRowBackground(Color.clear)
                    
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("User Profiles")
                .navigationBarItems(trailing: Button(action: {
                    isShowingAddProfile = true
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $isShowingAddProfile) {
                    AddProfileView(profiles: $profiles)
                }
            }
        }
        .onAppear() {
            let user = UserProfile(name: "Mayank Jangid", gender: "Male")
            profiles.append(user)
        }
    }
    
}

#Preview {
    ProfileView(bmi: BMICalculator())
        .environmentObject(AuthViewModel())
}
