//
//  TutorialCenter.swift
//  RomaPercentage
//
//  Created by Fedor Penin on 05.05.2021.
//

import UIKit

final class TutorialCenter {
	
	// MARK: - TutorialCenterProtocol properties
	
	static var shared: TutorialCenterProtocol = TutorialCenter()

	// MARK: - Private properties
	
	private var container: UIView?
	private var target: UIView?
	private let triangleShapeLayer = CAShapeLayer()

	private let minimumHeight: CGFloat = 100.0

	private var alertTopAnchor: NSLayoutConstraint?
	private var whiteBackgroundTopAnchor: NSLayoutConstraint?
	private var whiteBackgroundBottomAnchor: NSLayoutConstraint?
	
	private let alertContainer = UIView()
	
	private let whiteBackground: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 15.0
		view.layer.masksToBounds = true
		return view
	}()
	
	private lazy var darkBackground: DarkBackground = {
		let view = DarkBackground()
		view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4664942782)
		return view
	}()
	
	private let titleLabel: UILabel = {
		let title = UILabel()
		title.text = "hello bitch"
		return title
	}()
	
	private let messageLabel: UILabel = {
		let message = UILabel()
		message.text = "fuck you, motherfucker"
		message.textColor = .black
		message.numberOfLines = 0
		message.textAlignment = .center
		return message
	}()
	
	private var targetImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	// MARK: - Init
	
	private init() {}
}

extension TutorialCenter: TutorialCenterProtocol {

	func showAlert(container: UIView, target: UIView, title: String, message: String) {
		self.container = container
		self.target = target
		titleLabel.text = title
		messageLabel.text = message
		setupUserInterface()
		setupConstraints()
	}
}

// MARK: - Private methods

private extension TutorialCenter {
	
	func setupUserInterface() {
		container?.addSubview(darkBackground)
		container?.addSubview(targetImageView)
		
		container?.addSubview(alertContainer)
		alertContainer.addSubview(whiteBackground)
		whiteBackground.addSubview(messageLabel)
		
		[alertContainer, whiteBackground, messageLabel].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
	
	func setupConstraints() {
		guard let controllerView = container, let target = target else { return }

		let screenShoot = target.takeScreenShoot()
		
		targetImageView.frame = target.superview?.convert(target.frame, to: controllerView) ?? .zero
		targetImageView.image = screenShoot
		
		darkBackground.frame = controllerView.frame
		
		NSLayoutConstraint.activate([
			alertContainer.widthAnchor.constraint(equalTo: controllerView.widthAnchor, multiplier: 0.8),
			alertContainer.centerXAnchor.constraint(equalTo: controllerView.centerXAnchor),
			
			whiteBackground.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor),
			whiteBackground.trailingAnchor.constraint(equalTo: alertContainer.trailingAnchor),
			whiteBackground.topAnchor.constraint(equalTo: alertContainer.topAnchor, constant: 10),
			whiteBackground.bottomAnchor.constraint(equalTo: alertContainer.bottomAnchor, constant: -10),
			
			messageLabel.leadingAnchor.constraint(equalTo: whiteBackground.leadingAnchor, constant: 10),
			messageLabel.trailingAnchor.constraint(equalTo: whiteBackground.trailingAnchor, constant: -10),
			messageLabel.topAnchor.constraint(equalTo: whiteBackground.topAnchor, constant: 32),
			messageLabel.bottomAnchor.constraint(equalTo: whiteBackground.bottomAnchor, constant: -32),
		])
		let triangleOnTop = target.frame.origin.y + target.frame.height + minimumHeight > controllerView.bounds.height
		if triangleOnTop {
			NSLayoutConstraint.activate([
				alertContainer.topAnchor.constraint(greaterThanOrEqualTo: controllerView.safeAreaLayoutGuide.topAnchor, constant: 0),
				alertContainer.bottomAnchor.constraint(equalTo: target.topAnchor, constant: 0),
			])
		} else {
			NSLayoutConstraint.activate([
				alertContainer.topAnchor.constraint(equalTo: target.bottomAnchor, constant: 0),
				alertContainer.bottomAnchor.constraint(lessThanOrEqualTo: controllerView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
			])
		}
		controllerView.setNeedsLayout()
		controllerView.layoutIfNeeded()
		triangleShapeLayer.path = triangleShapePath(view: alertContainer, onTop: !triangleOnTop).cgPath
		triangleShapeLayer.lineWidth = 4
		triangleShapeLayer.lineCap = .round
		triangleShapeLayer.fillColor = UIColor.white.cgColor
		alertContainer.layer.addSublayer(triangleShapeLayer)
		
		darkBackground.completion = { [weak self] in
			[self?.alertContainer, self?.targetImageView, self?.darkBackground].compactMap { $0 }.forEach {
				$0.removeFromSuperview()
			}
		}
	}

	func triangleShapePath(view: UIView, onTop: Bool) -> UIBezierPath {
		let width: CGFloat = 15.0
		let height: CGFloat = 10.0
		
		guard let controllerView = container, let target = target else { return UIBezierPath() }
	
		let frame = target.superview?.convert(target.frame, to: controllerView) ?? .zero
		let trianglePath = UIBezierPath()
		let size = view.bounds.size
		let offsetX: CGFloat = (controllerView.frame.width - size.width) / 2
		var x: CGFloat = (frame.origin.x + frame.width / 2) - width / 2 - offsetX
		var y: CGFloat = height

		if x < width { x = width }
		if x > view.bounds.width - width*2 { x = view.bounds.width - width*2 }

		if onTop {
			trianglePath.move(to: CGPoint(x: x, y: y))
			trianglePath.addLine(to: CGPoint(x: x + width, y: y))
			trianglePath.addLine(to: CGPoint(x: x + width / 2, y: y - height))
		} else {
			y = size.height - height
			trianglePath.move(to: CGPoint(x: x, y: y))
			trianglePath.addLine(to: CGPoint(x: x + width, y: y))
			trianglePath.addLine(to: CGPoint(x: x + width / 2, y: y + height))
		}
		
		trianglePath.close()
		return trianglePath
	}
}

final class DarkBackground: UIView {

	var completion: (() -> Void)?

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		completion?()
	}
}
