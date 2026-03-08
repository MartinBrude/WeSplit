//
//  TipTextField.swift
//  WeSplit
//
//  Created by Martin Brude on 8/3/26.
//

import SwiftUI
import UIKit

struct TipTextField: View {
	@Binding var checkAmount: Double
	@FocusState.Binding var amountIsFocus: Bool
	let currencyCode: String

	var body: some View {
		TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
			.keyboardType(.decimalPad)
			.focused($amountIsFocus)
			.submitLabel(.done)
			.onSubmit { amountIsFocus = false }
			.accessibilityLabel("Check amount")
			.accessibilityHint(checkAmount < 0 ? "Amount cannot be negative" : "")
			.foregroundStyle(checkAmount < 0 ? .red : .primary)

			.onSubmit {
				amountIsFocus = false
			}
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
						amountIsFocus = false
						// When done editing:
						UIImpactFeedbackGenerator(style: .light).impactOccurred()
					}
				}
			}
	}
}
