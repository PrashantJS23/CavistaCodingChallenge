//
//  PersistenceManager.swift
//  SwiftApp
//
//  Created by WYH_MAC001 on 05/09/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager{
    
    private init() {}
    static let shared = PersistenceManager()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SwiftApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Saving support
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let fetchObjects = try context.fetch(fetchRequest) as? [T]
            return fetchObjects ?? [T]()
        }catch{
            print(error)
            return [T]()
        }
    }
        
    func delete(_ object: NSManagedObject){
        context.delete(object)
        save()
    }

    func deleteAll<T: NSManagedObject>(_ objectType: T.Type){
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(deleteRequest)
            save()
        }catch{
            print(error)
        }
    }
}
