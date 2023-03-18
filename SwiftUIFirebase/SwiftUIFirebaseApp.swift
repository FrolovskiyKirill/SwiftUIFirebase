//
//  SwiftUIFirebaseApp.swift
//  SwiftUIFirebase
//
//  Created by Kirill Frolovskiy on 14.03.2023.
//

import SwiftUI
import Firebase

@main
struct SwiftUIFirebaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configured Firebase!")
        
        return true
    }
}
