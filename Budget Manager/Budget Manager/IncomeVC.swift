//
//  IncomeVC.swift
//  Budget Manager
//
//  Created by Anhelina Shulha on 7/30/17.
//  Copyright © 2017 Anhelina Shulha. All rights reserved.
//

import UIKit

class IncomeVC: UIViewController {

    var income:[String:Int] = [:]
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var incomeThisMonth: UILabel!
    @IBOutlet weak var totalIncome: UILabel!
    @IBOutlet weak var addIncomeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        updateIncomeThisMonth(amount: 0)
        updateTotalIncome()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: income)
        UserDefaults.standard.set(data, forKey: "income")
    }
    
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: "income") as? NSData {
            income = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [String:Int]
        }
    }
    
    func updateIncomeThisMonth(amount:Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-yyyy"
        let currentDate = formatter.string(from: Date())
        
        for date in income.keys {
            if date == currentDate {
                income[date] = income[date]! + amount
                incomeThisMonth.text = "$ " + String(income[date]!)
                return
            }
        }
        income[currentDate] = amount
        incomeThisMonth.text = "$ " + String(amount)
        
    }
    
    func updateTotalIncome() {
        if income.isEmpty {
            totalIncome.text = "$ 0"
            return
        }
        
        var total:Int = 0
        for value in income.values {
            total = total + value
        }
        totalIncome.text = "$ " + String(total)
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
        if let label = statusLabel {
            label.textColor = UIColor.green
            label.text = "Added $" + String(amount!)
            if let textField = addIncomeTextField {
                textField.text = ""
            }
        }
    }

}
