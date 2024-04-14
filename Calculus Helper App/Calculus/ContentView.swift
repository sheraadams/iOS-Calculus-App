//
//
//  ContentView.swift
//  Calculus Helper
//
//  Created by S. Adams on 1/4/24.
//
import SwiftUI
import UIKit
import UIKit
import Charts

struct ContentView: View {
    var body: some View {
        UIKitContentView()
    }
}

struct UIKitContentView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ContentViewViewController()
        let navigationController = UINavigationController(rootViewController: viewController) // Embed ContentViewViewController within a navigation controller
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the view controller if needed
    }
}

class ContentViewViewController: UIViewController {
    var coefficientTextField: UITextField!
    var coefficientAnswerTextField: UITextField!
    var powerTextField: UITextField!
    var powerAnswerTextField: UITextField!
    var choiceSwitch: UISwitch!
    var stateLabel: UILabel!
    var state2Label: UILabel!
    var calculateButton: UIButton!
    var graphButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let viewWidth = view.bounds.width
        let viewHeight = view.bounds.height
        
        let textFieldWidth: CGFloat = 80 // Adjusted text field width
        let textFieldHeight: CGFloat = 30
        let labelWidth: CGFloat = 30 // Adjusted label width for "x^"
        let labelHeight: CGFloat = 30
        let verticalSpacing: CGFloat = 40 // Increased vertical spacing
        
        // Calculate center positions
        let centerX = viewWidth / 2
        let centerY = viewHeight / 2
        
        // Choice Switch
        choiceSwitch = UISwitch(frame: CGRect(x: centerX - 25, y: 50, width: 50, height: 30)) // Positioned at the top center
        view.addSubview(choiceSwitch)
        
        // State Label (Derivative)
        stateLabel = UILabel(frame: CGRect(x: centerX - 100, y: 90, width: 200, height: 30)) // Adjusted position below the switch
        stateLabel.textAlignment = .center
        stateLabel.text = "Derivative"
        view.addSubview(stateLabel)
        
        // Coefficient Text Field
        coefficientTextField = UITextField(frame: CGRect(x: centerX - labelWidth / 2 - textFieldWidth - 10, y: centerY - verticalSpacing * 3, width: textFieldWidth, height: textFieldHeight)) // Positioned to the left of "x^" label with a small gap
        coefficientTextField.placeholder = "Coefficient"
        view.addSubview(coefficientTextField)
        
        // Coefficient Answer Text Field
        coefficientAnswerTextField = UITextField(frame: CGRect(x: centerX - labelWidth / 2 - textFieldWidth - 10, y: centerY - verticalSpacing, width: textFieldWidth, height: textFieldHeight)) // Positioned to the left of "x^" label with a small gap
        coefficientAnswerTextField.placeholder = "Coefficient Answer"
        view.addSubview(coefficientAnswerTextField)
        
        // Power Text Field
        powerTextField = UITextField(frame: CGRect(x: centerX + labelWidth / 2 + 10, y: centerY - verticalSpacing * 3, width: textFieldWidth, height: textFieldHeight)) // Positioned to the right of "x^" label with a small gap
        powerTextField.placeholder = "Power"
        view.addSubview(powerTextField)
        
        // Power Answer Text Field
        powerAnswerTextField = UITextField(frame: CGRect(x: centerX + labelWidth / 2 + 10, y: centerY - verticalSpacing, width: textFieldWidth, height: textFieldHeight)) // Positioned to the right of "x^" label with a small gap
        powerAnswerTextField.placeholder = "Power Answer"
        view.addSubview(powerAnswerTextField)
        
        // "x^" Label
        let xLabel1 = UILabel(frame: CGRect(x: centerX - labelWidth / 2, y: centerY - verticalSpacing * 3, width: labelWidth, height: labelHeight)) // Centered horizontally
        xLabel1.text = "x^"
        view.addSubview(xLabel1)
        
        // "x^" Label
        let xLabel2 = UILabel(frame: CGRect(x: centerX - labelWidth / 2, y: centerY - verticalSpacing, width: textFieldWidth, height: textFieldHeight)) // Centered horizontally
        xLabel2.text = "x^"
        view.addSubview(xLabel2)
        
        // State2 Label (Second Derivative or Integral)
        state2Label = UILabel(frame: CGRect(x: centerX - 100, y: centerY - verticalSpacing * 2, width: 200, height: 30)) // Adjusted vertical position between coefficient and power lines 1 and 2
        state2Label.textAlignment = .center
        view.addSubview(state2Label)
        
        // Calculate Button
        calculateButton = UIButton(frame: CGRect(x: centerX - 100, y: centerY + verticalSpacing * 3, width: 200, height: 50)) // Adjusted vertical position
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.backgroundColor = UIColor(
            hue: 0.6, // Blue hue
            saturation: 0.6,
            brightness: 1.0,
            alpha: 1.0
        )
        calculateButton.layer.cornerRadius = 25 // Apply corner radius
        view.addSubview(calculateButton)

        // Graph Button
        graphButton = UIButton(frame: CGRect(x: centerX - 100, y: centerY + verticalSpacing * 4.5, width: 200, height: 50)) // Adjusted vertical position
        graphButton.setTitle("Graph", for: .normal)
        graphButton.backgroundColor = UIColor(
            hue: 0.428,
            saturation: 0.796,
            brightness: 0.8,
            alpha: 1.0
        )

        graphButton.layer.cornerRadius = 25 // Apply corner radius
        view.addSubview(graphButton)

        // Add targets for buttons
        choiceSwitch.addTarget(self, action: #selector(updateSwitchText), for: .valueChanged)
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        graphButton.addTarget(self, action: #selector(graphButtonTapped), for: .touchUpInside)
    }


    @objc func updateSwitchText() {
        stateLabel.text = choiceSwitch.isOn ? "Integral" : "Derivative"
        state2Label.text = stateLabel.text
    }

    @objc func calculateButtonTapped() {
        print("Calculate button tapped")
        if choiceSwitch.isOn {
            integral()
        } else {
            derivative()
        }
    }

    @objc func graphButtonTapped() {
        guard let coefficientText = coefficientTextField.text,
              let powerText = powerTextField.text,
              let coefficientValue = Double(coefficientText),
              let powerValue = Double(powerText),
              let coefficientAnswerText = coefficientAnswerTextField.text,
              let powerAnswerText = powerAnswerTextField.text,
              let coefficientAnswerValue = Double(coefficientAnswerText),
              let powerAnswerValue = Double(powerAnswerText) else {
            return
        }
        
        let graphViewController = GraphViewController()
        graphViewController.coefficient = coefficientValue
        graphViewController.power = powerValue
        graphViewController.coefficientAnswer = coefficientAnswerValue
        graphViewController.powerAnswer = powerAnswerValue
        navigationController?.pushViewController(graphViewController, animated: true)
    }


    func updateUIWith(coefficient: Double, power: Double) {
        coefficientAnswerTextField.text = "\(coefficient)"
        powerAnswerTextField.text = "\(power)"
        
        // Trigger UI update
        coefficientAnswerTextField.setNeedsDisplay()
        powerAnswerTextField.setNeedsDisplay()
    }

    func derivative() {
        guard let coefficientText = coefficientTextField.text,
              let powerText = powerTextField.text,
              let coefficientValue = Double(coefficientText),
              let powerValue = Double(powerText) else {
            return
        }
        
        let answerCoefficient = coefficientValue * powerValue
        let answerPower = powerValue - 1

        DispatchQueue.main.async {
            self.coefficientAnswerTextField.text = "\(answerCoefficient)"
            self.powerAnswerTextField.text = "\(answerPower)"
        }
    }

    func integral() {
        guard let coefficientText = coefficientTextField.text,
              let powerText = powerTextField.text,
              let coefficientValue = Double(coefficientText),
              let powerValue = Double(powerText) else {
            return
        }
        
        let answerPower = powerValue + 1
        let answerCoefficient = coefficientValue / answerPower

        DispatchQueue.main.async {
            self.coefficientAnswerTextField.text = "\(answerCoefficient)"
            self.powerAnswerTextField.text = "\(answerPower)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}


