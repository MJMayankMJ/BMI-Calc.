//
//  WeightedChartView.swift
//  BMI Calc.
//
//  Created by Mayank Jangid on 11/18/24.
//

import SwiftUI
import Charts

struct WeightLineChartView: View {
    var weightData: [Double] // Array of weight values
    var dates: [Date]  // Corresponding dates for the weight values
    
 

    var body: some View {
        let minWeight = (weightData.min() ?? 0) - 5
        let maxWeight = (weightData.max() ?? 0) + 5
        Chart {
            ForEach(0..<weightData.count, id: \.self) { index in
                LineMark(
                    x: .value("Date", dates[index]),
                    y: .value("Weight", weightData[index])
                )
                .foregroundStyle(.cyan)
            }
        }
        .chartXAxis {
                    AxisMarks(values: .stride(by: .day)) {
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                            .foregroundStyle(.white)
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) {
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                            .foregroundStyle(.white)
                    }
                }
                .chartYScale(domain: minWeight...maxWeight)
                .padding(.vertical, 10)
    }
}
