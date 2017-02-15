//
//  PlayerCardTableViewCell.swift
//  Ballerz
//
//  Created by Calum Harris on 10/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class PlayerCardTableViewCell: UITableViewCell {

	@IBOutlet weak var blurImage: UIImageView!
	@IBOutlet weak var roundedBackgroundView: UIView!
	@IBOutlet weak var playerImage: NetworkImageView!
	@IBOutlet weak var playerName: UILabel!
	@IBOutlet weak var pointsLabel: UILabel!

	func configureCellWith(player: PlayerModel) {
		blurImage.isHidden = false
		pointsLabel.isHidden = true
		roundedBackgroundView.layer.cornerRadius = 20
		playerImage.loadImageUsingUrlString(urlString: player.picURL)
		pointsLabel.text = player.pointsForCard()
		playerName.text = player.name
		self.selectionStyle = .none
	}

	func showPoints() {
		blurImage.isHidden = true
		pointsLabel.isHidden = false
	}
}
