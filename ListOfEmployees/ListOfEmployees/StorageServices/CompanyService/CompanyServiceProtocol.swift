//
//  CompanyServiceProtocol.swift
//  CoreDataApp
//
//  Created by Vasil Vertiporokh on 03.09.2022.
//

import Foundation
import CoreData

protocol CompanyServiceProtocol {
    func fetchDepartments() -> [Department]
    func addDepartment(departmentName: String, departmentDescription: String)
    func addEmployee(name: String, surname: String, department: Department, imagePath: String)
    func saveContext()
    func deleteEmployee(employee: Employee)
    func deleteDepartment(department: Department)
    func editEmployee(employee: Employee, name: String, surname: String) 
}

