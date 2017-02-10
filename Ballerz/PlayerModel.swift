//
//  PlayerModel.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

struct PlayerModel {
	let name: String
	let points: Double
	let playerID: Int
	let picURL: String

	init(name: String, points: Double, playerID: Int, picURL: String) {
		self.name = name
		self.points = points
		self.playerID = playerID
		self.picURL = picURL
	}

	init?(dictionary: JSONDictionary) {

		guard let name = dictionary["full_name"] as? String, let id = dictionary["id"] as? Int, let points = dictionary["points"] as? Double, let picURL = dictionary["profile_picture_url"] as? String else { return nil }

		self.name = name
		self.points = points
		self.playerID = id
		self.picURL = picURL
	}
}

extension PlayerModel: Equatable {
	static func == (lhs: PlayerModel, rhs: PlayerModel) -> Bool {
		return lhs.playerID == rhs.playerID
	}
}
