//
//  RootViewController.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

	let player1 = PlayerModel(name: "Stephen Curry", points: 47.94303797468354, playerID: 1, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9524.png")
	let player2 = PlayerModel(name: "Draymond Green", points: 38.9604938271605, playerID: 2, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/15860.png")
	let player3 = PlayerModel(name: "Damian Lillard", points: 39.37866666666667, playerID: 3, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/20848.png")
	let player4 = PlayerModel(name: "Hassan Whiteside", points: 35.75342465753425, playerID: 4, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/12363.png")
	let player5 = PlayerModel(name: "Klay Thompson", points: 30.839999999999996, playerID: 5, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/14509.png")
	let player6 = PlayerModel(name: "Kyle Lowry", points: 38.5974025974026, playerID: 6, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9535.png")
	let player7 = PlayerModel(name: "Dwyane Wade", points: 31.43783783783784, playerID: 7, picURL: "https://d17odppiik753x.cloudfront.net/playerimages/nba/9585.png")
	
	var game: GuessingGame!
	
	override func viewDidLoad() {
		let players = [player1, player2, player3, player4, player5, player6]
		let model = GuessingGameModel(players: players)
		game = GuessingGame(model: model)
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		switch indexPath.row {
		case 0:
			cell.textLabel?.text = game.currentCardsInPlay?.0.name
		case 1:
			cell.textLabel?.text = game.currentCardsInPlay?.1.name
		default:
			fatalError("incorrect")
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		tableView.beginUpdates()
		
		guard let cardIndex = CardsInPlayIndex(rawValue: indexPath.row) else { fatalError("there should only be 2 indicies") }
		
		switch game.processRound(choice: cardIndex) {
		case .correct(let rowToRemove, let roundStatus):
			if case .endOfGame(let score) = roundStatus {
				print(score)
				break
			} else {
				tableView.deleteRows(at: [IndexPath(row: rowToRemove.rawValue, section: 0)], with: .left)
				tableView.insertRows(at: [IndexPath(row: rowToRemove.rawValue, section: 0)], with: .left)
			}
		case .incorrect(let roundStatus):
			if case .endOfGame(let score) = roundStatus {
				print(score)
				break
			} else {
				tableView.deleteRows(at: [IndexPath(row: CardsInPlayIndex.top.rawValue, section: 0)], with: .left)
				tableView.deleteRows(at: [IndexPath(row: CardsInPlayIndex.bottom.rawValue, section: 0)], with: .left)
				tableView.insertRows(at: [IndexPath(row: CardsInPlayIndex.top.rawValue, section: 0)], with: .left)
				tableView.insertRows(at: [IndexPath(row: CardsInPlayIndex.bottom.rawValue, section: 0)], with: .left)
			}
		}
		tableView.endUpdates()
	}
}
