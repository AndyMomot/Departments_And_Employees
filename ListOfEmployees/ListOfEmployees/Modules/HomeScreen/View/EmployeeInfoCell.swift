//
//  EmployeeInfoCell.swift
//  ListOfEmployees
//
//  Created by Андрей on 5.9.22.
//

import UIKit

class EmployeeInfoCell: UITableViewCell {

    @IBOutlet weak var profilImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    
    private let fileManager = LocalFileManager.instence
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func setUserData(employee: Employee) {
        let image = fileManager.loadImageFromDocumentDirectory(fileName: employee.profileImage!)
        
        profilImage.image = image
        nameLabel.text = employee.name
        surnameLabel.text = employee.surname
    }
}

// MARK: - Private extension
private extension EmployeeInfoCell {
    private func configureUI() {
        cellUI()
        imageUI()
    }
    
    private func cellUI() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.7
    }
    
    private func imageUI() {
        self.profilImage.layer.cornerRadius = 40
    }
}
