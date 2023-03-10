//
//  CalculatorTests.swift
//  One Rep MaxTests
//
//  Created by Dave Alton on 2023-03-03.
//

import XCTest
@testable import One_Rep_Max

final class CalculatorTests: XCTestCase {
    // MARK: - HistoryItem
    func test_brzyckiCalculator() throws {
        var historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 12, weight: 85)
        var calculation = Calculator(equation: .brzycki).calculation(forHistoryItem: historyItem)
        XCTAssertEqual(calculation!.oneRepMax, 122.4)

        historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 5, weight: 50)
        calculation = Calculator(equation: .brzycki).calculation(forHistoryItem: historyItem)
        XCTAssertEqual(calculation!.oneRepMax, 56.25)
    }

    func test_epleyCalculator() throws {
        var historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 12, weight: 85)
        var calculation = Calculator(equation: .epley).calculation(forHistoryItem: historyItem)
        XCTAssertEqual(calculation!.oneRepMax, 119)

        historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 3, weight: 50)
        calculation = Calculator(equation: .epley).calculation(forHistoryItem: historyItem)
        XCTAssertEqual(calculation!.oneRepMax, 55)
    }

    func test_calculators_withOneRep() {
        var historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 1, weight: 85)
        var calculation = Calculator(equation: .brzycki).calculation(forHistoryItem: historyItem)
        XCTAssertEqual(calculation!.oneRepMax, 85)

        historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 1, weight: 85)
        calculation = Calculator(equation: .epley).calculation(forHistoryItem: historyItem)
        XCTAssertNil(calculation?.oneRepMax)
    }

    func test_calculators_withNoReps() {
        var historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 0, reps: 0, weight: 85)
        var calculation = Calculator(equation: .brzycki).calculation(forHistoryItem: historyItem)
        XCTAssertNil(calculation)

        historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 0, reps: 0, weight: 85)
        calculation = Calculator(equation: .epley).calculation(forHistoryItem: historyItem)
        XCTAssertNil(calculation)
    }

    func test_calculators_withNegativeReps() {
        var historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 0, reps: -1, weight: 85)
        var calculation = Calculator(equation: .brzycki).calculation(forHistoryItem: historyItem)
        XCTAssertNil(calculation)

        historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 0, reps: -1, weight: 85)
        calculation = Calculator(equation: .epley).calculation(forHistoryItem: historyItem)
        XCTAssertNil(calculation)
    }

    func test_calculator_withNoWeight() {
        let historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 0, reps: 1, weight: 0)
        let calculation = Calculator(equation: .brzycki).calculation(forHistoryItem: historyItem)
        XCTAssertEqual(calculation!.oneRepMax, 0)
    }

    func test_calculator_withNegativeWeight() {
        let historyItem = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 0, reps: 1, weight: -1)
        let calculation = Calculator(equation: .brzycki).calculation(forHistoryItem: historyItem)
        XCTAssertEqual(calculation!.oneRepMax, 0)
    }

    // MARK: - History
    func test_calculator_withTwoHistoryItemsInOneDay() {
        let historyItem1 = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 12, weight: 85)
        let historyItem2 = HistoryItem(date: Date(), exercise: Exercise(name: "Bench Press"), sets: 1, reps: 1, weight: 50)
        let calculation = Calculator(equation: .brzycki).calculation(forHistory: [historyItem1, historyItem2])
        XCTAssertEqual(calculation!.oneRepMax, 122.4)
        XCTAssertEqual(calculation!.minOneRepMax, 50)
    }
}
