//
//  Gallery+Extensions.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 05/08/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import CoreData

extension Gallery {
    
    /// Fetch all gallery from core data.
    static func fetchAll(fromContext viewContext: NSManagedObjectContext) -> [Gallery] {
        
        // Create a request
        let request: NSFetchRequest<Gallery> = Gallery.fetchRequest()
        
        // Create a sort descriptor
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        // Fetching the request
        do {
            let result = try viewContext.fetch(request)
            return result
        } catch {
            print("Failed to fetch all gallery: \(error)")
            return []
        }
    }
    
    /// Updates the core data contents of the specified gallery id
    static func update(toContext viewContext: NSManagedObjectContext, withId id: Int32, imageId: Int) {
        let predicate = NSPredicate(format: "id == %i", id)
        
        let request = NSFetchRequest<Gallery>(entityName: "Gallery")
        request.predicate = predicate
        
        do {
            guard let result = try viewContext.fetch(request).first else { return }
            result.count += 1
            result.images?[imageId] = 1
            
            try viewContext.save()
        } catch {
            print("Failed to fetch score: \(error)")
        }
    }
    
    /// Loads all the intial state data of gallery to core data. Only call this function ONCE during the first installation of the app.
    static func configureInitialState(toContext viewContext: NSManagedObjectContext) {
        
        if isConfigured(in: viewContext) { return }
        
        // Create initial entry
        let firstGallery = Gallery(context: viewContext)
        firstGallery.id = 0
        firstGallery.count = 0
        firstGallery.images = [0, 0]
        
        let secondGallery = Gallery(context: viewContext)
        secondGallery.id = 1
        secondGallery.count = 0
        secondGallery.images = [0, 0]
        
        let thirdGallery = Gallery(context: viewContext)
        thirdGallery.id = 2
        thirdGallery.count = 0
        thirdGallery.images = [0, 0]
        
        let fourthGallery = Gallery(context: viewContext)
        fourthGallery.id = 3
        fourthGallery.count = 0
        fourthGallery.images = [0, 0]
        
        // Save the gallery object to core data
        do {
            try viewContext.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    /// Deletes all gallery from core data.
    static func deleteAll(context viewContext: NSManagedObjectContext) {

        // Create a batch delete request
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Gallery")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try viewContext.execute(batchDeleteRequest)
        } catch {
            print("Failed to delete all scores: \(error)")
        }
    }
}

// MARK: - Helper Functions

extension Gallery {
    
    /// Returns true if the initial core data contents is already configured, otherwise returns false.
    private static func isConfigured(in viewContext: NSManagedObjectContext) -> Bool {
        let result = fetchAll(fromContext: viewContext)
        
        if result.isEmpty {
            return false
        } else {
            return true
        }
    }
}
