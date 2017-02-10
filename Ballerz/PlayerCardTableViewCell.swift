//
//  PlayerCardTableViewCell.swift
//  Ballerz
//
//  Created by Calum Harris on 10/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class PlayerCardTableViewCell: UITableViewCell {

	@IBOutlet weak var roundedBackgroundView: UIView!
	@IBOutlet weak var playerImage: NetworkImageView!
	@IBOutlet weak var playerName: UILabel!
	@IBOutlet weak var pointsLabel: UILabel!
}
