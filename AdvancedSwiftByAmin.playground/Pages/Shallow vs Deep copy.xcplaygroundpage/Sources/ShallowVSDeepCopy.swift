//
//  ShallowVSDeepCopy.swift
//  
//
//  Created by Amin Torabi on 8/4/1403 AP.
//

import Foundation

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

struct Employee {
    var id: Int
    var personInfo: Person
}

public func createShallowCopy() {
    // Create an instance of Person
    let originalPerson = Person(name: "Alice")

    // Create an Employee struct containing the Person instance
    var originalEmployee = Employee(id: 1, personInfo: originalPerson)

    // Assign originalEmployee to a new variable (shallow copy)
    var copiedEmployee = originalEmployee

    // Modify the reference type property in copiedEmployee
    copiedEmployee.personInfo.name = "Bob"

    // Modify the value type property in copiedEmployee
    copiedEmployee.id = 2

    // Check the results
    print("Original Employee ID: \(originalEmployee.id)") // Outputs: 1
    print("Original Employee Person Name: \(originalEmployee.personInfo.name)") // Outputs: Bob

    print("Copied Employee ID: \(copiedEmployee.id)") // Outputs: 2
    print("Copied Employee Person Name: \(copiedEmployee.personInfo.name)") // Outputs: Bob

}

// MARK: - Deep copy

// Extend Person to support copying
extension Person {
    func clone() -> Person {
        return Person(name: self.name)
    }
}

// Modify Employee to perform a deep copy
extension Employee {
    func deepCopy() -> Employee {
        return Employee(id: self.id, personInfo: self.personInfo.clone())
    }
}

public func createDeepCopy() {
    // Perform a deep copy
    let originalPerson = Person(name: "Alice")

    // Create an Employee struct containing the Person instance
    var originalEmployee = Employee(id: 1, personInfo: originalPerson)
    
    var deepCopiedEmployee = originalEmployee.deepCopy()
    deepCopiedEmployee.personInfo.name = "Charlie"

    print("Original Employee Person Name: \(originalEmployee.personInfo.name)") // Outputs: Bob
    print("Deep Copied Employee Person Name: \(deepCopiedEmployee.personInfo.name)") // Outputs: Charlie

}


public func deepDataCopy() {
    
    // Step 1: Create an initial Data instance
    var data1 = Data([0x01, 0x02, 0x03])
    
    // Step 2: Assign data1 to data2 (shallow copy)
    var data2 = data1
    
    print("Before mutation:")
    print("data1: \(data1 as NSData)")
    print("data2: \(data2 as NSData)")
    
    // Step 3: Mutate data2
    data2.append(0x04)
    
    print("\nAfter mutation:")
    print("data1: \(data1 as NSData)")
    print("data2: \(data2 as NSData)")
    
    print(">>> Mutating data2 did not affect data1 <<<<")

}


public func implementCopyOnWrite() {
    // Reference type (class) that holds data
    class Storage {
        var value: Int
        init(value: Int) {
            self.value = value
        }
    }

    // Value type (struct) that wraps the Storage class
    struct MyStruct {
        private var storage: Storage

        init(value: Int) {
            self.storage = Storage(value: value)
        }

        // Accessor for the value
        var value: Int {
            get { storage.value }
            set {
                // Copy-on-Write Implementation
                if !isKnownUniquelyReferenced(&storage) {
                    // Storage is shared; create a new instance
                    storage = Storage(value: newValue)
                } else {
                    // Storage is unique; modify directly
                    storage.value = newValue
                }
            }
        }
    }

    // Usage
    var a = MyStruct(value: 10)
    var b = a  // Shallow copy; storage is shared

    print("Before mutation:")
    print("a.value = \(a.value)") // Outputs 10
    print("b.value = \(b.value)") // Outputs 10

    // Mutate b's value
    b.value = 20  // Triggers copy-on-write

    print("\nAfter mutation:")
    print("a.value = \(a.value)") // Outputs 10
    print("b.value = \(b.value)") // Outputs 20
}

