//
//  GoalsVC.swift
//  Budget Manager
//
//  Created by Anhelina Shulha on 7/30/17.
//  Copyright © 2017 Anhelina Shulha. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController {
    var pos_x = 16
    var pos_y = 50
    var width = 343
    var height = 79
    
    var goals:[String:Int] = [:]
    
    let noItems = UILabel(frame: CGRect(x:0, y:60, width:375, height:100))
    
    var labelBackground = [UILabel]()
    var labelText = [UILabel]()
    var buttonDelete = [UIButton]()
    var textPayment = [UITextField]()
    var buttonAdd = [UIButton]()
    
    @IBOutlet weak var nameGoal: UITextField!
    @IBOutlet weak var amountRequired: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        if goals.isEmpty {
            noItemsAdded()
            return
        }
        for (name, value) in goals {
            makeBackgroundLabel()
            makeTextLabel(name: name, value: value)
            makeAddPayment()
            makeAddButton()
            makeDeleteButton()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func saveData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: goals)
        UserDefaults.standard.set(data, forKey: "goals")
    }
    
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: "goals") as? NSData {
            goals = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [String:Int]
        }
    }
    
    func currencyFormat(amount:Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        return formatter.string(from: amount as NSNumber)!
    }
    
    func makeBackgroundLabel() {
        
        let _y = pos_y + (height + 15) * labelBackground.count
        
        let label = UILabel(frame: CGRect(x:pos_x, y:_y, width:width, height:height))
        label.backgroundColor = UIColor(patternImage: UIImage(named: "label-view")!)
        label.alpha = 0.35
        self.view.addSubview(label)
        labelBackground.append(label)
        
    }
    
    func makeTextLabel(name:String, value:Int) {
        
        let _y = pos_y + (height + 15) * labelText.count
        
        let label = UILabel(frame: CGRect(x:pos_x + 10, y:_y + 10, width:width - 50, height:20))
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        label.textColor = UIColor.white
        
        let formattedAmount:String? = currencyFormat(amount: value)
        if (formattedAmount != nil) {
            label.text = name + " ( " + formattedAmount! + " )"
        }
        self.view.addSubview(label)
        labelText.append(label)
    }
    
    func makeDeleteButton() {
        let _y = pos_y + (height + 15) * buttonDelete.count
        
        let button = UIButton(frame: CGRect(x: width - 50, y: _y + 10, width: 60, height: 20))
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.cyan.cgColor
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font =  UIFont.systemFont(ofSize: 12.0)
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        button.tag = buttonDelete.count
        self.view.addSubview(button)
        buttonDelete.append(button)
    }
    
    func makeAddPayment() {
        let _y = pos_y + (height + 15) * textPayment.count + 3 * height / 5
        
        let field = UITextField(frame: CGRect(x: pos_x + width / 4, y: _y, width: width / 2, height: 20))
        field.placeholder = "add payment"
        field.font = UIFont.systemFont(ofSize: 14.0)
        field.borderStyle = UITextBorderStyle.roundedRect
        field.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        field.textAlignment = .center
        field.backgroundColor = UIColor(red: 168.0, green: 250.0, blue: 255.0, alpha: 0.7)
        self.view.addSubview(field)
        textPayment.append(field)
    }
    
    func makeAddButton() {
        let _y = pos_y + (height + 15) * buttonAdd.count + 2 * height / 5
        let _x = pos_x + (3 * (width / 4) / 5)
        
        let button = UIButton(type: .contactAdd)
        button.frame = CGRect(x: _x, y: _y + 10, width: 30, height: 30)
        button.tintColor = .cyan
        button.addTarget(self, action: #selector(addPayment(button:)), for: .touchUpInside)
        button.tag = buttonAdd.count
        self.view.addSubview(button)
        buttonAdd.append(button)
        
    }
    
    func noItemsAdded() {
        
        noItems.center = CGPoint(x:187, y:200)
        noItems.textAlignment = .center
        noItems.textColor = UIColor.white
        noItems.font = UIFont.systemFont(ofSize: 14.0)
        noItems.text = "No goals added."
        self.view.addSubview(noItems)
    }
    
    func rect(frame:CGRect) -> CGRect {
        var r:CGRect = frame
        r.origin.y = r.origin.y - CGFloat(self.height) - 15.0
        return r
    }
    func addPayment(button: UIButton) {
        var i:Int = button.tag
        
        if textPayment[i].text?.isEmpty ?? true {
            return
        }
        
        let amount:Int? = Int(textPayment[i].text!)
        if amount == nil {
            textPayment[i].text = ""
            return
        }
        for (name, value) in goals {
            if i == 0 {
                goals[name] = value - amount!
                if goals[name]! < 1 {
                    goals[name] = 0
                    textPayment[button.tag].isUserInteractionEnabled = false
                    textPayment[button.tag].textColor = UIColor.white
                    textPayment[button.tag].text = "You did it! Good job!"
                    textPayment[button.tag].placeholder = ""
                    textPayment[button.tag].backgroundColor = UIColor.blue
                    textPayment[button.tag].alpha = 0.3
                    buttonAdd[button.tag].isEnabled = false
                    labelText[button.tag].text = name + " ( $0.00 )"
                    saveData()
                    return
                }
                let formattedAmount:String? = currencyFormat(amount: goals[name]!)
                if (formattedAmount != nil) {
                    labelText[button.tag].text = name + " ( " + formattedAmount! + " )"
                }
                textPayment[button.tag].text = ""
                saveData()
                return
            }
            i -= 1
        }
    }
    
    func pressButton(button: UIButton) {
        let i:Int = button.tag
        
        labelText[i].removeFromSuperview()
        labelText.remove(at: i)
        
        labelBackground[i].removeFromSuperview()
        labelBackground.remove(at: i)
        
        goals.removeValue(forKey: Array(goals.keys)[i])
        
        buttonDelete[i].removeFromSuperview()
        buttonDelete.remove(at: i)
        
        buttonAdd[i].removeFromSuperview()
        buttonAdd.remove(at: i)
        
        textPayment[i].removeFromSuperview()
        textPayment.remove(at: i)
        
        saveData()
        
        if goals.count == 0 {
            noItemsAdded()
            return
        }
        
        for var index in i..<goals.count {
            UIView.animate(withDuration: 0.4, animations: {
                self.labelBackground[index].frame = self.rect(frame: self.labelBackground[index].frame)
                self.labelText[index].frame = self.rect(frame: self.labelText[index].frame)
                self.buttonDelete[index].frame = self.rect(frame: self.buttonDelete[index].frame)
                self.textPayment[index].frame = self.rect(frame: self.textPayment[index].frame)
                self.buttonAdd[index].frame = self.rect(frame: self.buttonAdd[index].frame)
                
            }, completion: nil)
        }
        
        for i in 0..<goals.count {
            buttonDelete[i].tag = i
            buttonAdd[i].tag = i
        }
        
    }
    
    @IBAction func setButtonTapped(_ sender: Any) {
        if let label = statusLabel {
            label.textColor = UIColor.red
        }
        
        if goals.count == 4 {
            if let label = statusLabel {
                label.text = "Only 4 goals can be set."
                amountRequired.text = ""
                nameGoal.text = ""
                return
            }
        }
        
        if nameGoal.text?.isEmpty ?? true || amountRequired.text?.isEmpty ?? true {
            if let label = statusLabel {
                label.text = "Field is empty!"
                return
            }
        }
        
        if strlen(nameGoal.text) > 12 {
            if let label = statusLabel {
                label.text = "Name must not be more than 12 characters."
                return
            }
        }
        
        if Array(goals.keys).contains(nameGoal.text!) {
            if let label = statusLabel {
                label.text = "Goal with this name already exists."
                return
            }
        }
        
        let amount:Int? = Int(amountRequired.text!)
        if amount == nil {
            if let label = statusLabel {
                label.text = "Enter only digits!"
                amountRequired.text = ""
                return
            }
        }
        if amount! < 0 {
            if let label = statusLabel {
                label.text = "Negative amount!"
                amountRequired.text = ""
                return
            }
        }
        
        noItems.text = ""
        goals[nameGoal.text!] = amount
        saveData()
        makeBackgroundLabel()
        makeTextLabel(name: nameGoal.text!, value: amount!)
        makeDeleteButton()
        makeAddPayment()
        makeAddButton()
        
        if let label = statusLabel {
            label.textColor = UIColor.green
            label.text = "Set goal \'" + nameGoal.text! + "\'"
            nameGoal.text = ""
            amountRequired.text = ""
        }
    }
    
}
