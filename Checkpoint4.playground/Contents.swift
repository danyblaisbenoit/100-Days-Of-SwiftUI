import Cocoa

// Function that accepts number between 1 and 10,000 and returns the integer square root of that number.
// Built-in sqrt() function can't be used.
// If the number is less than 1 or greater than 10,000 it must throw out of bounds error.
// Should only consider integer square root.
// If square root can't be found throw no root error.

enum SqrtError: Error {
    case outOfBounds
    case noRoot
}

func mySqrt(_ number: Int) throws -> Int {
    if number < 1 || number > 10_000 {
        throw SqrtError.outOfBounds
    }
    
    for i in 1...number {
        print(i)
        let squared = i * i
        if squared == number {
            return i
        } else if squared > number {
            break
        }
    }
    
    throw SqrtError.noRoot
}

// test function
let number = 8
do {
    let result = try mySqrt(number)
    print("The square root of \(number) is \(result)")
} catch SqrtError.outOfBounds {
    print("Number \(number) is out of bounds")
} catch SqrtError.noRoot {
    print("Number \(number) has no integer root")
}
