//
//  GraphViewController.swift
//  Calculus Helper
//
//  Created by S. Adams on 4/9/24.
//
import UIKit
import Swift
class GraphViewController: UIViewController {
    var coefficient: Double = 0.0
    var power: Double = 0.0
    var coefficientAnswer: Double = 0.0
    var powerAnswer: Double = 0.0
    var lineChartView1: LineChartView!
    var lineChartView2: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLineChartViews()
        generateDataAndSetCharts()
    }
    
    func setupLineChartViews() {
        // Chart 1
        lineChartView1 = LineChartView(frame: CGRect(x: 20, y: 0, width: 300, height: 300))
        view.addSubview(lineChartView1)
        
        // Equation label 1
        let equationLabel1 = UILabel(frame: CGRect(x: 20, y: 300, width: 300, height: 20))
        equationLabel1.textAlignment = .center
        equationLabel1.font = UIFont.systemFont(ofSize: 14)
        equationLabel1.textColor = .black
        equationLabel1.text = "y = \(coefficient)x^\(power)"
        view.addSubview(equationLabel1)
        
        // Chart 2
        lineChartView2 = LineChartView(frame: CGRect(x: 20, y: 320, width: 300, height: 300))
        view.addSubview(lineChartView2)
        
        // Equation label 2
        let equationLabel2 = UILabel(frame: CGRect(x: 20, y: 620, width: 300, height: 20))
        equationLabel2.textAlignment = .center
        equationLabel2.font = UIFont.systemFont(ofSize: 14)
        equationLabel2.textColor = .black
        equationLabel2.text = "y = \(coefficientAnswer)x^\(powerAnswer)" // Using coefficientAnswer and powerAnswer
        view.addSubview(equationLabel2)
    }
    
    func generateDataAndSetCharts() {
        // Chart 1 data
        var dataPoints1: [CGPoint] = []
        for x in stride(from: -20.0, through: 20.0, by: 0.1) {
            let y = CGFloat(coefficient * pow(x, power))
            let point = CGPoint(x: 150 + x * 10, y: 150 - y * 10)
            dataPoints1.append(point)
        }
        lineChartView1.dataPoints = dataPoints1
        
        // Chart 2 data
        var dataPoints2: [CGPoint] = []
        let xOffset = lineChartView2.frame.width / 2 // Calculate the x-offset based on the width of the chart view
        for x in stride(from: -20.0, through: 20.0, by: 0.1) {
            let y = CGFloat(coefficientAnswer * pow(x, powerAnswer))
            let point = CGPoint(x: xOffset + x * 10, y: 150 - y * 10) // Adjust the x-coordinate calculation to use xOffset
            dataPoints2.append(point)
        }
        lineChartView2.dataPoints = dataPoints2
    }
}
