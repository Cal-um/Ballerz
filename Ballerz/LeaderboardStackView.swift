//
//  LeaderboardStackView.swift
//  BallerTest
//
//  Created by Calum Harris on 07/02/2017.
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
}
