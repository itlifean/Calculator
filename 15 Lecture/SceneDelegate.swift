//
//  SceneDelegate.swift
//  15 Lecture
//
//  Created by Ana Oganesiani on 27.10.24.
//
// სცენის დელეგატი, რომელიც მართავს ფანჯრის კონფიგურაციას და ნავიგაციას აპლიკაციაში

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?  // აპლიკაციის მთავარი ფანჯარა
    
    // ფუნქცია, რომელიც იძახება სცენის კონფიგურაციის დროს
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)  // ფანჯრის შექმნა და მისი მითითება
        let rootViewController = CalculatorViewController()  // კალკულატორის მთავარი ViewController
        let navController = UINavigationController(rootViewController: rootViewController)  // ნავიგაციის კონტროლერის შექმნა
        window?.rootViewController = navController  // ნავიგაციის კონტროლერის მითითება როგორც rootViewController
        window?.makeKeyAndVisible()  // ფანჯრის ხილვადობის გააქტიურება
    }

    // ფუნქცია, რომელიც იძახება, როდესაც სცენა იჭრება (თითქმის არასდროს იძახება iOS აპლიკაციაში)
    func sceneDidDisconnect(_ scene: UIScene) {}

    // ფუნქცია, რომელიც იძახება, როდესაც აპლიკაცია აქტიურ მდგომარეობაში გადადის
    func sceneDidBecomeActive(_ scene: UIScene) {}

    // ფუნქცია, რომელიც იძახება, როდესაც აპლიკაცია გადადის არაიმოქმედ მდგომარეობაში (მაგალითად, ზარის შემოსვლის დროს)
    func sceneWillResignActive(_ scene: UIScene) {}

    // ფუნქცია, რომელიც იძახება, როდესაც აპლიკაცია შედის წინა პლანზე
    func sceneWillEnterForeground(_ scene: UIScene) {}

    // ფუნქცია, რომელიც იძახება, როდესაც აპლიკაცია გადადის უკანა პლანზე (მაგალითად, home ღილაკზე დაჭერისას)
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
