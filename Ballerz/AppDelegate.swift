//
//  AppDelegate.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		window = window ?? UIWindow()
		window?.rootViewController = RootViewController()
		window?.makeKeyAndVisible()
		return true
	}
}
