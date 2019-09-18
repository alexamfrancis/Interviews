//
//  AppDelegate.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/16/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        return UIWindow(frame: UIScreen.main.bounds)
    }()
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let collectionViewController = TriggerCollectionViewController(nibName: nil, bundle: nil)
        collectionViewController.view.backgroundColor = .white
        collectionViewController.viewDidLoad()
        self.window?.rootViewController = collectionViewController
        self.window?.makeKeyAndVisible()

        return true
    }

}
