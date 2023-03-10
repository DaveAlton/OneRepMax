//
//  ExercisesViewModel.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-03.
//

import Foundation

protocol ExercisesViewModelDelegate {
    func didGetExerciseHistory()
    func failedToGetExerciseHistory(error: Error)
}

class ExercisesViewModel {
    var delegate: ExercisesViewModelDelegate?
    private var exerciseHistory = ExerciseHistory()
    private var calculation = [Exercise: Calculation]()
    private var minOneRepMax = [Exercise: Float?]()
    var exercises = [Exercise]()
    var massUnit = UnitMass.pounds

    func getExerciseHistory() {
        DataParser().getWorkoutHistory { [weak self] exerciseHistory, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.failedToGetExerciseHistory(error: error)
                return
            }
            self.exerciseHistory = exerciseHistory
            self.exercises = exerciseHistory.keys.compactMap({ $0 })
            DispatchQueue.global(qos: .background).async {
                for exercise in exerciseHistory.keys {
                    self.calculation[exercise] = self.calculateOneRepMinMax(history: exerciseHistory[exercise] ?? [])
                }
                DispatchQueue.main.async {
                    self.delegate?.didGetExerciseHistory()
                }
            }

        }
    }

    func calculation(forExercise exercise: Exercise) -> Calculation? {
        return calculation[exercise]
    }

    func history(forExercise exercise: Exercise) -> [HistoryItem]? {
        return exerciseHistory[exercise]
    }

    private func calculateOneRepMinMax(history: [HistoryItem]) -> Calculation? {
        return Calculator().calculation(forHistory: history)
    }
}
