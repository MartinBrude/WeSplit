//
//  TipTextField.swift
//  WeSplit
//
//  Created by Martin Brude on 8/3/26.
//

import SwiftUI

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
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
						amountIsFocus = false
					}
					.sensoryFeedback(.impact(weight: .light), trigger: amountIsFocus) { old, new in
						old == true && new == false
					}
				}
			}
	}
}
