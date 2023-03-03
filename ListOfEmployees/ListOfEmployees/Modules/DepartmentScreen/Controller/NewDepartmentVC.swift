//
//  NewDepartmentVC.swift
//  ListOfEmployees
//
//  Created by Андрей on 1.9.22.
//

import UIKit
import CoreData

class NewDepartmentVC: UIViewController {
    
    @IBOutlet private var departmentCreationView: DepartmentCreationView!
    private let model = DepartmentCreationModel()
    var department: Department?

    override func viewDidLoad() {
        super.viewDidLoad()
        departmentCreationView.delegate = self
    }
    
    @IBAction private func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func saveButtonPressed(_ sender: UIBarButtonItem) {
        saveDepartment()
    }
    
    private func saveDepartment(){
        if departmentCreationView.isValid {
            if model.getDepartments().filter({$0.nameOfDepartment == departmentCreationView.departmentToSave}).isEmpty {
                
                departmentCreationView.saveNewDepartment()
                dismiss(animated: true, completion: nil)
            } else {
                showWorningAlert(title: "Input error", message: "Such a department already exists")
            }
        
        } else {
            showWorningAlert(title: "Input error", message: "The fields must be filled in")
        }
    }
    
    private func showWorningAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension NewDepartmentVC: DepartmentCreationViewDelegate {
    func departmentInfo(departmentName: String, departmentDescription: String) {
        model.addNewDepartment(departmentName, departmentDescription)
    }
}
