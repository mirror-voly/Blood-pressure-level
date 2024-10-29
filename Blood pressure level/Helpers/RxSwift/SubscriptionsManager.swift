//
//  SubscriptionsManager.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import RxSwift

final class SubscriptionsManager {
	static let shared = SubscriptionsManager()

	private(set) var disposeBag = DisposeBag()

	private init() {}

	func add(_ disposable: Disposable) {
		disposable.disposed(by: disposeBag)
	}

	func reset() {
		disposeBag = DisposeBag()
	}
}
