//
//  AppDelegate.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 14/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let userNotifCenter = UNUserNotificationCenter.current()
    var dateComponents = DateComponents()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        userNotifCenter.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, err) in
            if granted {
                print("Local notif")
                self.addNotif(hour: 17, minute: 47)
//                self.addNotif(hour: 12)
//                self.addNotif(hour: 17)
            }
        }
        return true
    }
    
    // Req Permission Push Notif
    func requestPushNotifAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        userNotifCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let err = error {
                print("Error : ", err)
            }
        }
        print("Hello")
    }
    
    // ADD notif
    func addNotif(hour: Int, minute: Int) {
            let notifContent = UNMutableNotificationContent()
            
            notifContent.title = "I Have New Questions For You 👀"
            notifContent.body = "Go Check 'Em Out!"
            notifContent.sound = .default
            
            dateComponents.hour = hour
            dateComponents.minute = minute
//            dateComponents.second = second
            // Triggers
            let notifTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: notifContent, trigger: notifTrigger)
            
            userNotifCenter.add(request) { (error) in
                if let err = error {
                    print("Notif error :",err)
                }
            }
        }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "MC3_14_ProjectKura")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

