// Delegate that can only be used on Class types
protocol DogDelegate: class {
    
    func dogWantsFood()
    
}

// An enum just for a little flare
enum Breed {
    case Labrador
    case Beagle
    case NewFoundland
    case Husky
}

// Dog class that controls the calling of the delegate
public class Dog {
    
    weak var delegate: DogDelegate?
    
    var name: String
    var breed: Breed
    
    var isHungry: Bool {
        didSet {
            if self.isHungry {
                // This is where the delegate method is called
                delegate?.dogWantsFood()
            }
        }
    }
    
    init(name: String, breed: Breed) {
        self.name = name
        self.breed = breed
        self.isHungry = false
    }
    
    deinit {
        print("Dog is deinitialized")
    }
    
}

// House class that recieves the call from the delgate
public class House: DogDelegate {
    
    var dog: Dog
    
    init(dog: Dog) {
        self.dog = dog
        self.dog.delegate = self // This incrementes ARC Count for dog
    }
    
    func dogWantsFood() {
        print("The dog wants food")
    }
    
    deinit {
        print("House is deinitialized")
    }
    
}

// Creation of Dog class
var dog: Dog? = Dog(name: "Sophie", breed: .NewFoundland) // ARC Count: Dog -> 1, House -> 0
// Creattion of House class, that takes in the dog
var house: House? = House(dog: dog!)                      // ARC Count: Dog -> 2, House -> 2
// This calls the delegate callback
dog!.isHungry = true

// This should only deallocate house
house = nil
// This should only deallocate dog
dog = nil

