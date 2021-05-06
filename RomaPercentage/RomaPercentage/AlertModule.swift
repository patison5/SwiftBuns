//
//  AlertModule.swift
//  RomaPercentage
//
//  Created by Fedor Penin on 05.05.2021.
//

import UIKit

class AlertModule {

	// MARK: - Public properties

	static var shared: AlertModule = {
		let alert = AlertModule()
		return alert
	}()

	// MARK: - Private properties

	private var controller: UIViewController?
	private var target: UIView?
	let triangleShapeLayer = CAShapeLayer()

	let localWidth = 250.0
	let localHeight = 110.0

	private var alertTopAnchor: NSLayoutConstraint?
	private var whiteBackgroundTopAnchor: NSLayoutConstraint?
	private var whiteBackgroundBottomAnchor: NSLayoutConstraint?

	private let alertContainer: UIView = {
		let view = UIView()
		return view
	}()

	private let whiteBackground: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 15.0
		view.layer.masksToBounds = true
		return view
	}()

	private let darkBackground: UIView = {
		let view = UIView()
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

	// MARK: - Public methods

	public func setup(container: UIViewController, target: UIView, title: String, message: String) {
		self.controller = container
		self.target = target
		self.titleLabel.text = title
		self.messageLabel.text = message
	}

	public func showAlert() {
		//	snapshot
		addViews()
		setupViews()
	}
}

// MARK: - Private methods

extension AlertModule {

	private func addViews() {
		controller?.view.addSubview(darkBackground)
		controller?.view.addSubview(targetImageView)

		[alertContainer].forEach {
			controller?.view.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}

		[whiteBackground].forEach {
			alertContainer.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}

		whiteBackground.addSubview(messageLabel)
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
	}

	private func setupViews() {
		guard let controllerView = controller?.view else { return }
		guard let target = target else { return }
//		guard let targetSnapshotView = target.snapshotView(afterScreenUpdates: false) else { return }

		let screenSize: CGRect = UIScreen.main.bounds
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

		if (target.frame.origin.y + target.frame.height + CGFloat(localHeight)) > screenSize.height {
			NSLayoutConstraint.activate([
				alertContainer.topAnchor.constraint(greaterThanOrEqualTo: controllerView.safeAreaLayoutGuide.topAnchor, constant: 0),
				alertContainer.bottomAnchor.constraint(equalTo: target.topAnchor, constant: 0),
			])

			controllerView.setNeedsLayout()
			controllerView.layoutIfNeeded()
			triangleShapeLayer.path = triangleShapePath(view: alertContainer, onTop: false).cgPath
		} else {
			NSLayoutConstraint.activate([
				alertContainer.topAnchor.constraint(equalTo: target.bottomAnchor, constant: 0),
				alertContainer.bottomAnchor.constraint(lessThanOrEqualTo: controllerView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
			])

			controllerView.setNeedsLayout()
			controllerView.layoutIfNeeded()
			triangleShapeLayer.path = triangleShapePath(view: alertContainer, onTop: true).cgPath
		}

		triangleShapeLayer.lineWidth = 4
		triangleShapeLayer.lineCap = .round
		triangleShapeLayer.fillColor = UIColor.white.cgColor
		alertContainer.layer.addSublayer(triangleShapeLayer)

		let darkGesture = UITapGestureRecognizer(target: self, action:  #selector(self.closeAlertModule))
		darkBackground.addGestureRecognizer(darkGesture)
	}

	@objc func closeAlertModule(sender : UITapGestureRecognizer) {
		[alertContainer, targetImageView, darkBackground].forEach {
			$0.removeFromSuperview()
		}
	}

	private func triangleShapePath(view: UIView, onTop: Bool) -> UIBezierPath {

		/// Ширина треугольника
		let width: CGFloat = 15.0

		/// Высота треугольника
		let height: CGFloat = 10.0

		guard let controllerView = controller?.view else { return UIBezierPath() }
		guard let target = target else { return UIBezierPath() }

		// Тут чисто магия и не капли волшебства...
		let frame = target.superview?.convert(target.frame, to: controllerView) ?? .zero
		let trianglePath = UIBezierPath()
		let size = view.bounds.size
		let offsetX: CGFloat = (controllerView.frame.width - size.width) / 2
		let x: CGFloat = (frame.origin.x + frame.width / 2) - width / 2 - offsetX
		var y: CGFloat = height

		if onTop {
			trianglePath.move(to: CGPoint(x: x, y: y)) // left point
			trianglePath.addLine(to: CGPoint(x: x + width, y: y)) // right point
			trianglePath.addLine(to: CGPoint(x: x + width / 2, y: y - height)) // center point
		} else {
			y = size.height - height
			trianglePath.move(to: CGPoint(x: x, y: y)) // left point
			trianglePath.addLine(to: CGPoint(x: x + width, y: y)) // right point
			trianglePath.addLine(to: CGPoint(x: x + width / 2, y: y + height)) // center point
		}
		trianglePath.close()
		return trianglePath
	}
}

extension UIView {

	func takeScreenShoot() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
		drawHierarchy(in: self.bounds, afterScreenUpdates: true)
		let img = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		guard let image = img else { return UIImage() }
		return image
	}
}
