//
//  UIOneRepMaxChart.swift
//  One Rep Max
//
//  Created by Dave Alton on 2023-03-06.
//

import SwiftUI

class UIOneRepMaxChart: UIView {
    var calculation: Calculation?
    var history: [HistoryItem] = []

    init(calculation: Calculation?, history: [HistoryItem]) {
        self.calculation = calculation
        self.history = history
        super.init(frame: .zero)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        let swiftUIHost = UIHostingController(rootView: OneRepMaxChart(calculation: calculation, history: history))
        guard let chartView = swiftUIHost.view else { return }
        chartView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chartView)

        let constraints = [
            chartView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            chartView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            chartView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
