//
//  ExerciseDetailsViewController.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-03.
//

import UIKit

class ExerciseDetailsViewController: UIViewController {
    @IBOutlet var oneRepMaxView: OneRepMaxView!
    @IBOutlet var stackView: UIStackView!

    var viewModel: ExerciseDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else { return }
        oneRepMaxView.format(withExercise: viewModel.exercise, calculation: viewModel.calculation)
        let chart = UIOneRepMaxChart(calculation: viewModel.calculation, history: viewModel.history)
        stackView.addArrangedSubview(chart)
    }
}
