//
//  LeaderBoardModelTests.swift
//  Ballerz
//
//  Created by Calum Harris on 14/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import XCTest
@testable import Ballerz

class LeaderBoardModelTests: XCTestCase {

	var leaderBoardModelFull: ScoreboardModel!
	var leaderBoardModelEmpty: ScoreboardModel!
	var leaderBoardModelPartial: ScoreboardModel!

	override func setUp() {
		super.setUp()
		let hS1 = HighScoreModel(name: "Mordicai", score: 12)
		let hS2 = HighScoreModel(name: "Bowmore", score: 15)
		let hS3 = HighScoreModel(name: "Gerty", score: 20)
		let hS4 = HighScoreModel(name: "Moota", score: 30)
		let hS5 = HighScoreModel(name: "Sencha", score: 5)
		let model = [hS1, hS2, hS3, hS4, hS5]
		leaderBoardModelFull = ScoreboardModel(modelArray: model)
		leaderBoardModelEmpty = ScoreboardModel()
		leaderBoardModelPartial = ScoreboardModel(modelArray: [hS2, hS4])
	}

	func testIsHighScore() {
		XCTAssert(leaderBoardModelFull.isHighScore(score: 2) == false)
		XCTAssert(leaderBoardModelFull.isHighScore(score:31) == true)
		XCTAssert(leaderBoardModelEmpty.isHighScore(score: 1))
		XCTAssert(leaderBoardModelEmpty.isHighScore(score: -19) == false)
		XCTAssert(leaderBoardModelPartial.isHighScore(score: 16))
	}

	func testInsertNewHighScore() {
		let newScore16 = HighScoreModel(name: "Bob", score: 16)
		let newScore40 = HighScoreModel(name: "George", score: 40)
		leaderBoardModelFull.insertNewHighScore(new: newScore16)
		XCTAssert(leaderBoardModelFull.highScores.contains(newScore16))
		XCTAssert(!leaderBoardModelFull.highScores.contains(where: { $0.score == 5 }))
		XCTAssert(leaderBoardModelFull.highScores.count == 5)
		leaderBoardModelFull.insertNewHighScore(new: newScore40)
		XCTAssert(leaderBoardModelFull.highScores.contains(newScore40))
		XCTAssert(!leaderBoardModelFull.highScores.contains(where: { $0.score == 12 }))
		XCTAssert(leaderBoardModelFull.getHighScoresSorted().first == newScore40)
		leaderBoardModelEmpty.insertNewHighScore(new: newScore16)
		XCTAssert(leaderBoardModelEmpty.highScores.count == 1)
		leaderBoardModelPartial.insertNewHighScore(new: newScore16)
		leaderBoardModelPartial.insertNewHighScore(new: newScore40)
		XCTAssert(leaderBoardModelPartial.highScores.count == 4)
	}
}
