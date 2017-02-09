//
//  GuessingGameTests.swift
//  Ballerz
//
//  Created by Calum Harris on 09/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import XCTest
@testable import Ballerz
class GuessingGameTests: XCTestCase {

		var game: GuessingGame!

    override func setUp() {
        super.setUp()
			let player1 = PlayerModel(name: "Stephen Curry", points: 47.94303797468354, playerID: 1, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9524.png")
			let player2 = PlayerModel(name: "Draymond Green", points: 38.9604938271605, playerID: 2, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/15860.png")
			let player3 = PlayerModel(name: "Damian Lillard", points: 39.37866666666667, playerID: 3, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/20848.png")
			let player4 = PlayerModel(name: "Hassan Whiteside", points: 35.75342465753425, playerID: 4, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/12363.png")
			let player5 = PlayerModel(name: "Klay Thompson", points: 30.839999999999996, playerID: 5, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/14509.png")
			let player6 = PlayerModel(name: "Kyle Lowry", points: 38.5974025974026, playerID: 6, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9535.png")
			let player7 = PlayerModel(name: "Dwyane Wade", points: 31.43783783783784, playerID: 7, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9585.png")
			let player8 = PlayerModel(name: "Dwyane", points: 31.43783783783783, playerID: 8, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9585.png")
			let players = [player1, player2, player3, player4, player5, player6, player7, player8]
			let model = GuessingGameModel(players: players)
			game = GuessingGame(model: model)
    }

    override func tearDown() {
        super.tearDown()
    }

	func testProperties() {
		XCTAssert(game.correctPoints == 3)
		XCTAssert(game.incorrectPoints == -3)
	}

	func testProcessTwoPlayerDeal() {
		XCTAssert(game.currentCardsInPlay != nil)
		while game.model.players.count > 1 {
			let _ = game.processTwoPlayerDeal()
		}
		let status = game.processTwoPlayerDeal()

		switch status {
		case .endOfGame(finalScore: ):
			XCTAssert(true)
		default:
			XCTAssert(false)
		}
	}

	func testProcessOnePlayerDeal() {
		let initialTop = game.currentCardsInPlay?.0
		let _ = game.processOnePlayerDeal(to: .top)
		let newTop = game.currentCardsInPlay?.0
		XCTAssert(initialTop != newTop)

		let initialBotton = game.currentCardsInPlay?.1
		let _ = game.processOnePlayerDeal(to: .bottom)
		let newBottom = game.currentCardsInPlay?.1
		XCTAssert(initialBotton != newBottom)

		while game.model.players.count > 0 {
			let _ = game.processOnePlayerDeal(to: .top)
		}
		let status = game.processOnePlayerDeal(to: .top)

		switch status {
		case .endOfGame(finalScore: _):
			XCTAssert(true)
		default: XCTAssert(false)
		}
	}

	func testHighestCardInPlay() {
		let highestCard = game.highestCardInPlay()
		let currentCardsInPlay = game.currentCardsInPlay!

		switch highestCard {
		case .top:
			if currentCardsInPlay.0.points > currentCardsInPlay.1.points {
				XCTAssert(true)
			} else {
				XCTAssert(false)
			}
		case .bottom:
			if currentCardsInPlay.1.points > currentCardsInPlay.0.points {
				XCTAssert(true)
			} else {
				XCTAssert(false)
			}
		}
	}
}
