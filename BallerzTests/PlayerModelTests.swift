//
//  PlayerModelTests.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import XCTest
@testable import Ballerz

class PlayerModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

	func testPlayerModel() {
		let testName = "baller"
		let testPoints = 34.555544
		let testPicURL = "www.google.com"
		let pModel = PlayerModel(name: testName, points: testPoints, id: 1, picURL: testPicURL)
		XCTAssert(pModel.name == testName)
		XCTAssert(pModel.points == testPoints)
		XCTAssert(pModel.picURL == testPicURL)
		XCTAssert(pModel.id == 1)
	}
}
