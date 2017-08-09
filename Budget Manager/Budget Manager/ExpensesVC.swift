//
//  ExpensesVC.swift
//  Budget Manager
//
//  Created by Anhelina Shulha on 7/30/17.
//  Copyright © 2017 Anhelina Shulha. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ExpensesVC: UIViewController {
    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var expenses:[Int] = []
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var expensesThisMonth: UILabel!
    @IBOutlet weak var addExpenseTextField: UITextField!
    @IBOutlet weak var totalExpenses: UILabel!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        updateExpensesThisMonth(amount: 0)
        updateTotalExpenses()
        setChart(dataPoints: months, values: expenses)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setChart(dataPoints: months, values: expenses)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func saveData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: expenses)
        UserDefaults.standard.set(data, forKey: "expenses_values")
    }
    
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: "expenses_values") as? NSData {
            expenses = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Int]
        }
        else {
            expenses = Array(repeating: 0, count: 12)
        }

    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<expenses.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(expenses[i]))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.7
        chartDataSet.colors = [UIColor(red: 244/255, green: 126/255, blue: 0/255, alpha: 1.0)]
        chartDataSet.valueColors = [UIColor.white]
        barChartView.data = chartData
        barChartView.doubleTapToZoomEnabled = false
        barChartView.highlightPerTapEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelTextColor = .clear
        barChartView.minOffset = 0
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
        barChartView.drawGridBackgroundEnabled = true
        barChartView.gridBackgroundColor = .clear
        barChartView.descriptionText = ""
        barChartView.noDataText = "You need to provide data for the chart."
    }
    
    func updateExpensesThisMonth(amount:Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        let currentDate = formatter.string(from: Date())
        
        if let index:Int = months.index(of: currentDate) {
            expenses[index] += amount
            
            let formattedAmount:String? = currencyFormat(amount: expenses[index])
            
            if (formattedAmount != nil) {
                expensesThisMonth.text = formattedAmount
            }
        }
    }
    
    func updateTotalExpenses() {
        if expenses.isEmpty {
            totalExpenses.text = "$0"
            return
        }
        
        var total:Int = 0
        for value in expenses {
            total = total + value
        }
        
        let formattedAmount:String? = currencyFormat(amount: total)
        
        if (formattedAmount != nil) {
            totalExpenses.text = formattedAmount
        }
    }
    
    func currencyFormat(amount:Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        return formatter.string(from: amount as NSNumber)!
    }
    
    @IBAction func addExpenseTapped(_ sender: Any) {
        statusLabel.textColor = UIColor.red
        
        if addExpenseTextField.text?.isEmpty ?? true {
            if let label = statusLabel {
                label.text = "Field is empty!"
                return
            }
        }
        
        let amount:Int? = Int(addExpenseTextField.text!)
        if amount == nil {
            if let label = statusLabel {
                label.text = "Enter only digits!"
                addExpenseTextField.text = ""
                return
            }
        }
        if amount! < 0 {
            if let label = statusLabel {
                label.text = "Negative amount!"
                addExpenseTextField.text = ""
                return
            }
        }
        
        updateExpensesThisMonth(amount: amount!)
        updateTotalExpenses()
        saveData()
        
        setChart(dataPoints: months, values: expenses)
        let formattedAmount:String? = currencyFormat(amount: amount!)
        
        if (formattedAmount != nil) {
            if let label = statusLabel {
                label.textColor = UIColor.green
                label.text = "Added " + formattedAmount!;
                if let textField = addExpenseTextField {
                    textField.text = ""
                }
            }
        }
    }
}
