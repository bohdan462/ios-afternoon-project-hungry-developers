import Foundation
import PlaygroundSupport

class Spoon {
    
    private var canEat = NSLock()
    let id: Int
    
    init(_ id: Int) {
        self.id = id
    }
    
    func pickUp() {
        canEat.lock()
        
    }
    
    func putDown() {
        canEat.unlock()
    }
}

class Developer {
    let name: String
    let lSpoon: Spoon
    let rSpoon: Spoon
    
    init(name: String, leftSpoon: Spoon, rightSpoon: Spoon) {
        self.name = name
        self.lSpoon = leftSpoon
        self.rSpoon = rightSpoon
    }
    
    func think() {
        print("Dev \(self.name) is waiting to eat")
        if lSpoon.id < rSpoon.id {
            lSpoon.pickUp()
            print("\(name) picked up the left spoon \(lSpoon.id)")
            rSpoon.pickUp()
            print("\(name) picked up the right spoon \(rSpoon.id)")
        } else {
            rSpoon.pickUp()
            print("\(name) picked up the right spoon \(rSpoon.id)")
            lSpoon.pickUp()
            print("\(name) picked up the left spoon \(lSpoon.id)")
        }
    }
    
    func eat() {
        print("\(name) is slurping their soup")
        usleep(1_000_000)
        lSpoon.putDown()
        print("\(name) put down the left spoon \(lSpoon.id)")
        rSpoon.putDown()
        print("\(name) put down the right spoon \(rSpoon.id)")
    }
    
    func run() {
        while true{
            self.think()
            self.eat()
        }
    }
}


let spoon1 = Spoon(1)
let spoon2 = Spoon(2)
let spoon3 = Spoon(3)
let spoon4 = Spoon(4)
let spoon5 = Spoon(5)


let developer1 = Developer(name: "Bohdan", leftSpoon: spoon1, rightSpoon: spoon2)
let developer2 = Developer(name: "Alex", leftSpoon: spoon2, rightSpoon: spoon3)
let developer3 = Developer(name: "Zeze", leftSpoon: spoon3, rightSpoon: spoon4)
let developer4 = Developer(name: "Rocket", leftSpoon: spoon4, rightSpoon: spoon5)
let developer5 = Developer(name: "Bri", leftSpoon: spoon5, rightSpoon: spoon1)


let devArray = [developer1, developer2, developer3, developer4, developer5]

 DispatchQueue.concurrentPerform(iterations: 5) {
    devArray[$0].run()
}
