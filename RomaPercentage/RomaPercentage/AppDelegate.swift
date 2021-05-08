//
//  AppDelegate.swift
//  RomaPercentage
//
//  Created by Fedor Penin on 05.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let tutorialCenter = TCenterViewController()

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = tutorialCenter
		window?.makeKeyAndVisible()

		return true
	}
}

