//
//  ExerciseCell.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-03.
//

import UIKit

class ExerciseCell: UITableViewCell {
    static let reuseIdentifier = "ExerciseCell"
    @IBOutlet var oneRepMaxView: OneRepMaxView!

    func format(withExercise exercise: Exercise, calculation: Calculation?) {
        oneRepMaxView.format(withExercise: exercise, calculation: calculation)
    }
}
