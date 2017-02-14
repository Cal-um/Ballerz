//
//  PageViewPresenter.swift
//  BallerTest
//
//  Created by Calum Harris on 06/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class PageViewPresenter: NSObject {

	let controllers: [UIViewController]
	unowned let view: RootPageView

	var firstVC: UIViewController {
		return controllers[0]
	}

	init(controllers: [UIViewController], view: RootPageView) {
		self.controllers = controllers
		self.view = view
		super.init()
		registerNotifications()
	}

	func registerNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(PageViewPresenter.hideViews), name: Notification.Name(Const.NotificationIDs.HideViews), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(PageViewPresenter.showViews), name: Notification.Name(Const.NotificationIDs.ShowViews), object: nil)
	}

	func showViews() {
		view.allViews(toHide: false)
	}

	func hideViews() {
		view.allViews(toHide: true)
	}

	func toggleSound() {
		let music = MusicPlayer.shared
		if music.isRKellyPlaying() {
			music.stopRKelly()
			view.toggleSoundButtonImage(on: false)
		} else {
			music.resumeRKelly()
			view.toggleSoundButtonImage(on: true)
		}
	}
}

extension PageViewPresenter: UIPageViewControllerDataSource {

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIdx = controllers.index(of: viewController) else { return nil }
		let nextIdx = viewControllerIdx + 1
		guard nextIdx != controllers.count else { return nil }
		guard controllers.count > nextIdx else { return nil }
		return controllers[nextIdx]
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIdx = controllers.index(of: viewController) else { return nil }
		let previousIdx = viewControllerIdx - 1
		guard previousIdx >= 0 else { return nil }
		return controllers[previousIdx]
	}
}
