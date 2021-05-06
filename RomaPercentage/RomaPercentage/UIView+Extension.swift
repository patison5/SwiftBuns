//
//  UIView+Extension.swift
//  RomaPercentage
//
//  Created by Fedor Penin on 06.05.2021.
//

import UIKit

extension UIView {

	/// Сделать слепок вью
	/// - Returns: фотография вью
	func takeScreenShoot() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
		drawHierarchy(in: self.bounds, afterScreenUpdates: true)
		let img = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		guard let image = img else { return UIImage() }
		return image
	}
}
