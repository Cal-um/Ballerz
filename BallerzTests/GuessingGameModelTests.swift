//
//  GuessingGameModelTests.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import XCTest
@testable import Ballerz

class GuessingGameModelTests: XCTestCase {

	var model: GuessingGameModel!
	var players: [PlayerModel]!

	override func setUp() {
		super.setUp()
		let player1 = PlayerModel(name: "Stephen Curry", points: 47.94303797468354, playerID: 1, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9524.png")
		let player2 = PlayerModel(name: "Draymond Green", points: 38.9604938271605, playerID: 2, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/15860.png")
		let player3 = PlayerModel(name: "Damian Lillard", points: 39.37866666666667, playerID: 3, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/20848.png")
		let player4 = PlayerModel(name: "Hassan Whiteside", points: 35.75342465753425, playerID: 4, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/12363.png")
		let player5 = PlayerModel(name: "Klay Thompson", points: 30.839999999999996, playerID: 5, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/14509.png")
		let player6 = PlayerModel(name: "Kyle Lowry", points: 38.5974025974026, playerID: 6, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9535.png")
		let player7 = PlayerModel(name: "Dwyane Wade", points: 31.43783783783784, playerID: 7, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9585.png")
		// Do not change the number of items in intial players array
		players = [player1, player2, player3, player4, player5, player6, player7]
		model = GuessingGameModel(players: players)
	}

    override func tearDown() {
        super.tearDown()
    }

	func testGuessingGameModelProperties() {
		XCTAssert(model.players.count == 7)
		XCTAssert(model.currentRound == 1)
		XCTAssert(model.currentScore == 0)
		// Test that players are shuffled
		XCTAssert(model.players != players)
	}

	func testAddToScore() {
		XCTAssert(model.currentScore == 0)
		model.addToCurrentScore(points: 10)
		XCTAssert(model.currentScore == 10)
	}

	func testRemoveFromScore() {
		XCTAssert(model.currentScore == 0)
		model.removeFromCurrentScore(points: 10)
		XCTAssert(model.currentScore == -10)
	}

	func testDealTwoPlayers() {
		let initialCount = model.players.count
		let firstPop = model.players[model.players.count - 1]
		let secondPop = model.players[model.players.count - 2]
		let deal = model.dealTwoPlayers()
		if case let .play2(result) = deal {
			XCTAssert(result.0 == firstPop)
			XCTAssert(result.1 == secondPop)
			XCTAssert(model.players.count == initialCount - 2)
		} else {
			XCTAssert(false)
		}

		while model.players.count > 1 {
			let _ = model.dealTwoPlayers()
		}

		model.addToCurrentScore(points: 3)
		let lowDeal = model.dealTwoPlayers()

		if case let .endOfGame(points) = lowDeal {
			XCTAssert(points == 3)
		} else {
			XCTAssert(false)
		}
	}

	func testDeal1Player() {
		let initialCount = model.players.count
		let pop = model.players[model.players.count - 1]
		let deal = model.dealOnePlayer()
		if case let .play1(result) = deal {
			XCTAssert(result == pop)
			XCTAssert(model.players.count == initialCount - 1)
		} else {
			XCTAssert(false)
		}

		while model.players.count > 0 {
			let _ = model.dealOnePlayer()
		}

		let lowDeal = model.dealOnePlayer()

		if case let .endOfGame(points) = lowDeal {
			XCTAssert(model.currentScore == points)
		} else {
			XCTAssert(false)
		}
	}
}
