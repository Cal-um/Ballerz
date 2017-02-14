//
//  MusicPlayer.swift
//  Ballerz
//
//  Created by Calum Harris on 14/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import AVFoundation

final class MusicPlayer: NSObject {

	static let shared = MusicPlayer()
	var audioPlayer: AVAudioPlayer?

	func playRKelly() {
		let fileName = "ICanFly.mp3"
		guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
			print("Could not find file")
			return
		}

		do {
			try audioPlayer = AVAudioPlayer(contentsOf: url)
		} catch {
			print(error.localizedDescription)
			return
		}

		audioPlayer?.numberOfLoops = 10
		audioPlayer?.prepareToPlay()
		audioPlayer?.play()
	}

	func stopRKelly() {
		if let player = audioPlayer {
			if player.isPlaying {
				player.pause()
			}
		}
	}

	func resumeRKelly() {
		if let player = audioPlayer {
			if !player.isPlaying {
				player.play()
			}
		}
	}

	func isRKellyPlaying() -> Bool {
		if let player = audioPlayer {
			return player.isPlaying
		} else {
			return false
		}
	}
}
