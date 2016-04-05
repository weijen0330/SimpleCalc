//  main.swift
//  SimpleCalc
//
//  Created by Wei-Jen Chiang on 4/3/16.
//  Copyright © 2016 Wei-Jen Chiang. All rights reserved.
//

import Foundation

print("Enter an expression separated by returns: ")

func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData, encoding:NSUTF8StringEncoding) as! String
    return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

func convert(incoming: String) -> Int {
    return NSNumberFormatter().numberFromString(incoming)!.integerValue
}

func isNumeric(input: String) -> Bool {
    return Int(input) != nil
}

enum InputError : ErrorType {
    case NotAnInteger
    case NotAnValidOperand
}

var result = 0;

var input1 = input()
guard isNumeric(input1) else {
    throw InputError.NotAnInteger
}
/* Deals with factorials. */
var input2 = input()
if (input2 == "fact") {
    var sum = 1;
    for index in 1...convert(input1) {
        sum *= index
    }
    result = sum
/* Deals with add, subtract, multiple, divide and modulus. */
} else if (input2 == "+" || input2 == "-" || input2 == "*" || input2 == "/" || input2 == "%" ) {
    var num2 = input()
    guard isNumeric(num2) else {
        throw InputError.NotAnInteger
    }
    switch input2 {
        case "+":
            result = convert(input1) + convert(num2)
        case "-":
            result = convert(input1) - convert(num2)
        case "*":
            result = convert(input1) * convert(num2)
        case "/":
            result = (convert(input1) / convert(num2))
        case "%":
            result = convert(input1) % convert(num2)
        default:
            throw InputError.NotAnValidOperand
    }
/* Deals with the users inputting multiple number and perform count and avg. */
} else if (isNumeric(input2)) {
    var numList = [Int]();
    numList += [convert(input1), convert(input2)]
    var moreInput = input();
    while (isNumeric(moreInput)) {
        numList.append(convert(moreInput))
        moreInput = input()
    }
    switch moreInput.stringByTrimmingCharactersInSet(
    NSCharacterSet.whitespaceAndNewlineCharacterSet()).lowercaseString {
        case "count":
            result = numList.count
        case "avg":
            var sum = 0
            for num in numList {
                sum += num
            }
            result = sum / numList.count
        
        default:
            throw InputError.NotAnValidOperand
    }
} else {
    throw InputError.NotAnValidOperand
}

print("Results: \(result)")















