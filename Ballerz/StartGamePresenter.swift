//
//  StartGamePresenter.swift
//  Ballerz
//
//  Created by Calum Harris on 13/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class StartGamePresenter: NSObject {

	unowned let view: StartGameView

	init(view: StartGameView) {
		self.view = view
	}

	func didTapStartButton() {
		NotificationCenter.default.post(name: Notification.Name(Const.NotificationIDs.HideViews), object: nil)
	}

	func viewLoaded() {
		NotificationCenter.default.addObserver(self, selector: #selector(StartGamePresenter.showViews), name: Notification.Name(Const.NotificationIDs.ShowViews), object: nil)
	}

	func showViews() {
		view.allViews(toHide: false)
	}

}
