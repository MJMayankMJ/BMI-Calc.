//
//  DetailView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/16/24.

import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var bmi: BMICalculator
    @State var isHeightMetric = true
    @State var isWeightMetric = true
    
    // Example weight data and dates for the last 7 days
        let weightData: [Double] = [75, 76, 76, 76, 75, 77, 78] // Replace with actual data
        let dates: [Date] = [
            Date().addingTimeInterval(-6*24*60*60),
            Date().addingTimeInterval(-5*24*60*60),
            Date().addingTimeInterval(-4*24*60*60),
            Date().addingTimeInterval(-3*24*60*60),
            Date().addingTimeInterval(-2*24*60*60),
            Date().addingTimeInterval(-1*24*60*60),
            Date()
        ] // Replace with actual dates
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                RadialGradient(colors: [
                    .cyan, .black
                ], center: .leading, startRadius: 1000, endRadius: 0)
                .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    // Dismiss button
                    HStack {
                        Spacer()
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "x.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .opacity(0.5)
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: Heading
                    VStack(alignment: .leading) {
                        
                        Text("Your Weight History")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        WeightLineChartView(weightData: weightData, dates: dates)
                                                .frame(height: 150)
                        HStack {
                            
                            Spacer()
                            
                            // MARK: BMI Column
                            VStack {
                                Image(systemName: "figure.stand")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .opacity(0.5)
                                Text("BMI")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\(bmi.getBMIValue())")
                                    .font(.title3)
                                    .foregroundColor(Color(getColor()))
                            }
                            
                            Spacer()
                            
                            // MARK: Height Column
                            VStack {
                                Image(systemName: "arrow.up.and.down")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .opacity(0.5)
                                Text("HEIGHT")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\(getHeight(cm: bmi.height, isMetric: isHeightMetric))")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                            .onTapGesture { isHeightMetric.toggle() }
                            
                            Spacer()
                            
                            // MARK: Weight Column
                            VStack {
                                Image(systemName: "scalemass")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .opacity(0.5)
                                Text("WEIGHT")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\(getWeight(kg: bmi.weight, isMetric: isWeightMetric, indicator: true))")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                            .onTapGesture { isWeightMetric.toggle() }
                            
                            Spacer()
                        }.padding(.vertical)
                    }
                    
                    Spacer()
                    Spacer()
                }.padding(.all, 30)
            }
        }
    }
    
    // Prevent black-on-black text based on BMI classification
    func getColor() -> UIColor {
        var color = bmi.getColor()
        if color == .black { color = .white }
        return color
    }
}

// MARK: Previews
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(bmi: BMICalculator(height: 120.0, weight: 150.0))
            .previewDevice("iPhone 12")
    }
}
