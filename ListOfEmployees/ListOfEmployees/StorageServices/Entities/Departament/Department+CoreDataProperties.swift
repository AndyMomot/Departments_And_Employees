//
//  Department+CoreDataProperties.swift
//  ListOfEmployees
//
//  Created by Андрей on 6.9.22.
//
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var descriptionOfDepartment: String?
    @NSManaged public var id: UUID?
    @NSManaged public var nameOfDepartment: String?
    @NSManaged public var departmentToEployee: NSSet?

}

// MARK: Generated accessors for departmentToEployee
extension Department {

    @objc(addDepartmentToEployeeObject:)
    @NSManaged public func addToDepartmentToEployee(_ value: Employee)

    @objc(removeDepartmentToEployeeObject:)
    @NSManaged public func removeFromDepartmentToEployee(_ value: Employee)

    @objc(addDepartmentToEployee:)
    @NSManaged public func addToDepartmentToEployee(_ values: NSSet)

    @objc(removeDepartmentToEployee:)
    @NSManaged public func removeFromDepartmentToEployee(_ values: NSSet)

}

extension Department : Identifiable {

}
