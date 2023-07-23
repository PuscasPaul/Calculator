//
//  ViewController.swift
//  Calculator
//
//  Created by Puscas Paul on 21.07.2023.
//

import UIKit

class ViewController: UIViewController {
    // make it private so it's only used in ViewController
    private var isFinishedTypingNumber: Bool = true
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a double.")
            }
            return number
        }
        set {
            // the displayLabel will be updated with the newValue (displayValue)
            displayLabel.text = String(newValue)
        }
    }
    
    @IBOutlet weak var displayLabel: UILabel!
    // private to prevent other classes to mess with it
    private var calculator = CalculatorLogic()


    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
 
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad

        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                // To Prevent display label from showing only "." as first char and display "0" instead
                if numValue == "." && displayLabel.text?.first != "." {
                    return
                }
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    // prevent the addition of another .
                    if displayLabel.text!.contains(".") {
                        return
                    } else {
                        let isInt = floor(displayValue) == displayValue
                        // 👇🏻 this reads if isInt is false == it stops the code from writting . when trying to press on it
                        if !isInt {
                            return
                        }
                    }
                }
                displayLabel.text?.append(numValue)
            }
        }
    }
}
