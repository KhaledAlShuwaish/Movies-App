//
//  PersistenceService.swift
//  Elm_omdb
//
//  Created by Khaled Shuwaish on 25/03/2019.
//  Copyright © 2019 Khaled Shuwaish. All rights reserved.
//

import Foundation
import CoreData

class PersistenceServce {
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "FavoriteMoviesDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
