//
//  ViewController.swift
//  Calculator
//
//  Created by Matt Casanova on 6/25/20.
//  Copyright © 2020 Codejo.io. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let offColor = UIColor.systemOrange
    let onColor = UIColor.orange
    

    @IBOutlet weak var divideButton: BorderedButton!
    @IBOutlet weak var multiplicationButton: BorderedButton!
    @IBOutlet weak var subtractButton: BorderedButton!
    @IBOutlet weak var addButton: BorderedButton!
    @IBOutlet weak var equalButton: BorderedButton!
    
    
    @IBOutlet weak var displayLabel: UILabel!

    var savedValue: Double = 0.0
    var displayString = "0"
    
    var shouldProcess = false
    var shouldReset = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLabel.text = displayString
    }

    @IBAction func onNumberClicked(_ sender: UIButton) {
        guard let text = sender.currentTitle else { return }
        
        shouldProcess = true
        
        if  (text == "0" && displayString == "0") ||
            (text == "." && displayString.contains("."))
        {
            return
        }
        
        if text == "." && displayString == "0" {
            shouldReset = false
            displayString.append(text)
            displayLabel.text = displayString
                
            return
        }

        
        if (shouldReset) {
            displayString = text
            shouldReset = false
        } else {
            displayString.append(text)
        }
        
        displayLabel.text = displayString
    }
    
    @IBAction func onSignClicked(_ sender: UIButton) {
        if displayString == "0" {
            return
        }
        
        if displayString.hasPrefix("-") {
            displayString.removeFirst()
        } else {
            displayString.insert("-", at: displayString.startIndex)
        }
        
        displayLabel.text = displayString
    }
    
    @IBAction func onClearClicked(_ sender: UIButton) {
        guard let text = sender.currentTitle else { return }
        
        if text == "AC" {
            resetOperatorColors()
            displayString = "0"
            savedValue = 0
        } else if text == "C" {
            displayString = "0"
        }
        
        shouldReset = true
        displayLabel.text = displayString
    }
    
    @IBAction func onOperatorClicked(_ sender: UIButton) {
        
        if shouldProcess == false {
            resetOperatorColors()
            sender.backgroundColor = onColor
            return
        }
        
        if sender == equalButton {
            processOperation()
            resetOperatorColors()
        } else {
            processOperation()
            resetOperatorColors()
            sender.backgroundColor = onColor
        }
        
        shouldProcess = false
        shouldReset = true
    }
    
    func processOperation() {
        guard let value = Double(displayString) else { return }
        
        if addButton.backgroundColor == onColor {
            savedValue = value + savedValue
        } else if subtractButton.backgroundColor == onColor {
            savedValue = savedValue - value
        } else if multiplicationButton.backgroundColor == onColor {
            savedValue = value * savedValue
        } else if divideButton.backgroundColor == onColor {
            savedValue = savedValue / value
        } else {
            savedValue = value
        }
        
        displayString = "\(savedValue)"
        if displayString.hasSuffix(".0") {
            displayString.removeLast(2)
        }
        
        displayLabel.text = displayString
    }
    
    func resetOperatorColors() {
        divideButton.backgroundColor = offColor
        multiplicationButton.backgroundColor = offColor
        subtractButton.backgroundColor = offColor
        addButton.backgroundColor = offColor
        equalButton.backgroundColor = offColor
    }
    
}

