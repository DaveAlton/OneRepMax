//
//  OneRepMaxChart.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-06.
//

import SwiftUI
import Charts

struct OneRepMaxChart: View {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter
    }()
    var calculation: Calculation?
    var history: [HistoryItem]

    var oneRepMax: Float {
        return calculation?.oneRepMax ?? 0
    }
    var minOneRepMax: Float {
        return calculation?.minOneRepMax ?? 0
    }

    var yValues: [Double] {
        return [Double(minOneRepMax), Double(oneRepMax)]
    }

    var body: some View {
        Chart(history) { historyItem in
            if let oneRepMax = historyItem.oneRepMax {
                LineMark(
                    x: .value(NSLocalizedString("OneRepMaxChart_date", comment: "String for a label on the One Rep Max chart"), historyItem.date),
                    y: .value(NSLocalizedString("OneRepMaxChart_oneRepMax", comment: "String for a label on the One Rep Max chart"), oneRepMax)
                )
            }
        }
        .foregroundColor(.white)
        .background(Color.black)
        .chartYScale(domain: minOneRepMax...oneRepMax)
        .chartYAxis {
            AxisMarks(values: yValues) { value in
                AxisValueLabel() {
                    if let weight = value.as(Int.self) {
                        Text("\(weight)")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                AxisValueLabel() {
                    if let date = value.as(Date.self) {
                            Text(Self.dateFormatter.string(from: date))
                                .foregroundColor(.white)

                    }
                }
            }
        }
    }
}

struct OneRepMaxChart_Previews: PreviewProvider {
    static var previews: some View {
        OneRepMaxChart(calculation: Calculation(oneRepMax: 330, minOneRepMax: 250, massUnit: .pounds), history: [
            HistoryItem(date: Date(timeIntervalSinceNow: -86400 * 5), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 10, weight: 315),
            HistoryItem(date: Date(timeIntervalSinceNow: -86400 * 4), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 10, weight: 315),
            HistoryItem(date: Date(timeIntervalSinceNow: -86400 * 3), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 10, weight: 315),
            HistoryItem(date: Date(timeIntervalSinceNow: -86400 * 2), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 10, weight: 315),
            HistoryItem(date: Date(timeIntervalSinceNow: -86400 * 1), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 10, weight: 315)
        ])
    }
}
