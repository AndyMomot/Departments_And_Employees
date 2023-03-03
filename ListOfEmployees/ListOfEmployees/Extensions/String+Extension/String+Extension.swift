//
//  String+Extension.swift
//  ListOfEmployees
//
//  Created by Андрей on 4.9.22.
//

import UIKit
extension String {
    var setAsImage: UIImage {
        return UIImage(named: self) ?? UIImage()
    }
}
