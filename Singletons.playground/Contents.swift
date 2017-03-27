// Class that will be a singleton
public class DatabaseReference {
    
    typealias ID = Int
    typealias databaseDict = [String: [ID : Any]]
    
    static let sharedInstance = DatabaseReference()
    private var values: databaseDict
    private var id: ID
    
    // I don't want this to be initiliazable. I want only one instance
    private init() {
        self.values = ["data": [:]]
        self.id = 0
    }
    
    func getValues() -> databaseDict {
        return self.values
    }
    
    func dataAutoID(value: Any) {
        self.values["data"]?[id] = value
        self.id += 1
    }
}

// Now, contactsRef has an instance of DatabaseReference
// When you first call the sharedInstance, it is initialized
let contactsRef = DatabaseReference.sharedInstance
contactsRef.dataAutoID(value: "Sahil Gangele")
contactsRef.dataAutoID(value: "Sophie Gangele")
contactsRef.dataAutoID(value: "Bruce Wayne")

// Everything is normal here, it simply prints the dictionary with the values added above
print(contactsRef.getValues())

// Now, let's create "another" instance
let newContactsRef = DatabaseReference.sharedInstance

// Notice it is the same instance as above. Hence, there is only a single instance. It is not initialzied again
// So, there is no "another" instance. There is only one instance
print(newContactsRef.getValues())
newContactsRef.dataAutoID(value: "Dick Grayson")

// Add values, and you can see that it is added to the existing values above. Static shares a global instance that can be modified anywhere in a project
print(newContactsRef.getValues())

