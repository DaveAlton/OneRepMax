//
//  History.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-03.
//

import Foundation

struct HistoryItem: Identifiable {
    var id: ObjectIdentifier = {
        ObjectIdentifier(Self.self)
    }()

    var date: Date
    var exercise: Exercise
    var sets: Int
    var reps: Int
    var weight: Float
    private var calculator = Calculator()
    var oneRepMax: Float?

    init(date: Date, exercise: Exercise, sets: Int, reps: Int, weight: Float, calculator: Calculator = Calculator()) {
        self.date = date
        self.exercise = exercise
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.calculator = calculator
        self.oneRepMax = calculator.calculation(forHistoryItem: self)?.oneRepMax
    }
}
