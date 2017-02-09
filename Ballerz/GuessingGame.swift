//
//  GuessingGame.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

final class GuessingGame {

	let correctPoints = 3
	let incorrectPoints = -3
	let model: GuessingGameModel
	var currentCardsInPlay: (PlayerModel, PlayerModel)?

	init(model: GuessingGameModel) {
		self.model = model
		processTwoPlayerDeal()
	}

	func processTwoPlayerDeal() {
		let deal = model.dealTwoPlayers()
		switch  deal {
		case .play2(let player0, let player1):
			currentCardsInPlay = (player0, player1)
		case .endOfGame(score: _):
			currentCardsInPlay = nil
			print("end of game")
		default:
			fatalError("This should not be possible")
		}
	}

	func processOnePlayerDeal(to index: CardsInPlayIndex) {
		let deal = model.dealOnePlayer()

		switch deal {
		case .play1(let player):
			switch index {
			case .top:
				currentCardsInPlay?.0 = player
			case .bottom:
				currentCardsInPlay?.1 = player
			}
		case .endOfGame(score: _):
			currentCardsInPlay = nil
			print("end of game")
		default:
			fatalError("This should not be possible")
		}
	}

	func highestCardInPlay() -> CardsInPlayIndex {
		guard let currentCardsInPlay = currentCardsInPlay else { fatalError("This method cannot be used with no cards in play") }
		// It seems unlikely that the points will be equal so we will return .top for now in the event.
		if currentCardsInPlay.0.points >= currentCardsInPlay.1.points {
			return .top
		} else {
			return .bottom
		}
	}
}

enum CardsInPlayIndex: Int {
	case top
	case bottom
}
