//
//  ScoreboardModel.swift
//  Ballerz
//
//  Created by Calum Harris on 14/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

class ScoreboardModel: NSObject, NSCoding {

	var highScores: [HighScoreModel]

	init(modelArray: [HighScoreModel] = []) {
		self.highScores = modelArray
	}

	func encode(with aCoder: NSCoder) {
		aCoder.encode(self.highScores, forKey: "HighScores")
	}

	required convenience init?(coder: NSCoder) {
		guard let highScores = coder.decodeObject(forKey: "HighScores") as? [HighScoreModel] else { return nil }
		self.init(modelArray: highScores)
	}

	func isHighScore(score: Int) -> Bool {
		guard score >= 1 else { return false }
		guard highScores.count > 4 else { return true }
		let sort = getHighScoresSorted()
		let lowestHighScore = sort.last!.score
		return score > lowestHighScore
	}

	func getHighScoresSorted() -> [HighScoreModel] {
		return highScores.sorted(by: { $0.score > $1.score })
	}

	func insertNewHighScore(new: HighScoreModel) {
		if highScores.count > 4 {
			highScores.sort(by: { $0.score > $1.score })
			highScores.removeLast()
			highScores.append(new)
		} else {
			highScores.append(new)
		}
		for i in highScores {
			print(i.score)
		}
		let resultBool = saveScoreBoard()
		print(resultBool)
	}

	func saveScoreBoard() -> Bool {
		let url = URL.documentsURL.path.appending("/scores")
		return NSKeyedArchiver.archiveRootObject(self, toFile: url)
	}

	static func loadHighScores() -> ScoreboardModel? {
		let url = URL.documentsURL.path.appending("/scores")
		guard let scoreBoard = NSKeyedUnarchiver.unarchiveObject(withFile: url) as? ScoreboardModel else { return nil }
		return scoreBoard
	}
}
