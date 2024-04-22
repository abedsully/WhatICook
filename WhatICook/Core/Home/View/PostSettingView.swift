//
//  PostSettingView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/22/24.
//

import SwiftUI

struct PostSettingView: View {
    @Binding var selectedOption: PostSettingModel?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            ForEach(PostSettingModel.allCases) { model in
                PostSettingRowView(model: model)
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
    PostSettingView(selectedOption: .constant(nil))
}
