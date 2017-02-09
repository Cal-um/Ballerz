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
	var currentCardsInPlay: (PlayerModel, PlayerModel)!

	init(model: GuessingGameModel) {
		self.model = model
	}

}
