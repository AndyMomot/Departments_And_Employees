//
//  EmployeeCreationView.swift
//  ListOfEmployees
//
//  Created by Андрей on 5.9.22.
//

import UIKit
import Photos
import  PhotosUI

protocol EmployeeCreationViewDelegate: AnyObject {
    func selectedDepartment(name: String?, lastName: String?, department: Department, imagePath: String?)
}

class EmployeeCreationView: UIView, PHPickerViewControllerDelegate {
    
    // MARK: Private Outlets
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var chosePhotoButton: UIButton!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameTxtFld: UITextField!
    @IBOutlet private weak var surnameTxtFld: UITextField!
    @IBOutlet private weak var deprtmentTxtFld: UITextField! {
        didSet {
            deprtmentTxtFld.inputView = UIView(frame: .zero)
            deprtmentTxtFld.addTarget(self, action: #selector(choseDepartment), for: .editingDidBegin)
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var descriptionTxtFld: UITextField!
    @IBOutlet private weak var departmentPickerView: UIPickerView!
    
    // MARK: - Internal properties
    weak var delegate: EmployeeCreationViewDelegate?
    
    // MARK: - Private properties
    private let fileManager = LocalFileManager.instence
    private var departments: [Department]?
    private var selectedDepartment: Department?
    
    private var editStarted = false {
        didSet {
            switch editStarted {
            case true:
                canEdit(is: true)
                editButton.setImage("canEdit.png".setAsImage, for: .normal)
                chosePhotoButton.isHidden = false
            case false:
                canEdit(is: false)
                editButton.setImage("edit.png".setAsImage, for: .normal)
                hideTheDepartmentalPicker()
                chosePhotoButton.isHidden = true
            }
        }
    }
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        conformToDelegate()
    }
    
    func hideTheDepartmentalPicker() {
        departmentPickerView.isHidden = true
    }
    
    @objc private func choseDepartment() {
        departmentPickerView.isHidden = false
    }
    
    @IBAction private func editPressed(_ sender: UIButton) {
        editStarted = !editStarted
    }
    
    @IBAction private func chosePhotoPressed(_ sender: UIButton) {
    }
    
    private func conformToDelegate() {
        departmentPickerView.delegate = self
        departmentPickerView.dataSource = self
    }
}

extension EmployeeCreationView {
    func setDepartments(_ departments: [Department]) {
        self.departments = departments
    }
    
    public static func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> URL? {
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.pngData() {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileURL
        }
        return nil
    }
    
    private func saveProfileImage() -> String {
        let uniqueImageName = UUID().uuidString
        let sentImage = self.profileImageView.image!
        
        self.fileManager.saveImageInDocumentDirectory(image: sentImage, fileName: uniqueImageName)
        
        return uniqueImageName
    }
    
    func createNewEmployee() {
        
        let uniqueImageName = saveProfileImage()
        guard let departments = departments else { return }
        
        delegate?.selectedDepartment(
            name: nameTxtFld.text,
            lastName: surnameTxtFld.text,
            department: selectedDepartment ?? departments[.zero],
            imagePath: uniqueImageName
        )
    }
    
    func fillInTheEmployeeDataFields(employee: Employee?) {
        
        guard let employee = employee else { return }
        nameTxtFld.text = employee.name
        surnameTxtFld.text = employee.surname
        deprtmentTxtFld.text = employee.employeeToDepartment?.nameOfDepartment
        descriptionTxtFld.text = employee.employeeToDepartment?.descriptionOfDepartment
        profileImageView.image = self.fileManager.loadImageFromDocumentDirectory(fileName: employee.profileImage!)
    }
    
    private func canEdit(is bool: Bool) {
        [
            nameTxtFld,
            surnameTxtFld,
            deprtmentTxtFld,
            descriptionTxtFld
        ].forEach({$0.isUserInteractionEnabled = bool})
    }
    
    private func hiddenSomeElements(is bool: Bool) {
        [
            editButton,
            descriptionLabel,
            descriptionTxtFld
        ].forEach({$0.isHidden = bool})
    }
    
    func setModeFor(state: State) {
        switch state {
        case .creating:
            canEdit(is: true)
            hiddenSomeElements(is: true)
            chosePhotoButton.isHidden = false
        case .editing:
            canEdit(is: false)
            hiddenSomeElements(is: false)
            chosePhotoButton.isHidden = true
        }
    }
    
    func editEmployeeInfo(employee: Employee?) {
        let unicImageName = saveProfileImage()
        
        guard let employee = employee else { return }
        employee.name = nameTxtFld.text
        employee.surname = surnameTxtFld.text
        employee.profileImage = unicImageName
        if selectedDepartment != nil {
            employee.employeeToDepartment = selectedDepartment
        }
    }
    
    func validationCheck() -> Bool {
        if !nameTxtFld.text!.isEmpty && !surnameTxtFld.text!.isEmpty && !deprtmentTxtFld.text!.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    @available(iOS 14, *)
    func openPhotoPicker(viewController: UIViewController) {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        viewController.present(vc, animated: true, completion: nil)
    }
    
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let provider = results.first?.itemProvider else { return }
        
        let group = DispatchGroup()
        
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                defer {
                    group.leave()
                }
                
                guard let image = reading as? UIImage, error == nil else { return }
                
                group.notify(queue: .main) {
                    self.profileImageView.image = image
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


extension EmployeeCreationView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments?.count ?? .zero
    }
}

extension EmployeeCreationView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let nameOfDepartment = departments?.compactMap { $0.nameOfDepartment }
        guard let nameOfDepartment = nameOfDepartment else {
            return Constants.emptyString
        }
        return nameOfDepartment[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let department = departments else { return }
        selectedDepartment = department[row]
        deprtmentTxtFld.text = department[row].nameOfDepartment
        departmentPickerView.isHidden = true
    }
}

// MARK: - Constants
private struct Constants {
    static let emptyString: String = ""
    static let numberOfComponents: Int = 1
}
