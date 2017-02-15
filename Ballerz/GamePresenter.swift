//
//  GamePresenter.swift
//  Ballerz
//
//  Created by Calum Harris on 12/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class GamePresenter: NSObject {

	var game: GuessingGame? = nil
	unowned let gameView: GameView
	let scoreBoard: ScoreboardModel

	init(gameView: GameView) {
		self.gameView = gameView
		scoreBoard = ScoreboardModel.loadHighScores() ?? ScoreboardModel()
	}

	func downloadPlayers() {
		WebService().load(resource: parsePlayers(withURL: Const.URLs.Players)) { [unowned self] result in

			switch result {
			case .success(let players):
				DispatchQueue.main.async {
					let model = GuessingGameModel(players: players)
					self.game = GuessingGame(model: model)
					self.gameView.beginGame()
				}
			case .failure(let error):
				if case .noInternetConnection = error {
					self.gameView.noInternetConnection()
				}
			}
		}
	}

	func isMusicPlayingForImage() {
		let music = MusicPlayer.shared
		if music.isRKellyPlaying() {
			gameView.toggleSoundButtonImage(musicIsOn: true)
		} else {
			gameView.toggleSoundButtonImage(musicIsOn: false)
		}
	}

	func toggleSound() {
		let music = MusicPlayer.shared
		if music.isRKellyPlaying() {
			music.stopRKelly()
			gameView.toggleSoundButtonImage(musicIsOn: false)
		} else {
			music.resumeRKelly()
			gameView.toggleSoundButtonImage(musicIsOn: true)
		}
	}

	func backButtonTapped() {
		NotificationCenter.default.post(name: Notification.Name(Const.NotificationIDs.ShowViews), object: nil)
	}

	func logHighScore(name: String, highScore: Int) {
		scoreBoard.insertNewHighScore(new: HighScoreModel(name: name, score: highScore))
	}
}

extension GamePresenter: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return game != nil ? 2 : 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PlayerCardTableViewCell else { fatalError("Wrong cell type") }
		guard let cardsInPlay = game?.currentCardsInPlay else { fatalError("Cards not dealt within game") }

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

	// MARK :- tableView Delegate
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.bounds.height * 0.5
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		tableView.beginUpdates()

		guard let game = game else { fatalError("game not initialised") }
		guard let cardIndex = CardsInPlayIndex(rawValue: indexPath.row) else { fatalError("there should only be 2 indicies") }

		switch game.processRound(choice: cardIndex) {
		case .correct(let rowToRemove, let roundStatus):
			gameView.anumatePointsChange(answer: true)
			if case .endOfGame(let score) = roundStatus {
				if scoreBoard.isHighScore(score: score) {
					gameView.displayHighScoreAlert(score: score)
				}
				gameView.gameEnded(score: score)
				break
			} else {
				guard let correctCell = tableView.cellForRow(at: rowToRemove.opposite().indexPathSectionZero()) as? PlayerCardTableViewCell else { fatalError("Wrong cell type") }
				correctCell.showPoints()
				tableView.deleteRows(at: [rowToRemove.indexPathSectionZero()], with: .left)
				tableView.insertRows(at: [rowToRemove.indexPathSectionZero()], with: .left)
				gameView.newRound(round: game.model.currentRound, score: game.model.currentScore)
			}
		case .incorrect(let roundStatus):
			gameView.anumatePointsChange(answer: false)
			if case .endOfGame(let score) = roundStatus {
				if scoreBoard.isHighScore(score: score) {
					gameView.displayHighScoreAlert(score: score)
				}
				gameView.gameEnded(score: score)
				break
			} else {
				let indexPathsForChanges = [CardsInPlayIndex.top.indexPathSectionZero(), CardsInPlayIndex.bottom.indexPathSectionZero()]
				tableView.deleteRows(at: indexPathsForChanges, with: .left)
				tableView.insertRows(at: indexPathsForChanges, with: .left)
				gameView.newRound(round: game.model.currentRound, score: game.model.currentScore)

			}
		}
		tableView.endUpdates()
	}
}
