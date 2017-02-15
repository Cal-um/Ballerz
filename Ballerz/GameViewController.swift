//
//  GameViewController.swift
//  Ballerz
//
//  Created by Calum Harris on 12/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

	var gamePresenter: GamePresenter!
	var	basketBallConstraints: [NSLayoutConstraint]?
	@IBOutlet weak var roundsLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	@IBOutlet weak var basketBall: UIImageView!
	@IBOutlet weak var pointsLabel: UILabel!
	@IBOutlet weak var pointsNameLabel: UILabel!
	@IBOutlet weak var soundButton: UIButton!
	@IBOutlet weak var pointsAnimateLabel: UILabel!
	@IBOutlet weak var pointsAnimateConstraint: NSLayoutConstraint!

	override func viewDidLoad() {
		gamePresenter.downloadPlayers()
		basketBallConstraints = createConstrToBeAnimated()
		configureTableView()
		gamePresenter.isMusicPlayingForImage()
		preGameLayout()
	}

	@IBAction func tapSoundButton(_ sender: Any) {
		gamePresenter.toggleSound()
	}

	@IBAction func tapBackButton(_ sender: Any) {
		gamePresenter.backButtonTapped()
		self.dismiss(animated: true, completion: nil)
	}

	func configureTableView() {
		tableView.isScrollEnabled = false
		tableView.separatorStyle = .none
		self.tableView.register(UINib(nibName: "PlayerCardTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
		tableView.delegate = gamePresenter
		tableView.dataSource = gamePresenter

	}

	func preGameLayout() {
		spinner.startAnimating()
		tableView.isHidden = true
		roundsLabel.text = "BALLERZ"
		pointsAnimateLabel.isHidden = true
		guard let ballConst = basketBallConstraints else { fatalError("constraints not configured") }
		NSLayoutConstraint.activate(ballConst)
	}

	func gameLayout() {
		spinner.stopAnimating()
		tableView.isHidden = false
		newRound(round: 1, score: 0)

	}

	func postGameLayout() {
		tableView.isHidden = true
		NSLayoutConstraint.deactivate(basketBallConstraints!)
	}

	func createConstrToBeAnimated() -> [NSLayoutConstraint] {
		return [basketBall.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
		       basketBall.widthAnchor.constraint(equalTo: basketBall.heightAnchor),
		       basketBall.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
		       basketBall.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)]
	}

	func animateEndOfGameScore() {

		NSLayoutConstraint.activate([
			basketBall.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			basketBall.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			basketBall.widthAnchor.constraint(equalTo: basketBall.heightAnchor),
			basketBall.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
			])
		pointsLabel.isHidden = true
		pointsNameLabel.isHidden = true
		pointsLabel.font = UIFont(name: "menlo", size: 29)
		pointsNameLabel.font = UIFont(name: "menlo", size: 19)

		UIView.animate(withDuration: 2, animations: {
			self.view.layoutIfNeeded()
		}, completion: { _ in
			self.pointsNameLabel.isHidden = false
			self.pointsLabel.isHidden = false
		})
	}
}

extension GameViewController: GameView {

	func anumatePointsChange(answer: Bool) {
		pointsAnimateConstraint.constant = 0
		view.layoutIfNeeded()
		pointsAnimateLabel.isHidden = false

		if answer {
			pointsAnimateLabel.text = "+3"
			pointsAnimateLabel.textColor = .green
		} else {
			pointsAnimateLabel.text = "-3"
			pointsAnimateLabel.textColor = .red
		}

		pointsAnimateConstraint.constant = -300

		UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
			self.view.layoutIfNeeded()
		}, completion: { _ in
			self.pointsAnimateLabel.isHidden = true
		})
	}

	func beginGame() {
		print("game has begun")
		gameLayout()
		tableView.reloadData()
	}

	func newRound(round: Int, score: Int) {
		roundsLabel.text = "ROUND \(round)"
		pointsLabel.text = String(score)
	}

	func gameEnded(score: Int) {
		pointsLabel.text = String(score)
		postGameLayout()
		animateEndOfGameScore()
	}

	func noInternetConnection() {
		displayNoInternetAlert()
	}

	func toggleSoundButtonImage(musicIsOn: Bool) {
		if musicIsOn {
			soundButton.setImage(UIImage(named:"Sound_On"), for: .normal)
		} else {
			soundButton.setImage(UIImage(named: "Sound_Mute"), for: .normal)
		}
	}
}

extension GameViewController {

	// MARK :- Alert controllers

	func displayHighScoreAlert(score: Int) {

		let alert = UIAlertController(title: "You have a high score!", message: "Enter your name", preferredStyle: .alert)

		let logHighScoreAction = UIAlertAction(title: "Ok", style: .default) { [weak alert] _ in
			if let alert = alert {
				let nameTextField = alert.textFields![0] as UITextField
				self.gamePresenter.logHighScore(name: nameTextField.text!, highScore: score)
			}
		}

		logHighScoreAction.isEnabled = false

		let cancelAction = UIAlertAction(title: "No thanks", style: .cancel, handler: nil)

		alert.addTextField { textField in
			textField.placeholder = "Name"
			NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { notification in
				logHighScoreAction.isEnabled = textField.text != ""
			}
		}

		alert.addAction(logHighScoreAction)
		alert.addAction(cancelAction)
		present(alert, animated: true, completion: nil)
	}

	func displayNoInternetAlert() {
		let alert = UIAlertController(title: "Whoops", message: "No internet connection detected", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
			self.gamePresenter.backButtonTapped()
			self.dismiss(animated: true, completion: nil)
		}
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}

	func displaySaveFailureAlert() {
		let alert = UIAlertController(title: "Could not save", message: "Please check available data", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
}
