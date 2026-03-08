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
	@AppStorage("tipPercentage") private var tipPercentage = 20
	@FocusState private var amountIsFocus: Bool
	
	var totalPerPerson: Double {
		let peopleCount = max(1, Double(numberOfPeople))
		return grandTotal / peopleCount
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
						TipTextField(checkAmount: $checkAmount, amountIsFocus: $amountIsFocus, currencyCode: currencyCode)
						Stepper("^[\(numberOfPeople) person](inflect: true)", value: $numberOfPeople, in: 1...99)
					}
					TipPickerView(percentages: tipPercentages, selection: $tipPercentage)
					Section {
						LabeledContent("Per person") {
							Text(totalPerPerson, format: .currency(code: currencyCode))
						}
						LabeledContent("Grand total") {
							Text(grandTotal, format: .currency(code: currencyCode))
						}
					}
				}
				.scrollContentBackground(.hidden)
				.background(.clear)
				.navigationTitle("WeSplit")
				.toolbarBackground(.hidden, for: .navigationBar)
			}
		}
	}
}



#Preview {
	ContentView()
}


