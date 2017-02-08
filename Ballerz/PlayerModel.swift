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
	let id: Int
	let picURL: String
}

extension PlayerModel: Equatable {
	static func ==(lhs: PlayerModel, rhs: PlayerModel) -> Bool {
		return lhs.id == rhs.id
	}
}
