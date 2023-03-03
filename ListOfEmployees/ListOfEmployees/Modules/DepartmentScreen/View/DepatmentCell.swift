//
//  DepatmentCell.swift
//  ListOfEmployees
//
//  Created by Андрей on 2.9.22.
//

import UIKit

class DepatmentCell: UITableViewCell {
    @IBOutlet weak var depLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
}

// MARK: - Private extension
private extension DepatmentCell {
    private func configureUI() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.7
    }
}
