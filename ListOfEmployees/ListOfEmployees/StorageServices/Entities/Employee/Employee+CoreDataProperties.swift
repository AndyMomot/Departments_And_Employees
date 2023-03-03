//
//  Employee+CoreDataProperties.swift
//  ListOfEmployees
//
//  Created by Андрей on 6.9.22.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var profileImage: String?
    @NSManaged public var surname: String?
    @NSManaged public var employeeToDepartment: Department?

}

extension Employee : Identifiable {

}
