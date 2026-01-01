// Interface - C#
protocol CanFly {
    func fly()
}
class Bird {
    var isFemale = true
    func layEgg() {
        if isFemale {
            print("The bird makes a new bird in a shell.")
        }
    }
}
class Eagle: Bird, CanFly {
    func soar() {
        print("The eagle glides in the aire using air currents.")
    }
    func fly() {
        print("The eagle flasp its wings and lifts off intot the sky")
    }
}
class Penguin: Bird {
    func swim() {
        print("The penguin swims through the water.")
    }
}
struct FlyingMuseum {
    // Using the protocol as a data type
    func flyingDemo(flyingObject: CanFly)
    {
        flyingObject.fly()
    }
}
class Airplane: CanFly {
    func fly() {
        print("The airplane flies through the sky.")
    }
}
let myEagle = Eagle()
let myPenguin = Penguin()
let myPlane = Airplane()
//myPlane.layEgg() --- odd very odd
// How do we sepete the fly method alway from the inheritence.
myEagle.fly()
myPlane.fly()
myPenguin.swim()
let museum = FlyingMuseum()
museum.flyingDemo(flyingObject: myPlane)


