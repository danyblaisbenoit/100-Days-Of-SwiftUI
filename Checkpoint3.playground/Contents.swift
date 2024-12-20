import Cocoa

// loop from 1 through 100 and for each number:
// 1. If it's a multiple of 3, print "Fizz"
// 2. If it's a multiple of 5, print "Buzz"
// 3. If it's a multiple of 3 and 5, print "FizzBuzz"
// 4. Otherwise, just print the number
for number in 1...100 {
    if number.isMultiple(of: 3) && number.isMultiple(of: 5) {
        print("FizzBuzz")
    }
    else if number.isMultiple(of: 3) {
        print("Fizz")
    }
    else if number.isMultiple(of: 5) {
        print("Buzz")
    }
    else {
        print(number)
    }
}
