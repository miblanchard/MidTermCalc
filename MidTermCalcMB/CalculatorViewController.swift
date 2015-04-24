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

    var firstNumber = Float()
    var secondNumber = Float()
    var result = Float()
    var operation = ""
    var decimalWasAdded = false
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        var number = sender.currentTitle

        if number == "." && decimalWasAdded == true {
            return
        } else if number == "rand" {
            display.text = "\(rand())"
        } else {
            if userIsInTheMiddleOfTypingANumber == false {
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


    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber == false {
            equal()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "%": performOperationSingle { $0 / Float(100) }
        case "√": performOperationSingle { sqrt($0) }
        case "fib": fibonaci()
//        case "x²":
//        case "x³":
        default: break
        }
    }
    func performOperation(operation: (Double,Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            equal()
        }
    }

    @IBAction func clear() {
        display.text! = "0"
        userIsInTheMiddleOfTypingANumber = false
        decimalWasAdded = false

    }

    @IBAction func clearAll() {
        firstNumber = 0
        secondNumber = 0
        userIsInTheMiddleOfTypingANumber = false
        decimalWasAdded = false
        result = 0
        display.text! = "\(result)"
    }

    @IBAction func equal() {
        userIsInTheMiddleOfTypingANumber = false
        decimalWasAdded = false
    }

    func fibonaci() {
        let fibonacciAdder = FibonacciAdder()
        var newFib:Int? = display.text!.toInt() ?? 0
        var myResult = fibonacciAdder.fibonacciNumberAtIndex(newFib!)

        display.text = toString(myResult)
    }

}

class FibonacciAdder {

    func fibonacciNumberAtIndex(indexOfFibonacciNumber:Int) -> Int {

        var firstNumber = 0
        var secondNumber = 1
        var sum = secondNumber

        for var i=1; i<=indexOfFibonacciNumber; i++ {

            sum = firstNumber + secondNumber
            firstNumber = secondNumber
            secondNumber = sum
        }
        return sum
    }
}

