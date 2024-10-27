//
//  AppDelegate.swift
//  15 Lecture
//
//  Created by Ana Oganesiani on 27.10.24.
//
// აპლიკაციის დელეგატის კლასი, რომელიც მართავს აპლიკაციის პროცესებს


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?

   func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       window = UIWindow(frame: UIScreen.main.bounds)
       let rootViewController = CalculatorViewController()
       let navController = UINavigationController(rootViewController: rootViewController)
       window?.rootViewController = navController
       window?.makeKeyAndVisible()
       return true
   }
}
