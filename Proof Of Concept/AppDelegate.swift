//
//  AppDelegate.swift
//  Proof Of Concept
//
//  Created by Raghu on 21/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController: ViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }

}

