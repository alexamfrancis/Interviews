//
//  AppDelegate.swift
//  Bathroom Fan
//
//  Created by Alexa Francis on 5/22/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        guard let window = self.window else {
            print("fuck false")
            return false
        }
        let viewController = ViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        return true

    }
}

