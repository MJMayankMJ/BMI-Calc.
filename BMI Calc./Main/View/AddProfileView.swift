//
//  AddProfileView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/20/24.
//

import SwiftUI

import SwiftUI

struct AddProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var profiles: [UserProfile]
    @State private var name: String = ""
    @State private var gender: String = "Male"
    let genderOptions = ["Male", "Female", "Other"]
    var body: some View {
        
        NavigationView {
            ZStack {
                RadialGradient(colors: [
                    .cyan, .black
                ], center: .leading, startRadius: 1000, endRadius: 0)
                .ignoresSafeArea()
                
                Form {
                    Section(header: Text("Profile Details").foregroundStyle(.white.opacity(0.8))) {
                        TextField(text: $name) {
                            Text("Name").foregroundStyle(.white.opacity(0.8))
                        }
                        .foregroundStyle(.white)
                        Picker("Gender", selection: $gender) {
                            ForEach(genderOptions, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Add Profile")
                .navigationBarItems(leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: Button("Save") {
                    let newProfile = UserProfile(name: name, gender: gender)
                    profiles.append(newProfile)
                    presentationMode.wrappedValue.dismiss()
                })
            }
            
        }
    }
}

#Preview {
    AddProfileView( profiles: .constant([]))
}
