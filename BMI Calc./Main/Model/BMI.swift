//
//  BMI.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/16/24.
//

import SwiftUI

struct BMI {
    let classification: WeightClass
    let value: Float
    let advice: String
    let symbol: String
    let color: UIColor
}

enum WeightClass {
    case underweight
    case healthy
    case overweight
    case obese
    case extremelyObese
    case unknown
}
