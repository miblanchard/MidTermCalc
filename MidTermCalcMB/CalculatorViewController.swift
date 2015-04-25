//
//  CalculatorViewController.swift
//  MidTermCalcMB
//
//  Created by Michael Blanchard on 4/21/15.
//  Copyright (c) 2015 Michael Blanchard. All rights reserved.
//

import UIKit

class CalculatorViewController : UIViewController {

    @IBOutlet weak var display: UILabel!

    var firstNumber = Double()
    var currentNumber = Double()
    var result = Double()
    var operation = String()
    var decimalWasAdded = false
    var userIsInTheMiddleOfTypingANumber = false
    var negativeButtonHasBeenPressed = false
    var equalsButtonWasPressed = false

    @IBAction func typeNumber(sender: UIButton) {
        var number = sender.currentTitle

        if equalsButtonWasPressed == true {
            display.text = ""
            display.text = display.text! + number!
            equalsButtonWasPressed = false
        } else {
            if  number == "." && decimalWasAdded == true {
            return
            } else if number == "rand" {
            display.text = "\(rand())"
            } else if number == "+/-" && negativeButtonHasBeenPressed == false {
            display.text = "-\(display.text!)"
            negativeButtonHasBeenPressed = true
            } else if number == "+/-" && negativeButtonHasBeenPressed == true {
            display.text = dropFirst(display.text!)
            negativeButtonHasBeenPressed = false
            } else {
                if userIsInTheMiddleOfTypingANumber == true {
                display.text = display.text! + number!
            } else {
                display.text = number
            }
                userIsInTheMiddleOfTypingANumber = true

                if number == "." {
                    decimalWasAdded = true
                }
            }
        }
    }

    @IBAction func operate(sender: UIButton) {
        firstNumber = parseANumberFromScreen()
        operation = sender.currentTitle!
        switch operation {
        case "×": result = firstNumber
        case "÷": result = firstNumber
        case "+": result = firstNumber
        case "−": result = firstNumber
        case "%": result = firstNumber / Double(100)
        case "√": result = sqrt(firstNumber)
        case "fib": result = fibonaci()
        case "x²": result = (firstNumber * firstNumber)
        case "x³": result = (firstNumber * firstNumber * firstNumber)
        default: break
        }
        userIsInTheMiddleOfTypingANumber = false
        decimalWasAdded = false
        display.text = "\(result)"
        equalsButtonWasPressed = true
    }

    @IBAction func equals(sender: UIButton) {
        currentNumber = parseANumberFromScreen()
        if sender.currentTitle! == "="{
            result = currentNumber
        }

        switch operation {
        case "×": result = firstNumber * currentNumber
        case "÷": result = firstNumber / currentNumber
        case "+": result = firstNumber + currentNumber
        case "−": result = firstNumber - currentNumber
        default: break
        }
        display.text = "\(result)"
        equalsButtonWasPressed = true

    }


    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        decimalWasAdded = false
        result = 0
        display.text! = "\(result)"
    }

    @IBAction func clearAll() {
        firstNumber = 0
        currentNumber = 0
        userIsInTheMiddleOfTypingANumber = false
        decimalWasAdded = false
        equalsButtonWasPressed = false
        result = 0
        display.text! = "\(result)"
    }

    func parseANumberFromScreen() -> Double {
        return NSString(string: display.text!).doubleValue
    }

    func fibonaci() -> Double {
        let fibonacciAdder = FibonacciAdder()
        var newFib:Int? = display.text!.toInt() ?? 0
        var fibResult = fibonacciAdder.fibonacciNumberAtIndex(newFib!)

        return Double(fibResult)
    }

}

class FibonacciAdder {

    func fibonacciNumberAtIndex(indexOfFibonacciNumber:Int) -> Int {

        var firstNumber = 0
        var secondNumber = 1
        var sum = secondNumber

        for var i=1; i<=(indexOfFibonacciNumber - 1); i++ {

            sum = firstNumber + secondNumber
            firstNumber = secondNumber
            secondNumber = sum
        }
        return sum
    }
}