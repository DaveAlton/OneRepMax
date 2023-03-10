//
//  DataParser.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-03.
//

import Foundation

typealias ExerciseHistory = [Exercise: [HistoryItem]]

struct DataParser {

    enum ParserError: Error {
        case couldNotReadFile
        case couldNotFormPath
    }

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter
    }()

    private func exerciseHistory(bestOneRepMaxForDate: [Exercise: [Date: HistoryItem]], datesForExercise: [Exercise: Set<Date>]) -> [Exercise: [HistoryItem]] {
        var exerciseHistory = [Exercise: [HistoryItem]]()
        for exercise in datesForExercise.keys {
            exerciseHistory[exercise] = [HistoryItem]()
            let orderedDates = datesForExercise[exercise]?.sorted() ?? []
            for date in orderedDates {
                if let history = bestOneRepMaxForDate[exercise]?[date] {
                    exerciseHistory[exercise]?.append(history)
                }
            }
        }
        return exerciseHistory
    }

    func parseWorkoutData(data: String) -> ExerciseHistory {
        var bestOneRepMaxForDate = [Exercise: [Date: HistoryItem]]()
        var datesForExercise = [Exercise: Set<Date>]()

        let lines = data.split(separator: "\n")
        for line in lines {
            let data = line.split(separator: ",")
            if data.count == 5,
               let date = Self.dateFormatter.date(from: String(data[0])),
               let sets = Int(data[2]),
               let reps = Int(data[3]),
               let weight = Float(data[4]) {
                let name = String(data[1])
                let exercise = Exercise(name: name)

                let history = HistoryItem(date: date, exercise: exercise, sets: sets, reps: reps, weight: weight)

                if datesForExercise[exercise] == nil {
                    datesForExercise[exercise] = []
                    bestOneRepMaxForDate[exercise] = [Date: HistoryItem]()
                }
                if (bestOneRepMaxForDate[exercise]?[date]?.oneRepMax ?? 0) < (history.oneRepMax ?? 0) {
                    datesForExercise[exercise]?.insert(date)
                    bestOneRepMaxForDate[exercise]?[date] = history
                }
            }
        }
        return exerciseHistory(bestOneRepMaxForDate: bestOneRepMaxForDate, datesForExercise: datesForExercise)
    }

    private func readWorkoutData() throws -> String {
        guard let filePath = Bundle.main.path(forResource: "workoutData", ofType: "txt") else { throw ParserError.couldNotFormPath }
        let urlPath = URL(fileURLWithPath: filePath)
        guard let workoutData = try? String(contentsOf: urlPath, encoding: .utf8) else { throw ParserError.couldNotReadFile }
        return workoutData
    }
    
    func getWorkoutHistory(completion: @escaping (_ exerciseHistory: ExerciseHistory, _ error: Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try self.readWorkoutData()
                let exerciseHistory = self.parseWorkoutData(data: data)
                DispatchQueue.main.async {
                    completion(exerciseHistory, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([:], error)
                }
            }
        }
    }
}
