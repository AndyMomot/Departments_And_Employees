//
//  HomeVC.swift
//  ListOfEmployees
//
//  Created by Андрей on 5.9.22.
//

import UIKit
import CoreData

class HomeVC: UIViewController {

    @IBOutlet private var homeView: HomeView!
    
    private let model = HomeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.delegate = self
    }
    
    @IBAction func showDepartamentsButton(_ sender: UIBarButtonItem) {
        showDepList()
    }
    
    @IBAction func addButtonPresssed(_ sender: UIBarButtonItem) {
        showAddAlertController()
    }
    
    private func showDepList() {
        let depListVC = UIStoryboard(name: .main).viewController(type: DepartmentTableVC.self)
        self.present(depListVC, animated: true, completion: nil)
    }
    
    private func showAddAlertController() {
        let alertController = UIAlertController(title: "Adding a new value!", message: "What would you like to add?", preferredStyle: .actionSheet)
        
        let personButton = UIAlertAction(title: "New Employee", style: .default) {_ in
            let newEmployeeVC = UIStoryboard(name: .main).viewController(type: NewEmployeeVC.self)
            newEmployeeVC.modalPresentationStyle = .fullScreen
            newEmployeeVC.navigationTitle = "Employee Creation"
            newEmployeeVC.descriptionIsHidden = true
            newEmployeeVC.state = .creating
            self.present(newEmployeeVC, animated: true, completion: nil)
        }
        
        let departmentButton = UIAlertAction(title: "New Department", style: .default) { _ in
            let newDepartmentVC = UIStoryboard(name: .main).viewController(type: NewDepartmentVC.self)
            newDepartmentVC.modalPresentationStyle = .fullScreen
            self.present(newDepartmentVC, animated: true, completion: nil)
        }
        
        
        if !model.getDepartments().isEmpty {
            alertController.addAction(personButton)
        }
        alertController.addAction(departmentButton)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Internal extension
extension HomeVC: HomeViewDelegate {
    func deleteEmployee(employee: Employee) {
        model.deleteEmployee(employee)
    }
    
    func getViewContext() -> NSManagedObjectContext {
        model.context
    }
    
    func getEmployee(employee: Employee) {
        let addEmployeeVC = UIStoryboard(name: .main).viewController(type: NewEmployeeVC.self)
        addEmployeeVC.employee = employee
        addEmployeeVC.state = .editing
        self.present(addEmployeeVC, animated: true, completion: nil)
    }
}
