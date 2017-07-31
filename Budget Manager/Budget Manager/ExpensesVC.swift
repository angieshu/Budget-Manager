//
//  ExpensesVC.swift
//  Budget Manager
//
//  Created by Anhelina Shulha on 7/30/17.
//  Copyright © 2017 Anhelina Shulha. All rights reserved.
//

import UIKit

class ExpensesVC: UIViewController {

    var expenses:[String:Int] = [:]
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var expensesThisMonth: UILabel!
    @IBOutlet weak var totalExpenses: UILabel!
    @IBOutlet weak var addExpenseTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        updateExpensesThisMonth(amount: 0)
        updateTotalExpenses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: expenses)
        UserDefaults.standard.set(data, forKey: "expenses")
    }
    
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: "expenses") as? NSData {
            expenses = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [String:Int]
        }
    }

    func updateExpensesThisMonth(amount:Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-yyyy"
        let currentDate = formatter.string(from: Date())
        
        for date in expenses.keys {
            if date == currentDate {
                expenses[date] = expenses[date]! + amount
                expensesThisMonth.text = "$ " + String(expenses[date]!)
                return
            }
        }
        expenses[currentDate] = amount
        expensesThisMonth.text = "$ " + String(amount)
        
    }
    
    func updateTotalExpenses() {
        if expenses.isEmpty {
            totalExpenses.text = "$ 0"
            return
        }
        
        var total:Int = 0
        for value in expenses.values {
            total = total + value
        }
        totalExpenses.text = "$ " + String(total)
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
        if let label = statusLabel {
            label.textColor = UIColor.green
            label.text = "Added $" + String(amount!)
            if let textField = addExpenseTextField {
                textField.text = ""
            }
        }
    }

}
