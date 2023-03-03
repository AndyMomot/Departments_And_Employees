//
//  NewEmployeeVC.swift
//  ListOfEmployees
//
//  Created by Андрей on 31.8.22.
//

import UIKit
import CoreData

enum State {
    case creating
    case editing
}

class NewEmployeeVC: UIViewController {
    
    @IBOutlet var employeeCreationView: EmployeeCreationView!
    @IBOutlet private weak var navigationBar: UINavigationItem!
    
    // MARK: - Private properties
    private let model = EmployeeCreationModel()
    var state: State = .creating  
    
    var employee: Employee?
    var navigationTitle: String?
    var descriptionIsHidden = false
    var isEditingNow = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = navigationTitle
        employeeCreationView.delegate = self
        employeeCreationView.setDepartments(model.getDepartments())
        employeeCreationView.fillInTheEmployeeDataFields(employee: employee)
        employeeCreationView.hideTheDepartmentalPicker()
        
        employeeCreationView.setModeFor(state: state)
    }
    
    @IBAction private func cancelButtonPressed(_ sender: UIBarButtonItem) {
        isEditingNow = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func saveButtonPressed(_ sender: UIBarButtonItem) {
        switch state {
        case .creating:
            if employeeCreationView.validationCheck() {
                employeeCreationView.createNewEmployee()
                dismiss(animated: true, completion: nil)
            } else {
                showWorningAlert()
            }
            
        case .editing:
            if employeeCreationView.validationCheck() {
                employeeCreationView.editEmployeeInfo(employee: employee)
                dismiss(animated: true, completion: nil)
            } else {
                showWorningAlert()
            }
        }
    }
    @IBAction func choosePhotoPressed(_ sender: UIButton) {
        employeeCreationView.openPhotoPicker(viewController: self)
    }
    
    
    private func showWorningAlert() {
        let alertController = UIAlertController(title: "Input error", message: "The fields must be filled in", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Internal extension
extension NewEmployeeVC: EmployeeCreationViewDelegate {
    func selectedDepartment(name: String?, lastName: String?, department: Department, imagePath: String?) {
        model.addNewEmployee(name, lastName, department, imagePath)
    }
}

extension NewEmployeeVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       return isEditingNow
    }
}
