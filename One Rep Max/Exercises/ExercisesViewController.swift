//
//  ExercisesViewController.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-03.
//

import UIKit

class ExercisesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingSpinner: UIView!

    var viewModel = ExercisesViewModel()

    override func viewDidLoad() {
        viewModel.delegate = self
        viewModel.getExerciseHistory()

        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let exercise = sender as? Exercise else { return }
        let detailsViewController = segue.destination as? ExerciseDetailsViewController
        let calculation = viewModel.calculation(forExercise: exercise)
        let history = viewModel.history(forExercise: exercise) ?? []
        let viewModel = ExerciseDetailsViewModel(exercise: exercise, history: history, calculation: calculation)
        detailsViewController?.viewModel = viewModel
    }
}

extension ExercisesViewController: ExercisesViewModelDelegate {
    func didGetExerciseHistory() {
        loadingSpinner.isHidden = true
        tableView.reloadData()
    }

    func failedToGetExerciseHistory(error: Error) {
        loadingSpinner.isHidden = true
        let alertTitle = NSLocalizedString("ExercisesViewController_couldNotGetExerciseHistory", comment: "String to show an alert with an error that the exercise history could not be fetched")
        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        let okActionTitle = NSLocalizedString("ExercisesViewController_ok", comment: "String to dismiss an alert")
        let action = UIAlertAction(title: okActionTitle, style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

extension ExercisesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseCell.reuseIdentifier, for: indexPath) as? ExerciseCell
        let exercise = viewModel.exercises[indexPath.row]
        cell?.format(withExercise: exercise, calculation: viewModel.calculation(forExercise: exercise))
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = viewModel.exercises[indexPath.row]
        performSegue(withIdentifier: "ExerciseDetails", sender: exercise)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OneRepMaxView.Constants.height
    }
}
