//
//  SettingRowView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/15/24.
//

import SwiftUI

struct SettingsRowView: View {
    let model: SettingsModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: model.imageName)
                .imageScale(.medium)
            
            Text(model.title)
                .font(.subheadline)
        }
    }
}

#Preview {
    SettingsRowView(model: .saved)
}
