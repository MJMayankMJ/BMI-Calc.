//
//  BMIView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/16/24.

import SwiftUI

struct BMIView: View {
    
    @State var bmi = BMICalculator(height: 0.0, weight: 0.0)
    @State var isHeightMetric = true
    @State var isWeightMetric = true
    @State var isPopoverPresented = false
    @State var isChanged = false
    @State private var isShowingProfileView = false

    var body: some View {
        
        NavigationView {
            ZStack {
                RadialGradient(colors: [
                    .cyan, .black
                ], center: .leading, startRadius: 1000, endRadius: 0)
                .ignoresSafeArea()
                
                VStack {
                    HStack{
                        Spacer()
                        NavigationLink(destination: ProfileView(bmi: bmi), isActive: $isShowingProfileView) {
                            Button(action: {
                                isShowingProfileView = true
                            }) {
                                Text("Go to Profile")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .buttonBorderShape(.capsule)
                            .buttonStyle(.bordered)
                        }
                    }
                    Spacer()
                    
                    if !isChanged {
                        Text("Calculate Your BMI")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    } else if isChanged {
                        Image(systemName: "figure.stand")
                            .font(.system(size: determineHeight(), weight: determineWeight()))
                            .frame(width: 200, height: 200, alignment: .bottom)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    VStack {
                        
                        HStack {
                            Text("Height")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .opacity(0.8)
                            Spacer()
                            Text("\(getHeight(cm: bmi.height, isMetric: isHeightMetric))")
                                .font(Font.system(.largeTitle, design: .rounded).weight(.heavy))
                                .foregroundColor(.white)
                                .onTapGesture { isHeightMetric.toggle() } // tap to change
                        }.padding(.horizontal)
                        
                        Slider(value: $bmi.height, in: 120...220, onEditingChanged: { _ in
                            if self.isChanged == false { self.isChanged = true }
                        })
                        .accentColor(Color.clear)
                            .padding()
                            .onTapGesture { isChanged = true }
                            .onAppear {
                                if(self.bmi.height < 1) {
                                    self.bmi.height = 170
                                }
                            }
                    }
                    
                    VStack {
                        
                        HStack {
                            Text("Weight")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .opacity(0.8)
                            Spacer()
                            Text("\(getWeight(kg: bmi.weight, isMetric: isWeightMetric, indicator: true))")
                                .font(Font.system(.largeTitle, design: .rounded).weight(.heavy))
                                .foregroundColor(.white)
                                .onTapGesture { isWeightMetric.toggle() } // tap to change
                        }.padding(.horizontal)
                        
                        Slider(value: $bmi.weight, in: 20...150, onEditingChanged: { _ in
                            if self.isChanged == false { self.isChanged = true }
                        })
                        .accentColor(Color.clear)
                            .padding()
                            .onAppear {
                                if(self.bmi.weight < 1) {
                                    self.bmi.weight = 85
                                }
                            }
                    }
                    
                    Button{
                        bmi.calculateBMI(height: bmi.height, weight: bmi.weight)
                        self.isPopoverPresented.toggle()
                    }label: {
                        Text("Calculate")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $isPopoverPresented, content: {
                        ResultView(bmi: bmi, isHeightMetric: isHeightMetric, isWeightMetric: isWeightMetric)
                    })
                }.padding()
            }
        }
    }
    
    // Dynamically determine height of symbol based on height slider
    func determineHeight() -> CGFloat {
        return CGFloat(self.bmi.height / 1.2) // fluid transition
    }
    
    // Dynamically determine weight of symbol based on weight slider
    func determineWeight() -> Font.Weight {
        switch self.bmi.weight {
        case 0 ..< 30:
            return .ultraLight
        case 30 ..< 45:
            return .thin
        case 45 ..< 60:
            return .light
        case 60 ..< 75:
            return .regular
        case 75 ..< 90:
            return .medium
        case 90 ..< 105:
            return .semibold
        case 105 ..< 120:
            return .bold
        case 120 ..< 135:
            return .heavy
        default:
            return .black
        }
    }
}



// Get height in centimetres or feet and inches
func getHeight(cm: Float, isMetric: Bool) -> String {
    if isMetric {
        return "\(String(format: "%.0f", cm)) cm"
    } else {
        let feet = cm * 0.0328084
        let feetDisplay = Int(floor(feet))
        let feetRemainder: Float = ((feet * 100).truncatingRemainder(dividingBy: 100) / 100)
        let inches = Int(floor(feetRemainder * 12))
        return "\(feetDisplay)' \(inches)\""
    }
}

// Get weight in kilograms or pounds
func getWeight(kg: Float, isMetric: Bool, indicator: Bool) -> String {
    var weightString: String
    if isMetric {
        weightString = String(format: "%.0f", kg)
        if indicator { weightString += " kg" }
    } else {
        let lbs = kg * 2.205
        weightString = String(format: "%.0f", lbs)
        if indicator { weightString += " lbs" }
    }
    return weightString
}

// MARK: Previews
struct BMIView_Previews: PreviewProvider {
    static var previews: some View {
        BMIView()
            .previewDevice("iPhone 12")
    }
}
