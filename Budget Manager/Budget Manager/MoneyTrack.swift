//
//  MoneyTrack.swift
//  Budget Manager
//
//  Created by Anhelina Shulha on 8/6/17.
//  Copyright © 2017 Anhelina Shulha. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class MoneyTrack: UIViewController {
    
    let _months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var _moneyTrack:[Int] = []
    var _name:String = String()
    
    weak var _statusLabel: UILabel!
    weak var _thisMonth: UILabel!
    weak var _total: UILabel!
    weak var _addTextField: UITextField!
    
    var _barChartView: BarChartView
    
    convenience init(name:String, statusLabel:UILabel, thisMonth:UILabel, total:UILabel, addTextField:UITextField, barChartView:BarChartData) {
        
        _name = name
        _statusLabel = statusLabel
        _thisMonth = thisMonth
        _total = total
        _addTextField = addTextField
        _barChartView = barChartView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        updateIncomeThisMonth(amount: 0)
        updateTotalIncome()
        setChart(dataPoints: months, values: income)
        
    }
    
    
    func saveData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: income)
        UserDefaults.standard.set(data, forKey: "income_values")
    }
    
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: "income_values") as? NSData {
            income = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Int]
        }
        else {
            income = Array(repeating: 0, count: 12)
        }
    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        barChartView.drawGridBackgroundEnabled = true
        barChartView.gridBackgroundColor = .clear
        barChartView.descriptionText = ""
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<income.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(income[i]))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.7
        chartDataSet.colors = [UIColor(red: 255/255, green: 216/255, blue: 22/255, alpha: 1.0)]
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
    }
    
    func updateIncomeThisMonth(amount:Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        let currentDate = formatter.string(from: Date())
        
        if let index:Int = months.index(of: currentDate) {
            income[index] += amount
            
            let formattedAmount:String? = currencyFormat(amount: income[index])
            
            if (formattedAmount != nil) {
                incomeThisMonth.text = formattedAmount
            }
        }
    }
    
    func updateTotalIncome() {
        if income.isEmpty {
            totalIncome.text = "$0"
            return
        }
        
        var total:Int = 0
        for value in income {
            total = total + value
        }
        
        let formattedAmount:String? = currencyFormat(amount: total)
        
        if (formattedAmount != nil) {
            totalIncome.text = formattedAmount
        }
    }
    
    func currencyFormat(amount:Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        return formatter.string(from: amount as NSNumber)!
    }
    
    
    @IBAction func addIncomeTapped(_ sender: Any) {
        statusLabel.textColor = UIColor.red
        
        if addIncomeTextField.text?.isEmpty ?? true {
            if let label = statusLabel {
                label.text = "Field is empty!"
                return
            }
        }
        
        let amount:Int? = Int(addIncomeTextField.text!)
        if amount == nil {
            if let label = statusLabel {
                label.text = "Enter only digits!"
                addIncomeTextField.text = ""
                return
            }
        }
        if amount! < 0 {
            if let label = statusLabel {
                label.text = "Negative amount!"
                addIncomeTextField.text = ""
                return
            }
        }
        
        updateIncomeThisMonth(amount: amount!)
        updateTotalIncome()
        saveData()
        
        setChart(dataPoints: months, values: income)
        
        let formattedAmount:String? = currencyFormat(amount: Int(amount!))
        
        if (formattedAmount != nil) {
            if let label = statusLabel {
                label.textColor = UIColor.green
                label.text = "Added " + formattedAmount!;
                if let textField = addIncomeTextField {
                    textField.text = ""
                }
            }
        }
    }
    
}
