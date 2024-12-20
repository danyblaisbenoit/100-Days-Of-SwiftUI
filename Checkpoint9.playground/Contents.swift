import Cocoa

// Write a function that accepts an optional array of integers, and returns one randomly.
// If the array is missing or empty, return a random number in the range 1 through 100.
// Must be written in a single line of code.

func function(_ array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}

// testing
let array = [1, 1, 1]
print(function(array)) // always prints 1

let emptyArray: [Int]? = nil
print(function(emptyArray)) // prints a number between 1 and 100
