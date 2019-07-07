//
//  AppDelegate.swift
//  PokeApp
//
//  Created by marcenuk on 06/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = UIViewController()
        homeViewController.view.backgroundColor = UIColor.red
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        return true
    }
}
