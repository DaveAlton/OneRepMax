//
//  OneRepMaxView.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-06.
//

import UIKit

@IBDesignable
class OneRepMaxView: UIView {
    enum Constants {
        static let margin = 8.0
        static let height = 75.0
    }

    @IBInspectable var exerciseName: String? {
        get {
            return exerciseNameLabel.text
        }
        set {
            exerciseNameLabel.text = newValue
        }
    }

    lazy var exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    @IBInspectable var subtitle: String? {
        get {
            return subtitleLabel.text
        }
        set {
            subtitleLabel.text = newValue
        }
    }

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    @IBInspectable var oneRepMax: String? {
        get {
            return oneRepMaxLabel.text
        }
        set {
            oneRepMaxLabel.text = newValue
        }
    }

    @IBInspectable lazy var oneRepMaxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    func format(withExercise exercise: Exercise, calculation: Calculation?) {
        exerciseNameLabel.text = exercise.name
        if let oneRepMax = calculation?.oneRepMax {
            oneRepMaxLabel.text = String(format: "%.1f", oneRepMax)
        } else {
            oneRepMaxLabel.text = "---"
        }
        if let massUnit = calculation?.massUnit.symbol {
            subtitleLabel.text = String(format: NSLocalizedString("OneRepMaxView_oneRepMax_withWeightUnit", comment: "String to show a sublabel including 'One Rep Max' and a weight unit (eg. lb)"), massUnit) as String?
        } else {
            subtitleLabel.text = NSLocalizedString("OneRepMaxView_oneRepMax", comment: "String to show a sublabel with 'One Rep Max'")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false

        let horizontalStack = UIStackView(arrangedSubviews: [
            exerciseNameLabel, oneRepMaxLabel
        ])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        let verticalStack = UIStackView(arrangedSubviews: [
            horizontalStack, subtitleLabel
        ])
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical

        self.addSubview(verticalStack)
        let constraints = [
            self.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: -Constants.margin),
            self.topAnchor.constraint(equalTo: verticalStack.topAnchor, constant: -Constants.margin),
            self.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor, constant: Constants.margin),
            self.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: Constants.margin)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
