//
//  DepartmentModel.swift
//  ListOfEmployees
//
//  Created by Андрей on 5.9.22.
//

import Foundation
import CoreData

final class DepartmentCreationModel {
    // MARK: - Internal Properties
    lazy private(set) var context: NSManagedObjectContext = stack.viewContext
    
    // MARK: - Private properties
    lazy private var companyService: CompanyServiceProtocol = CompanyService(stack)
    private let stack = CoreDataStack.shared
    
    func getDepartments() -> [Department] {
        companyService.fetchDepartments()
    }
}

// MARK: - Internal extension
extension DepartmentCreationModel {
    func addNewDepartment(_ name: String,_ description: String) {
        companyService.addDepartment(departmentName: name, departmentDescription: description)
    }
}
