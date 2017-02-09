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
			let players = [player1, player2, player3, player4, player5, player6, player7]
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
}