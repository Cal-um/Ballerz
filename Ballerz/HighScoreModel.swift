//
//  HighScoreModel.swift
//  Ballerz
//
//  Created by Calum Harris on 14/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

class HighScoreModel: NSObject, NSCoding {
	let name: String
	let score: Int

	init(name: String, score: Int) {
		self.name = name
		self.score = score
	}

	func encode(with aCoder: NSCoder) {
		aCoder.encode(self.name, forKey: "name")
		aCoder.encode(self.score, forKey: "score")
	}

	required convenience init?(coder: NSCoder) {
		guard let name = coder.decodeObject(forKey: "name") as? String else { return nil }
		let score = coder.decodeInteger(forKey: "score")
		self.init(name: name, score: score)
	}
}

extension HighScoreModel {
	static func == (lhs: HighScoreModel, rhs: HighScoreModel) -> Bool {
		return lhs.score == rhs.score && lhs.name == rhs.name
	}
}
