//
//  SummaryVC.swift
//  Budget Manager
//
//  Created by Anhelina Shulha on 8/5/17.
//  Copyright © 2017 Anhelina Shulha. All rights reserved.
//

import UIKit
import Charts

class SummaryVC: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    
    var income:[Int] = []
    var expenses:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        income = loadData(name: "income_values")
        expenses = loadData(name: "expenses_values")
        
        setChart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        income = loadData(name: "income_values")
        expenses = loadData(name: "expenses_values")
        
        setChart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData(name:String) -> [Int] {
        
        var array:[Int] = []
        
        if let data = UserDefaults.standard.object(forKey: name) as? NSData {
            array = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Int]
        }
        else {
            array = Array(repeating: 0, count: 12)
        }
        return array
    }
    
    
    
    
    func setChart() {
        var dataEntries1: [ChartDataEntry] = []
        
        for i in 0..<income.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(income[i]))
            dataEntries1.append(dataEntry)
        }
        let chartDataSet1 = LineChartDataSet(values: dataEntries1, label: "")
        chartDataSet1.circleRadius = 3
        chartDataSet1.circleColors = [.white]
        
        chartDataSet1.colors = [.white]
        chartDataSet1.lineWidth = 2
        chartDataSet1.fillAlpha = 1.0
        chartDataSet1.fill = Fill.fillWithColor(UIColor(red: 255/255, green: 216/255, blue: 22/255, alpha: 1.0))
        chartDataSet1.drawFilledEnabled = true
        chartDataSet1.valueColors = [UIColor.clear]
        chartDataSet1.drawCubicEnabled = true
        chartDataSet1.cubicIntensity = 0.1
        
        var dataEntries2: [ChartDataEntry] = []
        
        for i in 0..<income.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(expenses[i]))
            dataEntries2.append(dataEntry)
        }
        let chartDataSet2 = LineChartDataSet(values: dataEntries2, label: "")
        chartDataSet2.circleRadius = 3
        chartDataSet2.circleColors = [.white]
        
        chartDataSet2.colors = [.white]
        chartDataSet2.lineWidth = 2
        chartDataSet2.fillAlpha = 0.6
        chartDataSet2.fill = Fill.fillWithColor(UIColor(red: 250/255, green: 126/255, blue: 0/255, alpha: 1.0))
        chartDataSet2.drawFilledEnabled = true
        chartDataSet2.valueColors = [UIColor.clear]
        chartDataSet2.drawCubicEnabled = true
        chartDataSet2.cubicIntensity = 0.1
        
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(chartDataSet1)
        dataSets.append(chartDataSet2)
        
        let data = LineChartData(dataSets: dataSets)
        data.setDrawValues(true)
        
        chartView.data = data
        chartView.legend.textColor = .white
        chartView.sizeToFit()
        chartView.highlightPerTapEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
//        chartView.leftAxis.gridColor = .lightGray
//        chartView.rightAxis.gridColor = .lightGray
//        chartView.leftAxis.labelTextColor = .clear
//        chartView.rightAxis.labelTextColor = .clear
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.borderColor = .lightGray
        chartView.xAxis.enabled = false
        chartView.xAxis.gridColor = .lightGray
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelTextColor = .clear
        chartView.minOffset = 1
        chartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInOutQuart)
//        chartView.drawGridBackgroundEnabled = true
        chartView.gridBackgroundColor = .clear
        chartView.descriptionText = ""
        chartView.noDataText = "You need to provide data for the chart."

    }

}
