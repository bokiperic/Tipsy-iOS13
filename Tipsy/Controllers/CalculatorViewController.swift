//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 20
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        if zeroPctButton.isTouchInside {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        } else if tenPctButton.isTouchInside {
            tenPctButton.isSelected = true
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
        } else {
            twentyPctButton.isSelected = true
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
        }
        
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
    }
    
    func calculateValue() -> Double {
        let bill = Double(billTextField.text ?? "1")
        let peopleNumber = Int(splitNumberLabel.text ?? "1")
        
        let billPerPerson = ((bill ?? 1.0) + (bill ?? 1.0) * tipValue()) / Double(peopleNumber ?? 1)
        
        return billPerPerson
    }
    
    func tipValue() -> Double {
        
        if zeroPctButton.isSelected {
            return 0.0
        } else if tenPctButton.isSelected {
            return 0.1
        } else {
            return 0.2
        }
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.total = String(format: "%.2f", calculateValue())
            destinationVC.settings = "Split between \(splitNumberLabel.text ?? "Something went wrong!") people, with \(Int(tipValue() * 100))% tip."
        }
    }
    
}

