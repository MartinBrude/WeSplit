//
//  ContentView.swift
//  WeSplit
//
//  Created by Martin Brude on 2/12/23.
//

import SwiftUI

struct ContentView: View {
	let tipPercentages = Array(0..<101)
	@State private var checkAmount = 0.10
	@AppStorage("numberOfPeople") private var numberOfPeople = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocus: Bool
	
	var totalPerPerson: Double {
		let peopleCount = max(1, Double(numberOfPeople))
		let tipSelection = Double(tipPercentage)
		let tipValue = checkAmount / 100 * tipSelection
		let grandTotal = checkAmount + tipValue
		let amountPerPerson = grandTotal / peopleCount
		return amountPerPerson
	}
	
	var grandTotal: Double {
		checkAmount + (checkAmount * Double(tipPercentage) / 100)
	}
	
	private var currencyCode: String { Locale.current.currency?.identifier ?? "USD" }
	
	var body: some View {
		ZStack {
			LinearGradient(
				colors: [Color.blue.opacity(0.75), Color.purple.opacity(0.35)],
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)
			.ignoresSafeArea()
			
			NavigationStack {
				Form {
					Section {
						TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
							.keyboardType(.decimalPad)
							.focused($amountIsFocus)
						Text(totalPerPerson, format: .currency(code: currencyCode))
						Stepper("People: \(numberOfPeople)", value: $numberOfPeople, in: 1...99)
					}
					Section("How much do you want to tip?") {
						TipPickerView(percentages: tipPercentages, selection: $tipPercentage)
					}
					Section {
						Text(totalPerPerson, format: .currency(code: currencyCode))
							.foregroundColor(tipPercentage == 0 ? .red : .primary)
					}
				}
				.scrollContentBackground(.hidden)
				.background(.clear)
				.navigationTitle("WeSplit")
				.toolbar {
					if amountIsFocus {
						Button("Done") {
							amountIsFocus = false
						}
					}
				}
				.toolbarBackground(.hidden, for: .navigationBar)
			}
		}
	}
}

#Preview {
	ContentView()
}


