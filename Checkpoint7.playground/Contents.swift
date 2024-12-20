import Cocoa

// Make a class hierarchy for animals, starting with Animal at the top.
// Then Dog and Cat as subclasses.
// Then Corgi and Poodle as subclasses of Dog.
// And Persian and Lion as subclasses of Cat.

// 1. The Animal class should have a legs integer propert that tracks how many legs the animal has.
class Animal {
    let nbLegs: Int
    
    init (nbLegs: Int) {
        self.nbLegs = nbLegs
    }
}

// 2. The Dog class should have a speak() method that prints a generic dog barking string, but each subclasses should print something sightly different.
class Dog: Animal {
    init() {
        super.init(nbLegs: 4)
    }
    
    func speak() {
        print("Wouf!")
    }
}

class Corgi : Dog {
    override func speak() {
        print("Corgi barks Wouf!")
    }
}

class Poodle : Dog {
    override func speak() {
        print("Poodle barks Wouf!")
    }
}

// 3. The Cat class should have a matching speak() method, again with each subclass printing something differents.
// 4. The Cat class should have an isTame Boolean property, provided using an initializer.
class Cat: Animal {
    var isTame: Bool
    
    init (isTame: Bool) {
        self.isTame = isTame
        super.init(nbLegs: 4)
    }
    
    func speak() {
        print("Meow!")
    }
}

class Persian : Cat {
    init() {
        super.init(isTame: true)
    }
    
    override func speak() {
        print("Persian meows Meow!")
    }
}

class Lion : Cat {
    init() {
        super.init(isTame: false)
    }
    
    override func speak() {
        print("Lion roars!")
    }
}


// TESTING
let corgi = Corgi()
corgi.speak()

let poodle = Poodle()
poodle.speak()

let persian = Persian()
persian.speak()
if persian.isTame {
    print("Persian is tame")
}

let lion = Lion()
lion.speak()
if !lion.isTame {
    print("Lion is savage")
}
