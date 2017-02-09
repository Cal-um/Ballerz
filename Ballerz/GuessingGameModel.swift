//
//  GuessingGameModel.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

final class GuessingGameModel {

	fileprivate(set) var currentScore = 0
	fileprivate(set) var currentRound = 1
	fileprivate(set) var players: [PlayerModel]

	init(players: [PlayerModel]) {
		self.players = players.shuffled()
	}
}

extension GuessingGameModel {

	func addToCurrentScore(points: Int) {
		currentScore += points
	}

	func removeFromCurrentScore(points: Int) {
		currentScore += points
	}

	func advanceRound() {
		currentRound += 1
	}

	func dealTwoPlayers() -> DealState {

		guard players.count > 1, let firstPop = players.popLast(), let secondPop = players.popLast() else { return .emptyDeck(finalScore: currentScore) }

		return .play2(firstPop, secondPop)
	}

	func dealOnePlayer() -> DealState {
		guard players.count > 0, let popPlayer = players.popLast() else { return .emptyDeck(finalScore: currentScore) }

		return .play1(popPlayer)
	}
}

enum DealState {
	case play2(TwoCards)
	case play1(PlayerModel)
	case emptyDeck(finalScore: Int)
}
