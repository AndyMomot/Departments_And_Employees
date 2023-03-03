//
//  CompanyService.swift
//  CoreDataApp
//
//  Created by Vasil Vertiporokh on 03.09.2022.
//

import Foundation
import CoreData

final class CompanyService {
    // MARK: - Private Properties
    private let stack: CoreDataStack
    
    // MARK: - Init
    init(_ stack: CoreDataStack) {
        self.stack = stack
    }
    
}

// MARK: - CompanyServiceProtocol
extension CompanyService: CompanyServiceProtocol {
    
    func saveContext() {
        guard stack.viewContext.hasChanges else { return }
        
        do {
            try stack.viewContext.save()
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchDepartments() -> [Department] {
        let request: NSFetchRequest<Department> = Department.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "nameOfDepartment", ascending: true)]
        var fetchedSingers: [Department] = []
        
        do {
            fetchedSingers = try stack.viewContext.fetch(request)
        } catch let error {
            print("Error fetching departments \(error)")
        }
        return fetchedSingers
    }
    
    func addDepartment(departmentName: String, departmentDescription: String) {
        let department = Department(context: stack.viewContext)
        department.id = UUID()
        department.nameOfDepartment = departmentName
        department.descriptionOfDepartment = departmentDescription
        saveContext()
    }
    
    func addEmployee(name: String, surname: String, department: Department, imagePath: String) {
        let employee = Employee(context: stack.viewContext)
        employee.id = UUID()
        employee.name = name
        employee.surname = surname
        employee.profileImage = imagePath
        department.addToDepartmentToEployee(employee)
        saveContext()
    }
    
    func deleteEmployee(employee: Employee) {
        let context = stack.viewContext
        context.delete(employee)
        saveContext()
    }
    
    func deleteDepartment(department: Department) {
        let context = stack.viewContext
        context.delete(department)
        saveContext()
    }
    
    // TODO: - Refactoring
    func editEmployee(employee: Employee, name: String, surname: String) {
        employee.name = name
        employee.surname = surname
        saveContext()
    }
}
