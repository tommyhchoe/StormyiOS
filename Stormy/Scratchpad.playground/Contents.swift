//: Playground - noun: a place where people can play

import Cocoa
import Foundation

var str = "Hello, playground"

func fizzBuzz(start: Int, end: Int, fizzValue: Int, buzzValue: Int) -> [String] {
    var numbersCollection: [String] = []
    
    for number in start...end {
        switch number {
        //case 0: numbersCollection.append("\(number)")
        case _ where number % (fizzValue * buzzValue) == 0: numbersCollection.append("FizzBuzz")
        case _ where number % fizzValue == 0: numbersCollection.append("Fizz")
        case _ where number % buzzValue == 0: numbersCollection.append("Buzz")
        default: numbersCollection.append("\(number)")
        }
    }
    return numbersCollection
}

let result = fizzBuzz(0, end: 100, fizzValue: 3, buzzValue: 5)

enum Hello: String{
    case greeting = "Hello"
}

let helloGreeting = Hello(rawValue: "Hello")
helloGreeting?.rawValue


