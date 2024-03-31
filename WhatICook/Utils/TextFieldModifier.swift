//
//  TextFieldModifier.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .foregroundColor(Constant.textColor)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray5), lineWidth: 1)
                    .padding(.horizontal, 24)// Adjust the width as needed
            )
            .fixedSize(horizontal: false, vertical: true) 
    }
}
