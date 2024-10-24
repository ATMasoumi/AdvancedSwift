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
