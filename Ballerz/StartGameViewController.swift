//
//  StartGameViewController.swift
//  BallerTest
//
//  Created by Calum Harris on 06/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {

	let ballImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "BasketBall")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	let startButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(named: "StartButtonNormal"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(StartGameViewController.didTapStartButton), for: .touchUpInside)
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.clear
		addSubviews()
		setupConstraints()
		ballImageView.startRotationContinuously(withDutation: 20)
	}

	func addSubviews() {
		view.addSubview(ballImageView)
		view.addSubview(startButton)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			// add ball constraints
			ballImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			ballImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			ballImageView.heightAnchor.constraint(equalTo: ballImageView.widthAnchor),
			ballImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
			// add button constraints
			startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			startButton.leadingAnchor.constraint(equalTo: ballImageView.leadingAnchor, constant: -50),
			startButton.trailingAnchor.constraint(equalTo: ballImageView.trailingAnchor, constant: 50),
			startButton.heightAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: 0.2)
		])
		view.layoutIfNeeded()
	}

	func didTapStartButton() {
		print("tapped")
	}
}
