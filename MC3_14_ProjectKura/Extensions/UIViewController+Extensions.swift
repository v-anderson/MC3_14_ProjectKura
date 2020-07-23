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
    
    /// Calculate final score
    func calculateFinalScore() -> Int? {
        
        // Get the last updated date
        guard let lastUpdatedDate = UserDefaults.standard.object(forKey: "last_updated") as? Date else {
            UserDefaults.standard.set(Date(), forKey: "last_updated")
            return nil
        }
        print("Last updated at: \(lastUpdatedDate)")
        
        // Only update background every 3 days
        if Date.daysAfter(date: lastUpdatedDate) <= 3 { return nil }
        
        // Fetch the score from the last 3 days
        guard let day1 = Calendar.current.date(byAdding: .day, value: 0, to: Date()),
            let day2 = Calendar.current.date(byAdding: .day, value: -2, to: Date()),
            let day3 = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return nil }
                
        let score1 = Score.fetch(fromContext: getViewContext(), forDate: day1)
        let score2 = Score.fetch(fromContext: getViewContext(), forDate: day2)
        let score3 = Score.fetch(fromContext: getViewContext(), forDate: day3)
        
        print("Score 1: \(score1?.score)")
        print("Score 2: \(score2?.score)")
        print("Score 3: \(score3?.score)")
        
        // Calculate final score
        let finalScore = (score1?.score ?? 0) + (score2?.score ?? 0) + (score3?.score ?? 0)
        print(finalScore)
        
        UserDefaults.standard.set(finalScore, forKey: "last_score")
        
        return Int(finalScore)
    }
            
    /// Returns the persistent container's view context
    func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /// Returns true if current time is between 06.00 - 14:59
    func isMorning() -> Bool {
        let now = Date()
        let sixToday = Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: now)!
        let fifteenToday = Calendar.current.date(bySettingHour: 14, minute: 59, second: 59, of: now)!
        
        if now >= sixToday && now <= fifteenToday {
            print("Time is between 6.00 - 14.59")
            return true
        }
        return false
    }
    
    /// Returns true if current time is between 15:00 - 17:59
    func isAfternoon() -> Bool {
        let now = Date()
        let fifteenToday = Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: now)!
        let eighteenToday = Calendar.current.date(bySettingHour: 17, minute: 59, second: 59, of: now)!
        
        if now >= fifteenToday && now <= eighteenToday {
            print("Time is between 15.00 - 17.59")
            return true
        }
        return false
    }
    
    /// Returns true if current time is between 18.00 - 05.59
    func isNight() -> Bool {
        let now = Date()
        let eighteenToday = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: now)!
        let sixToday = Calendar.current.date(bySettingHour: 5, minute: 59, second: 59, of: now)!
        
        if now >= eighteenToday && now <= sixToday {
            print("Time is between 18.00 - 5:59")
            return true
        }
        return false
    }
}
