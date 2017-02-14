//
//  RootPageViewController.swift
//  BallerTest
//
//  Created by Calum Harris on 05/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

class RootPageViewController: UIPageViewController {

	var presenter: PageViewPresenter!

	let topCloud: UIImageView = {
		let cloud = UIImageView()
		cloud.image = UIImage(named: "cloud")
		cloud.translatesAutoresizingMaskIntoConstraints = false
		return cloud
	}()

	let middleCloud: UIImageView = {
		let cloud = UIImageView()
		cloud.image = UIImage(named: "cloud")
		cloud.translatesAutoresizingMaskIntoConstraints = false
		return cloud
	}()

	let bottomCloud: UIImageView = {
		let cloud = UIImageView()
		cloud.image = UIImage(named: "cloud")
		cloud.translatesAutoresizingMaskIntoConstraints = false
		return cloud
	}()

	let ballerzLogo: UIImageView = {
		let logo = UIImageView()
		logo.image	= UIImage(named: "Ballerz")
		logo.translatesAutoresizingMaskIntoConstraints = false
		return logo
	}()

	let soundButton: UIButton = {
		let butt = UIButton()
		butt.setImage(UIImage(named: "Sound_On"), for: .normal)
		butt.addTarget(self, action: #selector(RootPageViewController.tappedSoundButton), for: .touchUpInside)
		butt.translatesAutoresizingMaskIntoConstraints = false
		return butt
	}()

	var topCloudLeadingConstraint: NSLayoutConstraint?
	var middleCloudLeadingConstraint: NSLayoutConstraint?
	var bottomCloudLeadingConstraint: NSLayoutConstraint?

	override func viewDidLoad() {
		super.viewDidLoad()
		self.setViewControllers([presenter.firstVC], direction: .forward, animated: false, completion: nil)
		self.dataSource = presenter
		view.backgroundColor = UIColor.backgroundBlue()
		addSubviews()
		setupInitialConstraints()
		animateClouds()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		for view in self.view.subviews {
			if view is UIScrollView {
				(view as! UIScrollView).delaysContentTouches = false
			}
		}
	}

	func tappedSoundButton() {
		print("tapped!!!")
	}

	func addSubviews() {
		view.addSubview(topCloud)
		view.addSubview(middleCloud)
		view.addSubview(bottomCloud)
		view.addSubview(ballerzLogo)
		view.sendSubview(toBack: middleCloud)
		view.addSubview(soundButton)
	}

	func setupInitialConstraints() {
		NSLayoutConstraint.activate([
			// add ballerzLogo constraints
			ballerzLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
			ballerzLogo.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20),
			// add cloud constraints
			topCloud.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
			topCloud.heightAnchor.constraint(equalTo: topCloud.widthAnchor, multiplier: 0.4),
			topCloud.topAnchor.constraint(equalTo: ballerzLogo.bottomAnchor, constant: 10),
			middleCloud.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
			middleCloud.heightAnchor.constraint(equalTo: middleCloud.widthAnchor, multiplier: 0.4),
			middleCloud.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10),
			bottomCloud.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
			bottomCloud.heightAnchor.constraint(equalTo: bottomCloud.widthAnchor, multiplier: 0.4),
			bottomCloud.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -30),
			soundButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20),
			soundButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10)
		])
		// keep reference to cloud leading constraint and add to view
		topCloudLeadingConstraint = topCloud.trailingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
		middleCloudLeadingConstraint = middleCloud.trailingAnchor.constraint(equalTo: self.view.leadingAnchor)
		bottomCloudLeadingConstraint = bottomCloud.trailingAnchor.constraint(equalTo: self.view.leadingAnchor)
		view.addConstraint(topCloudLeadingConstraint!)
		view.addConstraint(middleCloudLeadingConstraint!)
		view.addConstraint(bottomCloudLeadingConstraint!)
	}

	func animateClouds() {
		self.view.layoutIfNeeded()
		view.removeConstraint(topCloudLeadingConstraint!)
		view.addConstraint(self.topCloud.leadingAnchor.constraint(equalTo: self.view.trailingAnchor))

		UIView.animate(withDuration: 10, delay: 0, options: [.repeat, .curveLinear], animations: {
			self.view.layoutIfNeeded()
		}, completion: nil)

		view.removeConstraint(middleCloudLeadingConstraint!)
		view.addConstraint(middleCloud.leadingAnchor.constraint(equalTo: self.view.trailingAnchor))

		UIView.animate(withDuration: 10, delay: 5, options: [.repeat, .curveLinear], animations: {
			self.view.layoutIfNeeded()
		}, completion: nil)

		view.removeConstraint(bottomCloudLeadingConstraint!)
		view.addConstraint(bottomCloud.leadingAnchor.constraint(equalTo: self.view.trailingAnchor))

		UIView.animate(withDuration: 10, delay: 2, options: [.repeat, .curveLinear], animations: {
			self.view.layoutIfNeeded()
		}, completion: nil)
	}
}

extension RootPageViewController: RootPageView {
	func allViews(toHide toggle: Bool) {
		ballerzLogo.isHidden = toggle
		soundButton.isHidden = toggle
	}
}
