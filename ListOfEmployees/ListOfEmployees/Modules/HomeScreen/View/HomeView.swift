//
//  HomeView.swift
//  ListOfEmployees
//
//  Created by Андрей on 5.9.22.
//

import UIKit
import CoreData

protocol HomeViewDelegate: AnyObject {
    func getEmployee(employee: Employee)
    func deleteEmployee(employee: Employee)
    func getViewContext() -> NSManagedObjectContext
}

final class HomeView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    private var departments: [Department]?
    
    // MARK: - Private properties
    lazy private var fetchedResultsControllerDelegate = FetchedResultsControllerDelegate(tableView)
    lazy private var dataSource = HomeTableViewDataSource(
        delegate.getViewContext(),
        delegate: fetchedResultsControllerDelegate
    )
    
    // MARK: - Internal Properties
    weak var delegate: HomeViewDelegate!
    
    // MARK: - UIView life cycle
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        configureTableView()
        dataSource.dataSourceDelegate = self
    }
    
    func setDepartments(_ departments: [Department]) {
        self.departments = departments
    }
}

// MARK: - Private extension
private extension HomeView {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.registerNib(EmployeeInfoCell.self)
        tableView.separatorStyle = .none
    }
}

// MARK: - Internal extensions
extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.getEmployee(employee: dataSource.fetchResultController.object(at: indexPath))
    }
}

extension HomeView: HomeTableViewDataSourceDelegate {
    func getRemovedEmployee(employee: Employee) {
        delegate.deleteEmployee(employee: employee)
    }
}
