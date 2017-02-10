//
//  GuessingGame.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

typealias TwoCards = (PlayerModel, PlayerModel)

final class GuessingGame {

	let correctPoints = 3
	let incorrectPoints = -3
	let model: GuessingGameModel
	var currentCardsInPlay: TwoCards? {
		didSet {
			print("TOP: \(currentCardsInPlay!.0.name) Points: \(currentCardsInPlay!.0.points) BOTTOM: \(currentCardsInPlay!.1.name) Points: \(currentCardsInPlay!.1.points)")
		}
	}

	init(model: GuessingGameModel) {
		self.model = model
		let _ = processTwoPlayerDeal()
	}

	func processRound(choice: CardsInPlayIndex) -> Answer {

		if choice == highestCardInPlay() {
			print("CORRECT")
			model.addToCurrentScore(points: correctPoints)
			let roundStatus = processOnePlayerDeal(to: choice.opposite())

			if case .play = roundStatus {
				model.advanceRound()
			}

			switch choice {
			case .top:
				print("TOP")
				return .correct(remove: .bottom, roundStatus)
			case .bottom:
				print("BOTTOM")
				return .correct(remove: .top, roundStatus)
			}

		} else {
			model.removeFromCurrentScore(points: incorrectPoints)
			let roundStatus = processTwoPlayerDeal()

			if case .play = roundStatus {
				model.advanceRound()
			}

			return .incorrect(roundStatus)
		}
	}

	func processTwoPlayerDeal() -> RoundStatus {
		let deal = model.dealTwoPlayers()
		switch  deal {
		case .play2(let player0, let player1):
			currentCardsInPlay = (player0, player1)
			return .play
		case .emptyDeck(let score):
			return .endOfGame(finalScore: score)
		default:
			fatalError("This should not be possible")
		}
	}

	func processOnePlayerDeal(to index: CardsInPlayIndex) -> RoundStatus {
		let deal = model.dealOnePlayer()

		switch deal {
		case .play1(let player):
			switch index {
			case .top:
				currentCardsInPlay?.0 = player
			case .bottom:
				currentCardsInPlay?.1 = player
			}
			return .play
		case .emptyDeck(let score):
			return(.endOfGame(finalScore: score))
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

	func opposite() -> CardsInPlayIndex {
		switch self {
		case .top:
			return .bottom
		case .bottom:
			return .top
		}
	}
}

enum Answer {
	case correct(remove: CardsInPlayIndex, RoundStatus)
	case incorrect(RoundStatus)
}

enum RoundStatus {
	case play
	case endOfGame(finalScore: Int)
}
