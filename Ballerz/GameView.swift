//
//  GameView.swift
//  Ballerz
//
//  Created by Calum Harris on 12/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

protocol GameView: class {
	func beginGame()
	func gameEnded(score: Int)
	func newRound(round: Int, score: Int)
	func noInternetConnection()
	func anumatePointsChange(answer: Bool)
	func toggleSoundButtonImage(musicIsOn: Bool)
	func displayHighScoreAlert(score: Int)
	func displaySaveFailureAlert()
}
