//
//  PostSettingRowView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/22/24.
//

import SwiftUI

struct PostSettingRowView: View {
    let model: PostSettingModel
    
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
    PostSettingRowView(model: .delete)
}
