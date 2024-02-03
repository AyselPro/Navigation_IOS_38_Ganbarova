//
//  PostDataService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 28.12.2023.
//

import CoreData
import Foundation

protocol ICoreDataService {
    var context: NSManagedObjectContext { get }
    func saveContext()
}

final class CoreDataService: ICoreDataService {
    
    static let shared: ICoreDataService = CoreDataService()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: .coreDataBaseName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
                assertionFailure()
            }
        }
        return container
    }()
    
    private init() {}
    
    func saveContext() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            assertionFailure("Save error with \(error)")
        }
    }
}

private extension String {
    static let coreDataBaseName = "Model"
}
