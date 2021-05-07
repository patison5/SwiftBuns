//
//  ViewController.swift
//  RomaPercentage
//
//  Created by Fedor Penin on 05.05.2021.
//

import UIKit

class ViewController: UIViewController {

	// MARK: - Private properties

	private let whiteView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()

	private let blueView: UIView = {
		let view = UIView()
		view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
		view.backgroundColor = .blue
		return view
	}()

	private let redView: UIView = {
		let view = UIView()
		view.backgroundColor = .red
		return view
	}()

	private let blueLabel: UILabel = {
		let text = UILabel()
		text.text = "Putin"
		text.textAlignment = .center
//		text.backgroundColor = .green
		text.textColor = .white
		return text
	}()

	private let blueLabel2: UILabel = {
		let text = UILabel()
		text.text = "Fuck you"
		text.textAlignment = .center
//		text.backgroundColor = .green
		text.textColor = .white
		return text
	}()

	// MARK: - Override

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .cyan

		addViews()
		setupViews()

		let redGesture = UITapGestureRecognizer(target: self, action:  #selector(self.redAction))
		redView.addGestureRecognizer(redGesture)

		let blueGesture = UITapGestureRecognizer(target: self, action:  #selector(self.blueAction))
		blueLabel.addGestureRecognizer(blueGesture)

		let blueGesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.blueAction2))
		blueView.addGestureRecognizer(blueGesture2)

		let whiteGesture = UITapGestureRecognizer(target: self, action:  #selector(self.whiteAction))
		whiteView.addGestureRecognizer(whiteGesture)
	}

	@objc func redAction(sender : UITapGestureRecognizer) {
		TutorialCenter.shared.showAlert(container: view, target: redView, title: "hello 1", message: "hey red bitches!")
	}

	@objc func blueAction(sender : UITapGestureRecognizer) {
		TutorialCenter.shared.showAlert(container: view, target: blueLabel, title: "hello 2", message: "hey blue bitches!")
	}

	@objc func blueAction2(sender : UITapGestureRecognizer) {
		TutorialCenter.shared.showAlert(container: view, target: blueLabel2, title: "hello 2", message: "hey blue bitches!")
	}

	@objc func whiteAction(sender : UITapGestureRecognizer) {
		TutorialCenter.shared.showAlert(container: view, target: whiteView, title: "hello 3", message: "hey white bitches!")
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			TutorialCenter.shared.closeAlert()
		}
	}

	// MARK: - Private methods

	private func addViews() {
		[whiteView, blueView, redView].forEach {
			view.addSubview($0)
//			$0.translatesAutoresizingMaskIntoConstraints = false
		}

		whiteView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
		blueView.frame = CGRect(x: 40, y: 300, width: 200, height: 100)
		redView.frame = CGRect(x: 80, y: 500, width: 200, height: 100)
		blueView.addSubview(blueLabel)
		blueLabel.frame = .init(x: 30, y: 50, width: 100, height: 50)
		blueLabel.translatesAutoresizingMaskIntoConstraints = true

		blueView.addSubview(blueLabel2)
		blueLabel2.frame = .init(x: 250, y: 50, width: 100, height: 50)
		blueLabel2.translatesAutoresizingMaskIntoConstraints = true
	}

	private func setupViews() {
		NSLayoutConstraint.activate([
//			whiteView.topAnchor.constraint(equalTo: view.topAnchor),
//			whiteView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
//			whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//
//			blueView.topAnchor.constraint(equalTo: whiteView.bottomAnchor),
//			blueView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
//			blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//
//			redView.topAnchor.constraint(equalTo: blueView.bottomAnchor),
//			redView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
//			redView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

