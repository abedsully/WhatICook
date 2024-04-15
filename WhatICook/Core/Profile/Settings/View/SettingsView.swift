//
//  SettingsView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/15/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var selectedOption: SettingsModel?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            ForEach(SettingsModel.allCases) { model in
                SettingsRowView(model: model)
                    .onTapGesture {
                        selectedOption = model
                        dismiss()
                    }
            }
        }
        .listStyle(PlainListStyle())
        .padding(.vertical)
    }
}

#Preview {
    SettingsView(selectedOption: .constant(nil))
}
