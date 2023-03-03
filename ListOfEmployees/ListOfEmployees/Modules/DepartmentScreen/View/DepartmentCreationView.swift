//
//  DepartmentCreationView.swift
//  ListOfEmployees
//
//  Created by Андрей on 5.9.22.
//

import UIKit

protocol DepartmentCreationViewDelegate: AnyObject {
    func departmentInfo(departmentName: String, departmentDescription: String)
}

class DepartmentCreationView: UIView {
    @IBOutlet weak var departmentNameLabel: UILabel!
    @IBOutlet weak var departmentDescriptionLabel: UILabel!
    @IBOutlet weak var departmentNameTxtField: UITextField!
    @IBOutlet weak var depDescriptionTxtField: UITextField!
    
    weak var delegate: DepartmentCreationViewDelegate?
    var isValid: Bool {
        if !departmentNameTxtField.text!.isEmpty || !depDescriptionTxtField.text!.isEmpty {
            return true
        } else {
            return false
        }
    }
    lazy var departmentToSave = departmentNameTxtField.text
}

// MARK: - Internal extension
extension DepartmentCreationView {
    func saveNewDepartment() {
        guard let departmentName = departmentNameTxtField.text,
              let departmentDescription = depDescriptionTxtField.text else {
            return
        }
        delegate?.departmentInfo(
            departmentName: departmentName,
            departmentDescription: departmentDescription
        )
    }
}
