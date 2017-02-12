//
//  RootViewController.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

	var game: GuessingGame!

	override func viewDidLoad() {
		tableView.isScrollEnabled = false
		tableView.separatorStyle = .none
		//tableView.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		self.tableView.register(UINib(nibName: "PlayerCardTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
		web()
	}

	func web() {
		WebService().load(resource: parsePlayers(withURL: Const.URLs.Players)) { result in

			if case .success(let array) = result {
				DispatchQueue.main.async {
					let model = GuessingGameModel(players: array)
					self.game = GuessingGame(model: model)
					self.tableView.reloadData()
				}
			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return game != nil ? 2 : 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PlayerCardTableViewCell else { fatalError("Wrong cell type") }
		guard let cardsInPlay = game.currentCardsInPlay else { fatalError("Cards not dealt within game") }

		switch indexPath.row {
		case 0:
			cell.configureCellWith(player: cardsInPlay.0)
		case 1:
			cell.configureCellWith(player: cardsInPlay.1)
		default:
			fatalError("incorrect index")
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return view.bounds.height * 0.3
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		tableView.beginUpdates()

		guard let cardIndex = CardsInPlayIndex(rawValue: indexPath.row) else { fatalError("there should only be 2 indicies") }

		switch game.processRound(choice: cardIndex) {
		case .correct(let rowToRemove, let roundStatus):
			if case .endOfGame(let score) = roundStatus {
				print("END OF GAME : SCORE\(score)")
				break
			} else {
				print(rowToRemove.rawValue)
				guard let correctCell = tableView.cellForRow(at: rowToRemove.opposite().indexPathSectionZero()) as? PlayerCardTableViewCell else { fatalError("Wrong cell type") }
				correctCell.blurImage.isHidden = true
				correctCell.pointsLabel.isHidden = false
				tableView.deleteRows(at: [rowToRemove.indexPathSectionZero()], with: .left)
				tableView.insertRows(at: [rowToRemove.indexPathSectionZero()], with: .left)
			}
		case .incorrect(let roundStatus):
			if case .endOfGame(let score) = roundStatus {
				print("END OF GAME : SCORE\(score)")
				break
			} else {
				let indexPathsForChanges = [CardsInPlayIndex.top.indexPathSectionZero(), CardsInPlayIndex.bottom.indexPathSectionZero()]
				tableView.deleteRows(at: indexPathsForChanges, with: .left)
				tableView.insertRows(at: indexPathsForChanges, with: .left)
			}
		}
		tableView.endUpdates()
	}
}
