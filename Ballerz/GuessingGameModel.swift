//
//  GuessingGameModel.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

final class GuessingGameModel {

	private(set) var currentScore = 0
	private(set) var currentRound = 1
	private(set) var players: [PlayerModel]

	init(players: [PlayerModel]) {
		self.players = players.shuffled()
	}
}
