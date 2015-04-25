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

        if number == "." && decimalWasAdded == true {
            return
        } else if number == "rand" {
            display.text = "\(rand())"
        } else {
            if userIsInTheMiddleOfTypingANumber == true {
                display.text = display.text! + number!
            } else if equalsButtonWasPressed == true {
                display.text = number
            }
            userIsInTheMiddleOfTypingANumber = true

            if number == "." {
            decimalWasAdded = true
            }
            }
    }

            //        } else if number == "+/-" {
            //            if negativeButtonHasBeenPressed == false {
            //                display.text = "-\(display.text!)"
            //                negativeButtonHasBeenPressed = true
            //            } else if negativeButtonHasBeenPressed == true {
            //                display.text = dropFirst(display.text!)
            //                negativeButtonHasBeenPressed = false
            //                return

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
        display.text! = ""
    }

    @IBAction func clearAll() {
        firstNumber = 0
        currentNumber = 0
        userIsInTheMiddleOfTypingANumber = false
        decimalWasAdded = false
        equalsButtonWasPressed = false
        result = 0
        display.text! = ""
    }

    func parseANumberFromScreen() -> Double {
        return NSString(string: display.text!).doubleValue
    }

    func fibonaci() -> Double {
        let fibonacciAdder = FibonacciAdder()
        var newFib:Int? = display.text!.toInt() ?? 0
        var fibResult = fibonacciAdder.fibonacciNumberAtIndex(newFib!)

//        display.text! = "\(fibResult)"
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
//switch number {
//case "1":
//case "2":
//case "3":
//case "4":
//case "5":
//case "6":
//case "7":
//case "8":
//case "9":
//case "rand":
//    display.text = "\(rand())"
//case ".":
//    if decimalWasAdded == true {
//        return
//    } else {
//
//    }
//case "+/-":
//    if negativeButtonHasBeenPressed == false {
//        display.text = "-\(display.text!)"
//        negativeButtonHasBeenPressed = true
//    } else if negativeButtonHasBeenPressed == true {
//        display.text = dropFirst(display.text!)
//        negativeButtonHasBeenPressed = false
//    }
//default: break
//}