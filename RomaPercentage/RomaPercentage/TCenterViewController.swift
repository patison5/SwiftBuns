//
//  TCenterViewController.swift
//  RomaPercentage
//
//  Created by Fedor Penin on 05.05.2021.
//

import UIKit

class TCenterViewController: UIViewController {

	// MARK: - Private properties

	private let whiteView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()

	private let blueView: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		return view
	}()

	private let redView: UIView = {
		let view = UIView()
		view.backgroundColor = .red
		return view
	}()

	private let greenView: UIView = {
		let view = UIView()
		view.backgroundColor = .green
		return view
	}()

	private let yelloView: UIView = {
		let view = UIView()
//		view.backgroundColor = .yellow
		return view
	}()

	// MARK: - Override

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .cyan

		setupUserInterface()
		setupConstraints()

		let redGesture = UITapGestureRecognizer(target: self, action:  #selector(self.showAlert))
		redView.addGestureRecognizer(redGesture)

		let blueGesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.showAlert))
		blueView.addGestureRecognizer(blueGesture2)

		let whiteGesture = UITapGestureRecognizer(target: self, action:  #selector(self.showAndCloseAlert))
		whiteView.addGestureRecognizer(whiteGesture)

		let greenGesture = UITapGestureRecognizer(target: self, action:  #selector(self.showAndCloseAlert))
		greenView.addGestureRecognizer(greenGesture)

		let yellowGesture = UITapGestureRecognizer(target: self, action:  #selector(self.showAndCloseAlert))
		yelloView.addGestureRecognizer(yellowGesture)
	}

	@objc func showAlert(sender : UITapGestureRecognizer) {
		guard let senderView = sender.view else { return }
		TutorialCenter.shared.showAlert(container: view, target: senderView, title: "that is a pannel title", message: "That is a panel description!")
	}

	@objc func showAndCloseAlert(sender : UITapGestureRecognizer) {
		guard let senderView = sender.view else { return }
		TutorialCenter.shared.showAlert(container: view, target: senderView, title: "that is a pannel title", message: "That is a panel description! There could be a lot of text! yeah, yeah, let's write more text!")
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			TutorialCenter.shared.closeAlert()
		}
	}

	// MARK: - Private methods

	private func setupUserInterface() {
		[whiteView, blueView, redView, greenView, yelloView].forEach {
			view.addSubview($0)
		}
	}

	private func setupConstraints() {
		whiteView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
		blueView.frame = CGRect(x: 40, y: 300, width: 200, height: 100)
		redView.frame = CGRect(x: 80, y: 500, width: 200, height: 100)
		greenView.frame = CGRect(x: 280, y: 250, width: 100, height: 50)
		yelloView.frame = CGRect(x: 290, y: 750, width: 100, height: 50)

		[whiteView, blueView, redView, greenView, yelloView].forEach {
			let label = UILabel()
			label.text = "click on me"
			label.textAlignment = .center
			label.frame = $0.bounds
			$0.addSubview(label)
		}
	}
}

