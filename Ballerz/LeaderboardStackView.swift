//
//  LeaderboardStackView.swift
//  BallerTest
//
//  Created by Calum Harris on 13/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

class LeaderboardStackView: UIStackView {

	@IBOutlet weak var name1Label: UILabel!
	@IBOutlet weak var name2Label: UILabel!
	@IBOutlet weak var name3Label: UILabel!
	@IBOutlet weak var name4Label: UILabel!
	@IBOutlet weak var name5Label: UILabel!
	@IBOutlet weak var score1Label: UILabel!
	@IBOutlet weak var score2Label: UILabel!
	@IBOutlet weak var score3Label: UILabel!
	@IBOutlet weak var score4Label: UILabel!
	@IBOutlet weak var score5Label: UILabel!

	class func instanceFromNib() -> LeaderboardStackView {
		return UINib(nibName: "Leaderboard", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LeaderboardStackView
	}

	func configureWith(model: [HighScoreModel]) {
		name1Label.text = model[safe: 0]?.name ?? "-:-:-"
		name2Label.text = model[safe: 1]?.name ?? "-:-:-"
		name3Label.text = model[safe: 2]?.name ?? "-:-:-"
		name4Label.text = model[safe: 3]?.name ?? "-:-:-"
		name5Label.text = model[safe: 4]?.name ?? "-:-:-"
		score1Label.text = model[safe: 0]?.score != nil ? String(model[0].score) : "-:-:-"
		score2Label.text = model[safe: 1]?.score != nil ? String(model[1].score) : "-:-:-"
		score3Label.text = model[safe: 2]?.score != nil ? String(model[2].score) : "-:-:-"
		score4Label.text = model[safe: 3]?.score != nil ? String(model[3].score) : "-:-:-"
		score5Label.text = model[safe: 4]?.score != nil ? String(model[4].score) : "-:-:-"
	}
}
