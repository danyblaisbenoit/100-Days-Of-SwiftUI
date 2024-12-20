import Cocoa

// Make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it.
// The protocol should require the following:
// 1. A property storing how many rooms it has.
// 2. A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
// 3. A property storing the name of the estate agent responsible for selling the building.
// 4. A method for printing the sales summary of the building, describing what is along with its other properties.

protocol Building {
    var numberRooms: Int { get }
    var cost: Int { get set }
    var estateAgent: String { get set }
    
    func printSalesSummary()
}

struct House: Building {
    var numberRooms: Int
    var cost: Int
    var estateAgent: String
    
    func printSalesSummary() {
        print("House of \(numberRooms) rooms, that costs \(cost) dollars, sold by \(estateAgent)")
    }
}

struct Office: Building {
    var numberRooms: Int
    var cost: Int
    var estateAgent: String
    
    func printSalesSummary() {
        print("Office of \(numberRooms) rooms, that costs \(cost) dollars, sold by \(estateAgent)")
    }
}

// TESTING
let house = House(numberRooms: 4, cost: 350_000, estateAgent: "Taylor")
let office = Office(numberRooms: 10, cost: 1_000_000, estateAgent: "Swift")

house.printSalesSummary()
office.printSalesSummary()
