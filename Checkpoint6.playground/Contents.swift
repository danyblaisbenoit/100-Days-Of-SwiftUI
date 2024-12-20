import Cocoa

// Create a struct to store information about a car, including,
// - It's model
// - Number of seats
// - Current gear
// Add a method to change gears up or down.
// Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly
// Should the gear-changing method validate its input somehow?
enum GearChange {
    case Up
    case Down
}

struct Car {
    let model: String
    let numberofSeats: Int
    private(set) var currentGear: Int = 1
    
    mutating func changeGear(_ gearChange: GearChange) -> Bool {
        if gearChange == GearChange.Up && currentGear < 6  {
            currentGear += 1
            return true
        } else if gearChange == GearChange.Down && currentGear > 1 {
            currentGear -= 1
            return true
        } else {
            print(gearChange == GearChange.Up ? "Maximum gear reached" : "Minimum gear reached")
            return false
        }
    }
}

// testing
var car = Car(model: "Ford", numberofSeats: 5)

print("The car is a \(car.model) and it has \(car.numberofSeats) seats")

for _ in 1...6 {
    if car.changeGear(.Up) {
        print("Current gear is \(car.currentGear)")
    }
}
for _ in 1...6 {
    if car.changeGear(.Down) {
        print("Current gear is \(car.currentGear)")
    }
}
