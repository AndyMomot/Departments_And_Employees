//
//  EmployeeCreationModel.swift
//  ListOfEmployees
//
//  Created by Андрей on 5.9.22.
//

import Foundation
import CoreData

final class EmployeeCreationModel {
    // MARK: - Internal Properties
    lazy private(set) var context: NSManagedObjectContext = stack.viewContext
    
    // MARK: - Private properties
    lazy private var houseService: CompanyServiceProtocol = CompanyService(stack)
    private let stack = CoreDataStack.shared
    
    func getDepartments() -> [Department] {
        houseService.fetchDepartments()
    }
    
    func addNewEmployee(_ name: String?,_ lastName: String?,_ department: Department, _ imagePath: String?) {
        guard let name = name,
              let lastName = lastName,
              let imagePath = imagePath
        else {
            return
        }
        
        houseService.addEmployee(name: name, surname: lastName, department: department, imagePath: imagePath)
    }
}
