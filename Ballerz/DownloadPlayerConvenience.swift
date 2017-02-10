//
//  DownloadPlayerConvenience.swift
//  Ballerz
//
//  Created by Calum Harris on 09/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import Foundation

func parsePlayers(withURL: URL) -> Resource<[PlayerModel]> {

	let parse = Resource<[PlayerModel]>(url: withURL, parseJSON: { jsonData in

		guard let json = jsonData as? JSONDictionary, let sportsPeople = json["sportspeople"] as? [JSONDictionary] else { return .failure(.errorParsingJSON)  }

		let players = sportsPeople.flatMap(PlayerModel.init)
		return players.count > 0 ? .success(players) : .failure(.errorParsingJSON)
	})
	return parse
}
