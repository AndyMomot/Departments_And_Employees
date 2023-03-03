//
//  Storyboard+Extension.swift
//  CoreDataApp
//
//  Created by Vasil Vertiporokh on 31.08.2022.
//

import UIKit

// MARK: - StoryboardsNames
enum StoryboardName: String {
    case main
    var id: String { return rawValue.capitalized }
}

extension UIStoryboard {
    convenience init(name: StoryboardName) {
        self.init(name: name.id, bundle: nil)
    }
    
    func viewController<T: UIViewController>(type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
