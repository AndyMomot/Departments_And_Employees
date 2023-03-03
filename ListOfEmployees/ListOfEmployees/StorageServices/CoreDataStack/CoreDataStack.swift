//
//  CoreDataStack.swift
//  CoreDataApp
//
//  Created by Vasil Vertiporokh on 02.09.2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    // MARK: Singleton
    static let shared = CoreDataStack()
    
    private init() {}
    
    // MARK: - Properties
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(
            forResource: Constants.modelName,
            withExtension: "momd"
        )
        
        guard let modelURL = modelURL,
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Find or Load Data Model")
        }

        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(
            managedObjectModel: self.managedObjectModel
        )

        let storeName = "\(Constants.modelName).sqlite"
        let documentsDirectoryURL = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask
        ).first!
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at: persistentStoreURL,
                options: nil
            )
            
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    private(set) lazy var viewContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return context
    }()
    
    private(set) lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        context.parent = viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
}

// MARK: - Constants
private struct Constants {
    static let modelName = "ListOfEmployees"
}
