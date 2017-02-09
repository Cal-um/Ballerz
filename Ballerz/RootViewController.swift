//
//  RootViewController.swift
//  Ballerz
//
//  Created by Calum Harris on 08/02/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

	var names = ("Mootaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "Bowmore")

	override func viewDidLoad() {
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		switch indexPath.row {
		case 0:
			cell.textLabel?.text = names.0
		case 1:
			cell.textLabel?.text = names.1
		default:
			fatalError("incorrect")
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		tableView.beginUpdates()
		tableView.deleteRows(at: [indexPath], with: .left)
		switch indexPath.row {
		case 0:
			names.0 = "Gerty"
		case 1:
			names.1 = "Mordicai"
		default:
			fatalError("Incorrect")
		}
		tableView.insertRows(at: [indexPath], with: .left)
		tableView.endUpdates()
	}
}
