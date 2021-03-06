//
//  PageViewPresenter.swift
//  BallerTest
//
//  Created by Calum Harris on	13/02/2017.
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
		isMusicPlayingForImage()
	}

	func hideViews() {
		view.allViews(toHide: true)
	}

	func isMusicPlayingForImage() {
		let music = MusicPlayer.shared
		if music.isRKellyPlaying() {
			view.toggleSoundButtonImage(musicIsOn: true)
		} else {
			view.toggleSoundButtonImage(musicIsOn: false)
		}
	}

	func toggleSound() {
		let music = MusicPlayer.shared
		if music.isRKellyPlaying() {
			music.stopRKelly()
			view.toggleSoundButtonImage(musicIsOn: false)
		} else {
			music.resumeRKelly()
			view.toggleSoundButtonImage(musicIsOn: true)
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
