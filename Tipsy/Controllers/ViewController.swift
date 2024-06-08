//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        // Do any additional setup after loading the view.
    //    }
    var tip: Double = 0.10
    var numberOfPeople = 2;
    var billTotal = 0.0
    var resultFormated = ""
    
    @IBAction func tipChanged(_ sender: UIButton) {
        //Dismiss the keyboard when the user chooses one of the tip values.
        billTextField.endEditing(true)
        
        //Deselect all tip buttons via IBOutlets
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        //Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        
        //Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        //Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        //Divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
        tip = buttonTitleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        let bill = billTextField.text!
        if bill != "" {
            var billValue = Double(bill)!
            print(tip)
            let billWithTip = (1 + tip)
            let result = (billWithTip * billValue) / Double(numberOfPeople)
            
            resultFormated = String(format: "%.2f", result)
            self.performSegue(withIdentifier: "goToResultScreen", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResultScreen" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = resultFormated
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
}

