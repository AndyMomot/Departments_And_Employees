//
//  DepartmentTableVC.swift
//  ListOfEmployees
//
//  Created by Андрей on 2.9.22.
//

import UIKit
import CoreData

class DepartmentTableVC: UITableViewController {
    
    private let model = DepartmentCreationModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        showAddAlertController()
    }
    
    func showAddAlertController() {
        let alertController = UIAlertController(title: "Adding a new value!", message: "What would you like to add?", preferredStyle: .actionSheet)
        
        let departmentButton = UIAlertAction(title: "New Department", style: .default) { _ in
            
            let newDepartmentVC = self.storyboard!.instantiateViewController(withIdentifier: Constants.newDepartmentVCID) as! NewDepartmentVC
            newDepartmentVC.modalPresentationStyle = .fullScreen
            self.present(newDepartmentVC, animated: true, completion: nil)
        }

        alertController.addAction(departmentButton)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data sourceprint
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getDepartments().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath) as! DepatmentCell
        
        let department = model.getDepartments()[indexPath.row]
        cell.depLabel.text = department.nameOfDepartment
        cell.descriptionLabel.text = department.descriptionOfDepartment

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRowAt
    }
}

private struct Constants {
    static let numberOfSections: Int = 1
    static let heightForRowAt: CGFloat = 95
    static let cellName = "DepatmentCell"
    static let  newDepartmentVCID = "NewDepartmentVC"
}

