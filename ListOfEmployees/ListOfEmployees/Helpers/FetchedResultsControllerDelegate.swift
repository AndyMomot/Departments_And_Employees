//
//  FetchedResultsControllerDelegate.swift
//  CoreDataDemo
//
//  Created by Artem Kvasnetskyi on 15.08.2022.
//

import CoreData
import UIKit

final class FetchedResultsControllerDelegate: NSObject {
    // MARK: - Private Properties
    private weak var tableView: UITableView!
    
    // MARK: - Init
    init(_ tableView: UITableView) {
        self.tableView = tableView
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension FetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange sectionInfo: NSFetchedResultsSectionInfo,
        atSectionIndex sectionIndex: Int,
        for type: NSFetchedResultsChangeType
    ) {
        switch type {
        case .insert:
            tableView.insertSections([sectionIndex], with: .automatic)
            
        case .delete:
            tableView.deleteSections([sectionIndex], with: .automatic)
            
        default: break
        }
    }
    
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
         
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
            
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            
        default: break
        }
    }
    
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        tableView.endUpdates()
    }
    
    // Diffable Datasource example
//    func controller(
//        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
//        didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference
//    ) {
//        var diff = NSDiffableDataSourceSnapshot<Int, House>() // Int – section, House – item
//        snapshot.sectionIdentifiers.forEach { section in
//            diff.appendSections([section as! Int])
//
//            let items = snapshot.itemIdentifiersInSection(withIdentifier: section)
//                .map { (objectId: Any) -> House in
//                    let objectId = objectId as! NSManagedObjectID
//                    return controller
//                        .managedObjectContext
//                        .object(with: objectId) as! House
//                }
//
//            diff.appendItems(items, toSection: section as? Int)
//        }
//
//        dataSource?.apply(diff)
//    }
}
