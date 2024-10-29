//
//  RxRelay.swift
//  Blood pressure level
//
//  Created by mix on 29.10.2024.
//

import RxCocoa
import RxSwift
import SwiftUI

@propertyWrapper
struct RxRelay<Value>: DynamicProperty {

	
	@State private var value: Value

	@State private var isSubscribed = false

	private let relay: BehaviorRelay<Value>

	private let disposeBag: DisposeBag

	var wrappedValue: Value {
		get { value }
		set {
			value = newValue
			relay.accept(newValue)
		}
	}

	init(relay: BehaviorRelay<Value>, disposeBag: DisposeBag) {
		self.relay = relay
		self.disposeBag = disposeBag
		_value = State(initialValue: relay.value)
	}

	func update() {
		if !isSubscribed {
			subscribeToRelay()
		}
	}

	private func subscribeToRelay() {
		relay
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { newValue in
				DispatchQueue.main.async {
					value = newValue
				}
			})
			.disposed(by: disposeBag)

		DispatchQueue.main.async {
			isSubscribed = true
		}
	}
}
