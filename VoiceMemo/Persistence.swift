//
//  Persistence.swift
//  Coredata+SwiftUI
//
//  Created by Takuya Hara on 2021/04/03.
//

import CoreData
import Foundation

class PersistenceController {
    static let shared = PersistenceController()
    private let persistentContainer: NSPersistentContainer = {
        let storeURL = FileManager.appGroupContainerURL.appendingPathComponent("Memo")
 
        let container = NSPersistentContainer(name: "Memo")
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: storeURL)]
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        return container
    }()
}

extension PersistenceController {
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var workingContext: NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = managedObjectContext
        return context
    }
}

extension FileManager{
    static let appGroupContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.JS28CJ2CCH.VoiceMemo")!
}
