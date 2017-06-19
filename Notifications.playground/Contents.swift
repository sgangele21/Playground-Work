// Practicing with NSNotfications
import UIKit

protocol Predator {
    func hunt() -> Void
}

protocol Prey {
    func run() -> Void
}

enum Age {
    case adult
    case baby
    case teen
}

public class Tiger: Predator {
    
    var age: Age
    
    init(age: Age) {
        self.age = age
    }
    
    func hunt() {
        print("Hunting the prey now")
        NotificationCenter.default.post(name: NSNotification.Name("PredatorHunting"), object: nil)
    }
    
}


public class Wildebeest: Prey {
    
    var age: Age
    
    init(age: Age) {
        self.age = age
        NotificationCenter.default.addObserver(self, selector: #selector(run), name: NSNotification.Name(rawValue: "PredatorHunting"), object: nil)
    }
    
    @objc func run() {
        print("I'm running away from the predator!")
    }
    
}


let tigress = Tiger(age: .adult)
let wildebeest = Wildebeest(age: .baby)
// Currently nothing is printing


tigress.hunt()
// Right here, a notification is posted by a completely different class, and helps save the wildebeast by notifying it to run
// Getting more technical, notifcations allow communication between one two or more objects, without them ever knowing they existed. This can be powerful when dealing with things like logging out of a system. when you log out, you can have some other entity perform some task, without having to coupling of objects. But, this makes it hard to follow logic, as the posting and observing can be in two different files








