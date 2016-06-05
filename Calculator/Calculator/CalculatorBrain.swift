//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by YA－QI on 5/22/16.
//  Copyright © 2016 macintosh.gift. All rights reserved.
//

// All local variable and vars are lowercase first letter called camel case
//  This is MVC Model = What your application is

// Foundation is core services layer kind of the basic stuff
import Foundation

// inline function

class CalculatorBrain
{
    private var accumulator: Double = 0.0
    private var internalProgram = [AnyObject]()
    
    private var description: String = ""  // new Add
    private var isPartialResult:Bool = false // new Add 
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgram.append(operand)
    }
    // That because might not contain that key
    private  var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI), // M_PI,
        "e" : Operation.Constant(M_E), // M_E,
        "±" : Operation.UnaryOperation({-$0}),
        "√" : Operation.UnaryOperation(sqrt), // sqrt,
        "cos": Operation.UnaryOperation(cos), // cos,
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    private enum Operation {
        // It has a discrete value
        // It can have a methods
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    // ctrl + I -> It'll reformat it.
    func performOperation(symbol: String) {
        
        internalProgram.append(symbol)
        
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value) :
                accumulator = value
            case .UnaryOperation(let function) :
                accumulator = function(accumulator)
            case .BinaryOperation(let function) :
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals :
                executePendingBinaryOperation()
            }
        }
    }
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    // This is my first optional
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return internalProgram
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand)
                    }else if let operation = op as? String {
                        performOperation(operation)
                    }
                }
            }
        }
    }
    
    func clear() {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}