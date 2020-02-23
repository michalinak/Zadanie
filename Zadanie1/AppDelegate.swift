//
//  AppDelegate.swift
//  Zadanie1
//
//  Created by Michalina Kukielko on 22/02/2020.
//  Copyright © 2020 Michalina Kukielko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureMainWindow()
        return true
    }
    
    private func configureMainWindow() {
        guard
            let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first
                as? UINavigationController,
            let masterViewController = leftNavController.viewControllers.first
                as? MasterTableViewController,
            let detailViewController =
            (splitViewController.viewControllers.last as? UINavigationController)?
                .topViewController as? DetailViewController
            else { fatalError() }
        
        masterViewController.delegate = detailViewController
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
    }
}

