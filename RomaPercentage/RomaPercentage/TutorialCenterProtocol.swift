//
//  TutorialCenterProtocol.swift
//  RomaPercentage
//
//  Created by Fedor Penin on 06.05.2021.
//

import UIKit

/// Протокол центра обучения
protocol TutorialCenterProtocol {

	/// Синглтон
	static var shared: TutorialCenterProtocol { get }

	/// Показать Алерт
	/// - Parameters:
	///   - container: Родительский контейнер
	///   - target: Объект описания
	///   - title: Заголовок сообщения
	///   - message: Текст сообщения
	func showAlert(container: UIView, target: UIView, title: String, message: String)
}
