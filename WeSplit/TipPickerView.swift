//
//  TipPickerView.swift
//  WeSplit
//
//  Created by Martin Brude on 8/3/26.
//
import SwiftUI

struct TipPickerView: View {
	let percentages: [Int]
	@Binding var selection: Int // @Binding permite la comunicación bidireccional

	var body: some View {
		Section("How much do you want to tip?") {
			Picker("Tip percentage", selection: $selection) {
				ForEach(percentages, id: \.self) {
					Text($0, format: .percent)
				}
			}
			.pickerStyle(.navigationLink)
		}
	}
}


