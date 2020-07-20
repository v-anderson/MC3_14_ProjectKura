//
//  Score+Extensions.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 20/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import CoreData
import UIKit

// MARK: - Score

extension Score {
    
    /// Fetch all scores from core data
    static func fetchAll(fromContext viewContext: NSManagedObjectContext) -> [Score] {
        
        // Create a request
        let request: NSFetchRequest<Score> = Score.fetchRequest()
        
        // Fetching the request
        do {
            let result = try viewContext.fetch(request)
            return result
        } catch {
            print("Failed to fetch all scores: \(error)")
            return []
        }
    }
    
    /// Checks if current date is already in entry and updates the data if needed
    static func updateIfNeeded(fromContext viewContext: NSManagedObjectContext, score: Int) -> Bool {
        
        // Get today's beginning & end
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd = Calendar.current.date(byAdding: .day, value: 1, to: todayStart)

        // Set predicate as date being today's date
        let fromPredicate = NSPredicate(format: "%@ >= %@", NSDate(), todayStart as NSDate)
        let toPredicate = NSPredicate(format: "%@ < %@", NSDate(), todayEnd! as NSDate)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        let request = NSFetchRequest<Score>(entityName: "Score")
        request.predicate = predicate
        
        do {
            guard let result = try viewContext.fetch(request).first else { return false }
            
            result.score += Int32(score)
            try viewContext.save()
            
            return true
        } catch {
            print("Failed to update entry: \(error)")
            return false
        }
    }
    
    /// Saves score to core data
    static func add(toContext viewContext: NSManagedObjectContext, score: Int) {
        
        // Returns immediately if there is an update
        if updateIfNeeded(fromContext: viewContext, score: score) { return }
        
        // Create a new entry
        let scoreObject = Score(context: viewContext)
        scoreObject.score = Int32(score)
        scoreObject.date = Date()
        
        // Save the score object to core data
        do {
            try viewContext.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    /// Deletes all scores from core data
    static func deleteAll(context viewContext: NSManagedObjectContext) {

        // Create a batch delete request
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Score")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try viewContext.execute(batchDeleteRequest)
        } catch {
            print("Failed to delete all scores: \(error)")
        }
    }
    
    /// Deletes all data that is older than one month
    static func deleteOldScores(context viewContext: NSManagedObjectContext) {

        let scores = fetchAll(fromContext: viewContext)
        
        do {
            // Iterates through all score objects
            for score in scores {
                if let date = score.date {
                    // Checks if score data is older than one month
                    if daysAfter(date: date) >= 30 {
                        print("Deleting data from a month ago: \(daysAfter(date: date))")
                        
                        // Deleting the object from core data
                        viewContext.delete(score)
                    }
                }
            }
            // Save all changes
            try viewContext.save()
        } catch {
            print("Failed to delete all scores: \(error)")
        }
    }
}

// MARK: - UIViewController

extension UIViewController {
    
    /// Returns the persistent container's view context
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
}

// MARK: - Score dates

extension Score {
    
    /// Calculates the amount of days after the current date
    private static func daysAfter(date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: date, to: Date())
        return components.day!
    }
}

