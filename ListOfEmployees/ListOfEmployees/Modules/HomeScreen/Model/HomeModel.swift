//
//  HomeModel.swift
//  CoreDataApp
//
//  Created by Vasil Vertiporokh on 31.08.2022.
//

import UIKit
import CoreData

final class HomeModel {
    // MARK: - Internal Properties
    lazy private(set) var context: NSManagedObjectContext = stack.viewContext
    
    // TODO: - Переймфнувати цю всю залупу
    
    // MARK: - Private properties
    lazy private var houseService: CompanyServiceProtocol = CompanyService(stack)
    private let stack = CoreDataStack.shared
}

// MARK: - Internal extension
extension HomeModel {
    func showSelectedEmployee(navigationController: UINavigationController?, vc: UIViewController) {
        guard let navigationController = navigationController else {
            vc.present(vc, animated: true)
            return
        }
        
        //vc.self.present(vc, animated: true, completion: nil)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func deleteEmployee(_ employee: Employee) {
        houseService.deleteEmployee(employee: employee)
    }
    
    func getDepartments() -> [Department] {
        houseService.fetchDepartments()
    }
}
