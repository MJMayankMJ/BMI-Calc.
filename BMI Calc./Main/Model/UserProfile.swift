//
//  UserProfile.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/21/24.
//

import Foundation

struct UserProfile: Identifiable {
    let id = UUID()
    var name: String
    var gender: String
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    //var bmi : BMI
}
