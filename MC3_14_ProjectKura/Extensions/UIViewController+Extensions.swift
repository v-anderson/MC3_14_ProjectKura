//
//  UIViewController+Extensions.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 21/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    /// Sets the background environment according to the score
    func setupBackgroundByScore() {
        
        // Get the last updated date
        guard let lastUpdatedDate = UserDefaults.standard.object(forKey: "last_updated") as? Date else {
            UserDefaults.standard.set(Date(), forKey: "last_updated")
            return
        }
        print("Last updated at: \(lastUpdatedDate)")
        
        // Only update background every 3 days
        if Date.daysAfter(date: lastUpdatedDate) <= 3 { return }
        
        // Fetch the score from the last 3 days
        guard let day1 = Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            let day2 = Calendar.current.date(byAdding: .day, value: -2, to: Date()),
            let day3 = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
                
        let score1 = Score.fetch(fromContext: getViewContext(), forDate: day1)
        let score2 = Score.fetch(fromContext: getViewContext(), forDate: day2)
        let score3 = Score.fetch(fromContext: getViewContext(), forDate: day3)
        
        // Calculate final score
        let finalScore = (score1?.score ?? 0) + (score2?.score ?? 0) + (score3?.score ?? 0)
        print(finalScore)
        
        // TODO: - Set the background by final score
        
        
        // Update the last updated date
        UserDefaults.standard.set(Date(), forKey: "last_updated")
    }
            
    /// Returns the persistent container's view context
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
