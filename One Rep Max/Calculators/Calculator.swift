//
//  Calculator.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-03.
//

import Foundation

struct Calculator {
    enum Equation {
        case brzycki, epley

        func oneRepMax(weight w: Float, repetitions r: Int) -> Float? {
            guard w > 0 else { return 0 }
            let r = Float(r)

            switch self {
            case .epley:
                guard r > 1 else { return nil }
                return w*(1+(r/30.0))
            case .brzycki:
                guard r > 0 else { return nil }
                return w*(36.0/(37-r))
            }
        }
    }

    private var equation: Equation
    private var massUnit: UnitMass

    init(equation: Equation = .brzycki, massUnit: UnitMass = .pounds) {
        self.equation = equation
        self.massUnit = massUnit
    }

    func calculation(forHistoryItem history: HistoryItem) -> Calculation? {
        guard let oneRepMax = self.equation.oneRepMax(weight: history.weight, repetitions: history.reps) else { return nil }
        return Calculation(oneRepMax: oneRepMax, minOneRepMax: oneRepMax, massUnit: massUnit)
    }

    func calculation(forHistory history: [HistoryItem]) -> Calculation? {
        var oneRepMax: Float?
        var minOneRepMax: Float?

        for historyItem in history {
            let currentCalculation = calculation(forHistoryItem: historyItem)
            if let currentMax = oneRepMax {
                if let currentOneRepMax = currentCalculation?.oneRepMax {
                    oneRepMax = max(currentOneRepMax, currentMax)
                }
            } else {
                oneRepMax = currentCalculation?.oneRepMax
            }
            if let currentMin = minOneRepMax {
                if let currentMinOneRepMax = currentCalculation?.minOneRepMax {
                    minOneRepMax = min(currentMinOneRepMax, currentMin)
                }
            } else {
                minOneRepMax = currentCalculation?.minOneRepMax
            }
        }

        guard let oneRepMax = oneRepMax,
                let minOneRepMax = minOneRepMax else { return nil }
        return Calculation(oneRepMax: oneRepMax, minOneRepMax: minOneRepMax)
    }
}
