//
//  LeaderBoardPresenter.swift
//  Ballerz
//
//  Created by Calum Harris on 15/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

class LeaderBoardPresenter {

	unowned let view: LeaderboardView

	init(leaderboardView: LeaderboardView) {
		self.view = leaderboardView
	}

	func loadScores() {
		let scoreBoard = ScoreboardModel.loadHighScores()?.getHighScoresSorted()
		view.boardStackView.configureWith(model: scoreBoard ?? [HighScoreModel]())
	}

}
