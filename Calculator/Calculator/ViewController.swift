//
//  ViewController.swift
//  Calculator
//
//  Created by YA－QI on 4/26/16.
//  Copyright © 2016 macintosh.gift. All rights reserved.
//

// MVC Controller = How your Model is presented to the user.
// MVC View = Your Controller's minions

import UIKit // This is a module
// Swift you can bunch of classes together.And that's called a module.

class ViewController: UIViewController {
    // ViewController is a name of the class ; This is our controller class
    // UIViewController This is the inheritance.Single inheritance in Swift.
    
    // Our Properties are like instance variables
    // methods
    
    // instead of creating a method here,it created a property.
    @IBOutlet private weak var display: UILabel!
    //@IBOutlet is just something that Xcode puts.
    // NOte: exclamation point and question mark both mean optional.
    
    private var userIsInTheMiddleOfTyping = false
    // Note:in Swift all properties,every single one,have to have an initial value
    
    
    
    
    // @IBAction is a Xcode metion not swift method
    // func touchDigit(sender: UIButton) {} is Swift method syntax?
    // func means this is a function on a class
    // touchDigit is a name obviously of this method
    // colon and the type after the name of the thing
    // -> return something
    @IBAction private func touchDigit(sender: UIButton ) {
        // In Swift we save the argument here for readability and clarity
        // But we don't do it for first one
        //self.touchDigit(someButton, otherArgument: 5)
        
        // let read only
        // var varate value
        let digit = sender.currentTitle! // This is an optional and it's associated values of string.
        if userIsInTheMiddleOfTyping {
            let textCurrentlyDisplay = display.text!
            display.text = textCurrentlyDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
        
        // In Swift,Swift will infer the type all the time,Okey?
        
        // print("touched \(digit)  digit") // print something to the console
        
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program 
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    
    
    private var brain  = CalculatorBrain() // Model
    
    
    @IBAction private func performOperation(sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(mathmaticalSymbol)
        }
        displayValue = brain.result
    }
    
}



// Note: in swift , there is a type called optional. Optional is just a type. type just have two values,One value is not set,that's expressed in Swift with the key word nil,N I L ; nil only means this optional is not set.The other state that an optional can be in is set.in the set you can have a associated value

// you put an exclamation point in the end. to

// This called an implicitly unwrap optional