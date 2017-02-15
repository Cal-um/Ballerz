//
//  LeaderBoardViewController.swift
//  BallerTest
//
//  Created by Calum Harris on 13/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {

	let boardStackView: LeaderboardStackView = {
		let view = LeaderboardStackView.instanceFromNib()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	let backgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.leaderboardBlue()
		view.layer.cornerRadius = 10
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.clear
		view.addSubview(backgroundView)
		view.addSubview(boardStackView)
		setupConstraints()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		let models = [HighScoreModel(name: "mootiosnkajsbcskjbaksjc", score: 20), HighScoreModel(name: "moot", score: 12)]
		boardStackView.configureWith(model: models)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			boardStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			boardStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),

			backgroundView.topAnchor.constraint(equalTo: boardStackView.topAnchor, constant: -20),
			backgroundView.leadingAnchor.constraint(equalTo: boardStackView.leadingAnchor, constant: 0),
			backgroundView.trailingAnchor.constraint(equalTo: boardStackView.trailingAnchor, constant: 0),
			backgroundView.bottomAnchor.constraint(equalTo: boardStackView.bottomAnchor, constant: 20)
		])
	}
}
