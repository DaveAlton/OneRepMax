//
//  DataParserTests.swift
//  One Rep MaxTests
//
//  Created by Dave Alton on 2023-03-03.
//

import XCTest
@testable import One_Rep_Max

final class DataParserTests: XCTestCase {
    var dataParser: DataParser!

    override func setUpWithError() throws {
        dataParser = DataParser()
    }

    override func tearDownWithError() throws {
        dataParser = nil
    }

    func test_oneLine_parses() {
        let historyLine = dataParser.parseWorkoutData(data: "Oct 11 2020,Back Squat,1,6,245")[Exercise(name: "Back Squat")]!.first!

        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone.current

        XCTAssertEqual(historyLine.exercise.name, "Back Squat")
        XCTAssertTrue(dateFormatter.string(from: historyLine.date).contains("2020-10-11T00:00:00"))
        XCTAssertEqual(historyLine.sets, 1)
        XCTAssertEqual(historyLine.reps, 6)
        XCTAssertEqual(historyLine.weight, 245.0)
    }

    func test_multipleExercises_sortsIntoExercises() {
        let workoutData =
        """
        Oct 11 2020,Back Squat,1,6,245
        Oct 05 2020,Barbell Bench Press,1,4,45
        Oct 04 2020,Back Squat,1,10,45
        """
        let historyPerExercise = dataParser.parseWorkoutData(data: workoutData)

        XCTAssertEqual(historyPerExercise[Exercise(name: "Back Squat")]!.count, 2)
        XCTAssertEqual(historyPerExercise[Exercise(name: "Barbell Bench Press")]!.count, 1)
    }

    func test_multipleExercises_bestPerDay() {
        let workoutData =
        """
        Oct 05 2020,Barbell Bench Press,1,12,85
        Oct 04 2020,Back Squat,1,10,45
        Oct 04 2020,Back Squat,1,10,60
        """
        let historyPerExercise = dataParser.parseWorkoutData(data: workoutData)

        XCTAssertEqual(historyPerExercise[Exercise(name: "Back Squat")]!.first!.oneRepMax, 80)
        XCTAssertEqual(historyPerExercise[Exercise(name: "Barbell Bench Press")]!.first!.oneRepMax, 122.4)
    }

    func test_multipleExercises_removesBadData() {
        let workoutData =
        """
        Oct 06 2020,Barbell Bench Press,1,12,85
        Oct 07 2020,Back Squat,1,10,45
        Oct 05 2020,Barbell Bench Press,1,,45
        Oct 04 2020,Back Squat,1,10,
        Oct 04 2020,Back Squat,,10,45
        """
        let historyPerExercise = dataParser.parseWorkoutData(data: workoutData)

        XCTAssertEqual(historyPerExercise[Exercise(name: "Back Squat")]!.count, 1)
        XCTAssertEqual(historyPerExercise[Exercise(name: "Barbell Bench Press")]!.count, 1)
    }
}
