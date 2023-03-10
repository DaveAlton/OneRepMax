//
//  Calculation.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-06.
//

import Foundation

struct Calculation {
    var oneRepMax: Float
    var minOneRepMax: Float
    var massUnit: UnitMass

    init(oneRepMax: Float, minOneRepMax: Float, massUnit: UnitMass = .pounds) {
        self.oneRepMax = oneRepMax
        self.minOneRepMax = minOneRepMax
        self.massUnit = massUnit
    }
}
