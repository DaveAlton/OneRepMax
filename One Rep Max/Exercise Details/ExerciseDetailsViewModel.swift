//
//  ExerciseDetailsViewModel.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-06.
//

import Foundation

class ExerciseDetailsViewModel {
    var exercise: Exercise
    var history: [HistoryItem]
    var calculation: Calculation?

    init(exercise: Exercise, history: [HistoryItem], calculation: Calculation?) {
        self.exercise = exercise
        self.history = history
        self.calculation = calculation
    }
}
