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
        print("Last updated background at: \(lastUpdatedDate.description(with: .current))")
        
        // Only update background every 3 days
        guard let dateThreeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date()) else { return nil }
        let comparison = Calendar.current.compare(dateThreeDaysAgo, to: lastUpdatedDate, toGranularity: .day)
        if comparison == .orderedAscending { return nil }
        
        // Fetch the score from the last 3 days
        guard let day1 = Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            let day2 = Calendar.current.date(byAdding: .day, value: -2, to: Date()),
            let day3 = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return nil }
                        
        let score1 = Score.fetch(fromContext: getViewContext(), forDate: day1)
        let score2 = Score.fetch(fromContext: getViewContext(), forDate: day2)
        let score3 = Score.fetch(fromContext: getViewContext(), forDate: day3)
        
        print("Score 1: \(score1?.score ?? 0)")
        print("Score 2: \(score2?.score ?? 0)")
        print("Score 3: \(score3?.score ?? 0)")
        
        // Calculate final score
        let finalScore = (score1?.score ?? 0) + (score2?.score ?? 0) + (score3?.score ?? 0)
        
        UserDefaults.standard.set(finalScore, forKey: "last_score")
        
        if finalScore < 4 {
            if let blackHeartCount = diaryContents[.blackHeart]?.diaryImage.count {
                let randomIndex = Int.random(in: 0..<blackHeartCount)
                Gallery.update(toContext: getViewContext(), withId: 3, imageId: randomIndex)
                UserDefaults.standard.set(randomIndex,forKey: "indexDiaryImage")
                changeIcon(to: "KuraDirty")
            }
        } else if finalScore < 8 {
            if let yellowHeartCount = diaryContents[.yellowHeart]?.diaryImage.count {
                let randomIndex = Int.random(in: 0..<yellowHeartCount)
                Gallery.update(toContext: getViewContext(), withId: 2, imageId: randomIndex)
                UserDefaults.standard.set(randomIndex,forKey: "indexDiaryImage")
                changeIcon(to: "KuraDirty")
            }
        } else if finalScore < 12 {
            if let blueHeartCount = diaryContents[.blueHeart]?.diaryImage.count {
                let randomIndex = Int.random(in: 0..<blueHeartCount)
                Gallery.update(toContext: getViewContext(), withId: 1, imageId: randomIndex)
                UserDefaults.standard.set(randomIndex,forKey: "indexDiaryImage")
                changeIcon(to: nil)
            }
        } else {
            if let redHeartCount = diaryContents[.yellowHeart]?.diaryImage.count {
                let randomIndex = Int.random(in: 0..<redHeartCount)
                Gallery.update(toContext: getViewContext(), withId: 0, imageId: randomIndex)
                UserDefaults.standard.set(randomIndex,forKey: "indexDiaryImage")
                changeIcon(to: nil)
            }
        }
        
        let userNotifCenter = UNUserNotificationCenter.current()
        userNotifCenter.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, err) in
            if granted {
                let notifContent = UNMutableNotificationContent()
                let userName = (UserDefaults.standard.object(forKey: "user_name") as? String) ?? ""
                
                notifContent.title = "Hi \(userName), have you checked Kura's diary?"
                notifContent.body = "Let’s see what Kura think of you 🤔"

                notifContent.sound = .default

                let threeDaysFromNow = Calendar.current.date(byAdding: .day, value: 3, to: Date())!
                var dateComponents = Calendar.current.dateComponents([.hour, .day, .month, .year], from: threeDaysFromNow)
                dateComponents.hour = 7
                
                let notifTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: notifContent, trigger: notifTrigger)
                
                userNotifCenter.add(request) { (error) in
                    if let err = error {
                        print("Notif error :",err)
                    }
                }
            }
        }
        
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
        
        if now >= eighteenToday  {
            print("Time is between 18.00 - 5:59")
            return true
        }
        return false
    }
    
    /// Changes app icon to the given icon name, set nil to reset the app icon to the default app icon
    func changeIcon(to name: String?, completion: (() -> Void)? = nil) {
        guard UIApplication.shared.supportsAlternateIcons else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            UIApplication.shared.setAlternateIconName(name) { (error) in
                if let error = error {
                    print("Error changing icon: \(error)")
                }
                completion?()
            }
        }
        
//        let tempVC = TempViewController()
//        tempVC.modalPresentationStyle = .overCurrentContext
//
//        present(tempVC, animated: false, completion: {
//            tempVC.dismiss(animated: false, completion: {
//                if let completion = completion {
//                    completion()
//                }
//            })
//        })
    }
}
