//
//  App.swift
//  Ballerz
//
//  Created by Calum Harris on 13/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class App {
	
	// This is where the app is assembled. The idea is to keep view controllers unaware of eachother and configure the classes in a MVP pattern.

	init(window: UIWindow) {
		window.rootViewController = setInitialViewController()
		window.makeKeyAndVisible()
		MusicPlayer.shared.playRKelly()
	}

	func setInitialViewController() -> UIViewController {
		let pageViewController = RootPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
		let controllers = [assembleStartGameViewController(), assembleLeaderboardViewController()]
		let presenter = PageViewPresenter(controllers: controllers, view: pageViewController)
		pageViewController.presenter = presenter
		return pageViewController
	}

	func assembleStartGameViewController() -> UIViewController {
		let startGameViewController = StartGameViewController()
		let presenter = StartGamePresenter(view: startGameViewController)
		startGameViewController.presenter = presenter
		startGameViewController.tapAction = {
			let gameViewController = self.assembleGameViewController()
			gameViewController.modalPresentationStyle = .overFullScreen
			gameViewController.modalTransitionStyle = .crossDissolve
			startGameViewController.present(gameViewController, animated: true, completion: nil)
		}
		return startGameViewController
	}

	func assembleLeaderboardViewController() -> UIViewController {
		let leaderboardController = LeaderBoardViewController()
		let presenter = LeaderBoardPresenter(leaderboardView: leaderboardController)
		leaderboardController.presenter = presenter
		return leaderboardController
	}

	func assembleGameViewController() -> UIViewController {
		let gameViewController = GameViewController()
		let presenter = GamePresenter(gameView: gameViewController)
		gameViewController.gamePresenter = presenter
		return gameViewController
	}
}
