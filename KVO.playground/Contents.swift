import UIKit

// The class that is going to be observed
public class Person: NSObject {
    // Properties that are observed need to have keyword dynamic
    // Dynamic dispatch is the process of selecting which implementation of a polymorphic   operation (method or function) to call at run time.
    public dynamic var age: Int
    private let name: String
    
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
}

// Class that does the observing
public class Employee: NSObject {
    private let person: Person
    private var salary = 50000
    private var changedAgeContext = 1
    
    init(person: Person, salary: Int) {
        self.person = person
        self.salary = salary
        super.init()
        // Add KVO to person property to watch for when the person changes it's age. We want to get it's old value and the new value that it's going to be changed to. And we need a way for KVO to differentiate from all the multiple observers we COULD have on person. So context differentiates it.
        self.person.addObserver(self, forKeyPath: "age", options: [.old, .new], context: &changedAgeContext)
    }
    
    // When an observer is added to an object, and the property observed changes, this method is fired
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("Something changed")
        // Our context is now checked
        if context == &self.changedAgeContext {
            // Now we need to parse through the change to get our old and new values
            if let newValue = change?[.newKey] as? Int, let oldValue = change?[.oldKey] as? Int {
                // If your age has increased, update the salary for the person
                if(newValue > oldValue) {
                    self.updateSalary(amount: 1000)
                }
            }
        }
    }
    
    private func updateSalary(amount: Int) {
        self.salary += 1000
        print("You're age has changed. Your salary has been updated to match senority")
    }
}

let sahil = Person(age: 19, name: "Sahil")
let employee = Employee(person: sahil, salary: 150000)
sahil.age += 1
