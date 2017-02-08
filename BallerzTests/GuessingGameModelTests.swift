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

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

	func testGuessingGameModelProperties() {
		let urlString = "www.google.com"
		let player1 = PlayerModel(name: "Charizard", points: 22.3333, id: 1, picURL: urlString)
		let player2 = PlayerModel(name: "Charmeleon", points: 10.9999, id: 2, picURL: urlString)
		let player3 = PlayerModel(name: "Squirtle", points: 100.88, id: 3, picURL: urlString)
		let playerArray = [player1, player2, player3]
		let guessingGameModel = GuessingGameModel(players: playerArray)
		XCTAssert(guessingGameModel.players.count == 3)
		XCTAssert(guessingGameModel.currentRound == 1)
		XCTAssert(guessingGameModel.currentScore == 0)
		// Test that players are shuffled
		XCTAssert(guessingGameModel.players != playerArray)
	}

}
