//
//  HighScoreModel.swift
//  Ballerz
//
//  Created by Calum Harris on 14/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

struct HighScoreModel {
	let name: String
	let score: Int
}

extension HighScoreModel: Equatable {
	static func == (lhs: HighScoreModel, rhs: HighScoreModel) -> Bool {
		return lhs.score == rhs.score && lhs.name == rhs.name
	}
}
