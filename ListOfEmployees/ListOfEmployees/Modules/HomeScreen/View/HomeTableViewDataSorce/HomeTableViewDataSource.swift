//
//  HomeTableViewDataSource.swift
//  CoreDataApp
//
//  Created by Vasil Vertiporokh on 03.09.2022.
//

import UIKit
import CoreData

protocol HomeTableViewDataSourceDelegate: AnyObject {
    func getRemovedEmployee(employee: Employee)
}

final class HomeTableViewDataSource: NSObject {
    // MARK: - Private Properties
    private let context: NSManagedObjectContext
    private weak var delegate: FetchedResultsControllerDelegate!
    private let sectionSortDescriptor = NSSortDescriptor(key: Constants.sectionDescriptor, ascending: true)
    private let employeeSortDescriptor = NSSortDescriptor(key: Constants.employeeDescriptor, ascending: true)
    
    lazy private(set) var fetchResultController: NSFetchedResultsController<Employee> = {
        let fetchRequest = Employee.fetchRequest()
        fetchRequest.sortDescriptors = [sectionSortDescriptor, employeeSortDescriptor]
        
        let fetchResultController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: Constants.sectionDescriptor,
            cacheName: nil
        )
        
        fetchResultController.delegate = delegate
        
        return fetchResultController
    }()
    
    // MARK: - Internal properties
    weak var dataSourceDelegate: HomeTableViewDataSourceDelegate?
    
    // MARK: - Init
    init(_ context: NSManagedObjectContext, delegate: FetchedResultsControllerDelegate) {
        self.context = context
        self.delegate = delegate
        
        super.init()
        try! fetchResultController.performFetch()
    }
}


extension HomeTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        fetchResultController.sections?[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        fetchResultController.sections?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchResultController.sections else {
            return .zero
        }
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let department = fetchResultController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(cellType: EmployeeInfoCell.self, indexPath: indexPath)
        cell.setUserData(employee: department)
        return cell
    }
     
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSourceDelegate?.getRemovedEmployee(employee: fetchResultController.object(at: indexPath))
        }
    }
}

// MARK: - Constants
private struct Constants {
    static let sectionDescriptor: String = "employeeToDepartment.nameOfDepartment"
    static let employeeDescriptor: String = "name"
}
