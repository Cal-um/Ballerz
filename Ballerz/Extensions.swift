//
//  Extensions.swift
//  BallerTest
//
//  Created by Calum Harris on 13/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//
// swiftlint:disable force_try

import UIKit

extension UIView {
	func startRotationContinuously(withDutation: Double) {
		let continousAnimationKey = "infinateRotation"

		if self.layer.animation(forKey: continousAnimationKey) == nil {
			let animation = CABasicAnimation(keyPath: "transform.rotation")
			animation.duration = withDutation
			animation.fromValue = 0.0
			animation.toValue = 2 * Float.pi
			animation.repeatCount = Float.infinity
			self.layer.add(animation, forKey: continousAnimationKey)
		}
	}

	func endRotationContinously() {
		let continousAnimationKey = "infinateRotation"

		if self.layer.animation(forKey: continousAnimationKey) != nil {
			self.layer.removeAnimation(forKey: continousAnimationKey)
		}
	}
}

extension UIColor {
	static func backgroundBlue() -> UIColor {
		return UIColor(red: 137/255, green: 187/255, blue: 230/255, alpha: 1)
	}

	static func leaderboardBlue() -> UIColor {
		return UIColor(red: 73/255, green: 135/255, blue: 183/255, alpha: 0.9)
	}
}

extension URL {

	static var documentsURL: URL {
		return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
	}
}

extension Array {
	subscript (safe index: Int) -> Element? {
		return indices ~= index ? self[index] : nil
	}
}
